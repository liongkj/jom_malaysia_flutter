import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).stateTitle,
              style: Theme.of(context).textTheme.title,
            ),
            Text(
              S.of(context).stateSubtitle,
              style: Theme.of(context).textTheme.subhead,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection1Para1,
              style: Theme.of(context).textTheme.body1,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection1Para2,
              style: Theme.of(context).textTheme.body1,
            ),
            Gaps.vGap16,
            LoadImage(
              "explore/minangkabau",
              format: "webp",
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection2Title,
              style: Theme.of(context).textTheme.body2,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection2Para1,
              style: Theme.of(context).textTheme.body1,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection3Title,
              style: Theme.of(context).textTheme.body2,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection3Para1,
              style: Theme.of(context).textTheme.body1,
            ),
            Gaps.vGap16,
            LoadImage(
              "explore/nsmap",
              format: "jpg",
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection4Title,
              style: Theme.of(context).textTheme.body2,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection4Para1,
              style: Theme.of(context).textTheme.body1,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection5Title,
              style: Theme.of(context).textTheme.body2,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection5Para1,
              style: Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      ),
    );
  }
}
