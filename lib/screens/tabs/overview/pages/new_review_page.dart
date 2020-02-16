import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/util/toast.dart';
import 'package:jom_malaysia/widgets/add_rating_bar.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/selected_image.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actionName: "Publish",
        backImg: "assets/images/ic_close.png",
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 16.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _Title(widget.placeName),
              Gaps.vGap12,
              _RatingArea(),
              Gaps.vGap12,
              _CommentArea(),
              Gaps.vGap12,
              _ImageArea(),
              Gaps.vGap12,
              _AverageCost()
            ],
          ),
        ),
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

class _Title extends StatelessWidget {
  _Title(this.placeName);
  final String placeName;

  @override
  Widget build(BuildContext context) {
    return Text(
      placeName.toUpperCase(),
      maxLines: 1,
      style: Theme.of(context).textTheme.title,
    );
  }
}

class _CommentArea extends StatefulWidget {
  @override
  __CommentAreaState createState() => __CommentAreaState();
}

class __CommentAreaState extends State<_CommentArea> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      children: <Widget>[
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
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
        TextField(
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
}

class __ImageAreaState extends State<_ImageArea> {
  List<Asset> images = List<Asset>();
  String _error;

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '点击添加商品图片',
          style: Theme.of(context)
              .textTheme
              .subtitle
              .copyWith(fontSize: Dimens.font_sp14),
        ),
        Gaps.vGap12,
        Row(
          children: <Widget>[
            Center(
              child: SelectedImage(size: 96.0, onTap: loadAssets),
            ),
            Gaps.hGap8,
            Expanded(
              child: buildThumbnail(),
            ),
            Gaps.vGap16,
          ],
        ),
      ],
    );
  }

  Widget buildThumbnail() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }
}

class _AverageCost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Cost");
  }
}
