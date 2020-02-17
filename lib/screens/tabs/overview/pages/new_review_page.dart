import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/util/toast.dart';
import 'package:jom_malaysia/widgets/add_rating_bar.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/selected_image.dart';
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
  final _formKey = GlobalKey<FormState>();
  CommentModel _commentModel = new CommentModel();
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: MyAppBar(
        actionName: "Publish",
        onPressed: () {
          print(_formKey.currentState.validate());

          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            print(_commentModel.title);
            print(_commentModel.images);
            showToast("fk");
          } else {
            showToast("fk la");
          }
        },
        backImg: "assets/images/ic_close.png",
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0,
          ),
          child: _CommentForm(
              formKey: _formKey,
              widget: widget,
              commentModel: _commentModel,
              themeData: themeData),
        ),
      ),
    );
  }
}

class _CommentForm extends StatelessWidget {
  const _CommentForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.widget,
    @required CommentModel commentModel,
    @required this.themeData,
  })  : _formKey = formKey,
        _commentModel = commentModel,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final NewReviewPage widget;
  final CommentModel _commentModel;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            //title
            widget.placeName.toUpperCase(),
            maxLines: 1,
            style: Theme.of(context).textTheme.title,
          ),
          Gaps.vGap12,
          _RatingArea(),
          Gaps.vGap12,
          _BuildCommentField(commentModel: _commentModel, themeData: themeData),
          Gaps.vGap12,
          _ImageArea(
            commentModel: _commentModel,
          ),
          Gaps.vGap12,
          _AverageCost(),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a Snackbar.
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
              } else {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('fuck Data')));
              }
            },
          )
        ],
      ),
    );
  }
}

class _BuildCommentField extends StatelessWidget {
  const _BuildCommentField({
    Key key,
    @required CommentModel commentModel,
    @required this.themeData,
  })  : _commentModel = commentModel,
        super(key: key);

  final CommentModel _commentModel;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a interesting title';
            }
            return null;
          },
          onSaved: (value) => _commentModel.title = value,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              hintText: "Add a title",
              counterText: "",
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: themeData.primaryColor, width: 0.8)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).dividerTheme.color,
                      width: 0.8))),
        ),
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some comment';
            }
            return null;
          },
          onSaved: (value) => _commentModel.commentText = value,
          maxLines: 5,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              hintText: "Add your comment",
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
    @required CommentModel commentModel,
  })  : commentModel = commentModel,
        super(key: key);

  final CommentModel commentModel;
}

class __ImageAreaState extends State<_ImageArea> {
  List<Asset> _images = [];
  String _error;

  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5 - _images.length,
        enableCamera: true,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _images += resultList;
      resultList.forEach(
          (f) async => widget.commentModel.images.add(await _saveImage(f)));
      if (error == null) _error = 'No Error Dectected';
    });
  }

  Future<String> _saveImage(Asset asset) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    StorageReference ref =
        FirebaseStorage.instance.ref().child("some_image_bame.jpg");
    StorageUploadTask uploadTask = ref.putData(imageData);
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
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
                if (_images.length < 5)
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
          onTap: () => _deleteImage(index),
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
}

class __AverageCostState extends State<_AverageCost> {
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
}

class __RatingAreaState extends State<_RatingArea> {
  int _currentRating = 2;

  void _ratingUpdated(double value) {
    setState(() {
      _currentRating = value.toInt() - 1;
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
        Text("Rating"),
        Gaps.hGap12,
        AddRatingBar(
          (rating) => _ratingUpdated(rating),
        ),
        Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                _list[_currentRating],
              ),
            ))
      ],
    );
  }
}
