import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/core/services/image/cloudinary/cloudinary_image_service.dart';
import 'package:jom_malaysia/core/services/image/i_image_service.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/comments_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comment_form/comment_form.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class NewCommentPage extends StatefulWidget {
  NewCommentPage({
    @required this.placeId,
    @required this.placeName,
  });
  final String placeId;
  final String placeName;
  @override
  _NewCommentPageState createState() => _NewCommentPageState();
}

class _NewCommentPageState extends State<NewCommentPage> {
  CommentModel _commentModel;
  IImageService _storageService;
  CommentsProvider _commentsProvider;
  AuthUser user;

  @override
  void initState() {
    _commentsProvider = Provider.of<CommentsProvider>(context, listen: false);

    user = Provider.of<AuthProvider>(context, listen: false).user;
    var commentId = _commentsProvider.getCommentId();
    _commentModel = new CommentModel(commentId, user);
    _storageService =
        Provider.of<CloudinaryImageService>(context, listen: false);

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actionName: S.of(context).labelSubmitReview,
        onPressed: () async {
          await _handleFormSubmit(context);
        },
        backImg: "assets/images/ic_close.png",
      ),
      body: Consumer<CommentsProvider>(
        builder: (context, provider, _) =>
            provider.stateType != StateType.loading
                ? SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 16.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        child: CommentForm(
                          placeName: widget.placeName,
                          placeId: widget.placeId,
                          formKey: _formKey,
                          commentModel: _commentModel,
                        ),
                      ),
                    ),
                  )
                : StateLayout(
                    type: StateType.loading,
                    hintText: S
                        .of(context)
                        .labelStatusPublish(S.of(context).labelReview),
                  ),
      ),
    );
  }

  ///receive asset and index of image
  ///return cloudinary url
  Future<String> _saveImage(Asset asset, int index) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    var url = await _storageService.uploadFile(
        "place/${widget.placeId}/comments/${_commentModel.id}",
        imageData,
        "${_commentModel.id}-image-$index");
    return url;
  }

  Future _handleFormSubmit(BuildContext context) async {
    int _retrycount = 1;
    if (_formKey.currentState.validate()) {
      _commentsProvider.setStateType(StateType.loading);
      _formKey.currentState.save();
      if (_commentModel.imageAssets.isNotEmpty) {
        var _index = 0;
        for (Asset image in _commentModel.imageAssets) {
          var url = await _saveImage(image, _index);
          _commentModel.images.add(url);
          _index++;
        }
      }
      NavigatorUtils.goBackWithParams(
          context,
          _commentsProvider
              .addComment(widget.placeId, _commentModel)
              .then(
                (_) => SnackBar(
                  content: Text("Thank you for your review"),
                  action: SnackBarAction(
                    label: "Retry",
                    onPressed: () => _commentsProvider.addComment(
                        widget.placeId, _commentModel),
                  ),
                ),
              )
              .timeout(Duration(seconds: 2), onTimeout: () {
            if (_retrycount > 0) {
              _retrycount -= 1;
              return SnackBar(
                content: Text("Error adding your review. Try again?"),
                action: SnackBarAction(
                  label: "Retry",
                  onPressed: () => _commentsProvider.addComment(
                      widget.placeId, _commentModel),
                ),
              );
            } else
              return SnackBar(
                content: Text("Unknown error. Please try again later"),
              );
          }).catchError(
            (e) => SnackBar(content: Text(e.toString())),
          ));
    } else {
      _commentsProvider.setStateType(StateType.empty);
      showToast(S.of(context).msgPleaseFillRequiredField);
    }
  }
}
