import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';

class AttractionCard extends StatelessWidget {
  AttractionCard({
    @required this.name,
    @required this.description,
    @required this.image,
    @required this.onTap,
  });
  final String name;
  final String image;
  final String description;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            8.0,
            8.0,
            16.0,
            8.0,
          ),
          child: InkWell(
            onTap: onTap,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: LoadImage(
                      image,
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Gaps.hGap10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gaps.vGap8,
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                description,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
