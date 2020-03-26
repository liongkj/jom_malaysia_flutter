import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/image/cloudinary/cloudinary_image_service.dart';
import 'package:jom_malaysia/core/services/image/i_image_service.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/comments_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/add_rating_bar.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/selected_image.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:jom_malaysia/widgets/text_field_item.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class NewReviewPage extends StatefulWidget {
  NewReviewPage(
      {@required this.placeId,
      @required this.userId,
      @required this.placeName});
  final String placeId;
  final String userId;
  final String placeName;

  @override
  _NewReviewPageState createState() => _NewReviewPageState();
}

class _NewReviewPageState extends State<NewReviewPage> {
  CommentModel _commentModel;
  IImageService _storageService;
  CommentsProvider _db;
  StateType _loadingState = StateType.loading;
  @override
  void initState() {
    _db = Provider.of<CommentsProvider>(context, listen: false);
    var commentId = _db.getCommentId();
    _commentModel = new CommentModel(commentId);
    //TODO init with user id
    _storageService =
        // Provider.of<FirebaseStorageService>(context, listen: false);
        Provider.of<CloudinaryImageService>(context, listen: false);
    super.initState();
  }

  Future<String> _saveImage(Asset asset, int index) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    var url = await _storageService.uploadFile(
        "place/${widget.placeId}/comments/${_commentModel.id}",
        imageData,
        "${_commentModel.id}-image-$index");
    return url;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: MyAppBar(
        actionName: S.of(context).labelSubmitReview,
        onPressed: () async {
          _db.setStateType(StateType.loading);
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            if (_commentModel.imageAssets.isNotEmpty) {
              var _index = 0;
              for (Asset image in _commentModel.imageAssets) {
                var url = await _saveImage(image, _index);
                _commentModel.images.add(url);
                _index++;
              }
            }
            await _db.addComment(widget.placeId, _commentModel);
            NavigatorUtils.goBack(context);
          } else {
            _db.setStateType(StateType.empty);
            showToast(S.of(context).msgPleaseFillRequiredField);
          }
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
                        child: _CommentForm(
                            placeName: widget.placeName,
                            placeId: widget.placeId,
                            formKey: _formKey,
                            commentModel: _commentModel,
                            themeData: themeData),
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
}

class _CommentForm extends StatelessWidget {
  const _CommentForm(
      {Key key,
      @required this.placeId,
      @required this.formKey,
      @required this.commentModel,
      @required this.themeData,
      @required this.placeName});
  final String placeName;
  final GlobalKey<FormState> formKey;
  final String placeId;
  final CommentModel commentModel;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            //title
            placeName.toUpperCase(),
            maxLines: 1,
            style: Theme.of(context).textTheme.title,
          ),
          Gaps.vGap12,
          _RatingArea(commentModel: commentModel),
          Gaps.vGap12,
          _BuildCommentField(
            commentModel: commentModel,
            themeData: themeData,
          ),
          Gaps.vGap12,
          _ImageArea(
            placeId: placeId,
            commentModel: commentModel,
          ),
          Gaps.vGap12,
          _AverageCost(commentModel: commentModel),
        ],
      ),
    );
  }
}

class _BuildCommentField extends StatelessWidget {
  const _BuildCommentField({
    Key key,
    @required this.commentModel,
    @required this.themeData,
  });

  final CommentModel commentModel;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return S.of(context).labelNewCommentPageCommentErrorMessage;
            }
            return null;
          },
          onSaved: (value) => commentModel.commentText = value,
          maxLines: 5,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              hintText: S.of(context).labelNewCommentPageComment,
              counterText: "",
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: themeData.primaryColor, width: 0.8)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).dividerTheme.color,
                      width: 0.8))),
        ),
      ],
    );
  }
}

class _ImageArea extends StatefulWidget {
  @override
  __ImageAreaState createState() => __ImageAreaState();

  const _ImageArea({
    Key key,
    @required this.placeId,
    @required this.commentModel,
  }) : super(key: key);
  final String placeId;
  final CommentModel commentModel;
}

class __ImageAreaState extends State<_ImageArea> {
  List<Asset> _images = [];
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5 - _images.length,
        enableCamera: true,
        selectedAssets: _images,
        materialOptions: MaterialOptions(
          actionBarColor:
              '#${Colours.app_secondary.value.toRadixString(16).substring(2)}',
          actionBarTitle: S.of(context).labelImageChosen,
          allViewTitle: "All Photos",
          startInAllView: true,
        ),
      );
    } on NoImagesSelectedException catch (customere) {
      //if user did not choose image on 2nd time, add back current selected
      resultList.addAll(_images);
    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }
    if (!mounted) return;
    if (resultList != null) {
      _images
        ..clear()
        ..addAll(resultList);
      _error = error;
      widget.commentModel.imageAssets = _images;
    }
    setState(() {
//      _images = resultList;
    });
  }

  Asset _tempImage;
  int _tempIndex;
  void _deleteImage(int index) {
    _tempIndex = index;
    _tempImage = _images[index];
    setState(() {
      _images.removeAt(index);
    });
  }

  void _undoDelete() {
    setState(() {
      _images.insert(
        _tempIndex,
        _tempImage,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            S.of(context).labelClickToAddImage,
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(fontSize: Dimens.font_sp14),
          ),
          Gaps.vGap12,
          Container(
            height: 120.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (_images == null || _images.length < 5)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Center(
                      child: SelectedImage(size: 96.0, onTap: loadAssets),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    itemBuilder: (context, index) => _buildThumbnail(index),
                  ),
                )
              ],
            ),
          ),
        ]);
  }

  Stack _buildThumbnail(int index) {
    return Stack(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: AssetThumb(
            width: 100,
            height: 100,
            asset: _images[index],
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            _deleteImage(index);
            Scaffold.of(context).showSnackBar(SnackBar(
                action: SnackBarAction(
                  label: S.of(context).labelUndoAction,
                  onPressed: () {
                    _undoDelete();
                  },
                ),
                content: Text(S.of(context).labelImageRemoved)));
          },
          child: LoadAssetImage(
            "comment/icon_delete_image",
            height: 30,
          ),
        ),
      ),
    ]);
  }
}

class _AverageCost extends StatefulWidget {
  @override
  __AverageCostState createState() => __AverageCostState();

  _AverageCost({@required this.commentModel});
  final CommentModel commentModel;
}

class __AverageCostState extends State<_AverageCost> {
  void initState() {
    _controller.addListener(_parseAndSave);
    super.initState();
  }

  _parseAndSave() {
    if (_controller.text != "") {
      print(_controller.text);
      final cost = double.parse(_controller.text);
      widget.commentModel.costPax = cost;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: TextFieldItem(
                hintText: S.of(context).labelInputCostAmount,
                prefixIcon: Text(S.of(context).labelAveratePaxPrefix),
                suffixIcon: Text(S.of(context).labelAveratePaxSuffix),
                controller: _controller,
                keyboardType: TextInputType.numberWithOptions(),
                title: S.of(context).labelAveragePaxTitle),
          ),
        ],
      ),
    );
  }
}

class _RatingArea extends StatefulWidget {
  @override
  __RatingAreaState createState() => __RatingAreaState();
  _RatingArea({this.commentModel});
  final CommentModel commentModel;
}

class __RatingAreaState extends State<_RatingArea> {
  int _currentRating = 0;

  void _ratingUpdated(double value) {
    widget.commentModel.rating = value;
    setState(() {
      _currentRating = value.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _list = [
      S.of(context).labelRatingStatus1,
      S.of(context).labelRatingStatus2,
      S.of(context).labelRatingStatus3,
      S.of(context).labelRatingStatus4,
      S.of(context).labelRatingStatus5,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hero(
          tag: "btn_open_form",
          child: Material(
            color: Colors.transparent,
            child: Text(S.of(context).labelRatePlace),
          ),
        ),
        Gaps.hGap12,
        AddRatingBar(
          (rating) => _ratingUpdated(rating),
        ),
        Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: _currentRating == 0
                  ? Text("")
                  : Text(
                      _list[_currentRating - 1],
                    ),
            ))
      ],
    );
  }
}
