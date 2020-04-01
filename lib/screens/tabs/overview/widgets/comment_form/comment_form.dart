import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comment_form/image_picker.dart';
import 'package:jom_malaysia/widgets/add_rating_bar.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/selected_image.dart';
import 'package:jom_malaysia/widgets/text_field_item.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({
    Key key,
    @required this.placeId,
    @required this.formKey,
    @required this.commentModel,
    @required this.placeName,
  });
  final String placeName;
  final GlobalKey<FormState> formKey;
  final String placeId;
  final CommentModel commentModel;

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  TextEditingController _commentController;
  TextEditingController _costController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _costController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Form(
      key: widget.formKey,
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
          _RatingArea(commentModel: widget.commentModel),
          Gaps.vGap12,
          _BuildCommentField(
            commentModel: widget.commentModel,
            themeData: themeData,
            commentController: _commentController,
          ),
          Gaps.vGap12,
          ImageChooser(
            placeId: widget.placeId,
            commentModel: widget.commentModel,
          ),
          Gaps.vGap12,
          _AverageCost(
            commentModel: widget.commentModel,
            controller: _costController,
          ),
        ],
      ),
    );
  }
}

class _BuildCommentField extends StatefulWidget {
  const _BuildCommentField(
      {Key key,
      @required this.commentModel,
      @required this.themeData,
      @required this.commentController});
  final CommentModel commentModel;
  final ThemeData themeData;
  final TextEditingController commentController;

  @override
  __BuildCommentFieldState createState() => __BuildCommentFieldState();
}

class __BuildCommentFieldState extends State<_BuildCommentField> {
  @override
  void dispose() {
    widget.commentController?.dispose();
    super.dispose();
  }

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
          controller: widget.commentController,
          onSaved: (value) => widget.commentModel.commentText = value,
          maxLines: 5,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              hintText: S.of(context).labelNewCommentPageComment,
              counterText: "",
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.themeData.primaryColor, width: 0.8)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).dividerTheme.color,
                      width: 0.8))),
        ),
      ],
    );
  }
}

class _AverageCost extends StatefulWidget {
  @override
  __AverageCostState createState() => __AverageCostState();

  _AverageCost({
    @required this.commentModel,
    @required this.controller,
  });
  final CommentModel commentModel;
  final TextEditingController controller;
}

class __AverageCostState extends State<_AverageCost> {
  void initState() {
    widget.controller.addListener(_parseAndSave);
    super.initState();
  }

  _parseAndSave() {
    if (widget.controller.text != "") {
      final cost = double.parse(widget.controller.text);
      widget.commentModel.costPax = cost;
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

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
                controller: widget.controller,
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
