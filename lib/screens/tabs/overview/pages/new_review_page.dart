import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/widgets/add_rating_bar.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/text_field.dart';

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

class _ImageArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("UploadImage");
  }
}

class _AverageCost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Cost");
  }
}
