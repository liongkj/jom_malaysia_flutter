import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/comments/comment_model.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/selected_image.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImageChooser extends StatefulWidget {
  @override
  _ImageChooserState createState() => _ImageChooserState();

  const ImageChooser({
    Key key,
    @required this.placeId,
    @required this.commentModel,
  }) : super(key: key);
  final String placeId;
  final CommentModel commentModel;
}

class _ImageChooserState extends State<ImageChooser> {
  List<Asset> _images;

  @override
  void initState() {
    _images = [];
    super.initState();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5 - _images.length,
        enableCamera: false,
        selectedAssets: _images,
        materialOptions: MaterialOptions(
          actionBarColor:
              '#${Colours.app_secondary.value.toRadixString(16).substring(2)}',
          actionBarTitle: S.of(context).labelImageChosen,
          allViewTitle: "All Photos",
          startInAllView: true,
        ),
      );
    } on NoImagesSelectedException catch (e) {
      //if user did not choose image on 2nd time, add back current selected
      resultList.addAll(_images);
    }
    if (!mounted) return;
    setState(() {
      if (resultList.length > 0) _images = resultList;
      widget.commentModel.imageAssets = _images;
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
                  onPressed: () => _undoDelete(),
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
