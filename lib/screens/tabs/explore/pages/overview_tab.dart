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
              style: TextStyles.textStyle_pageHeader,
            ),
            Text(
              S.of(context).stateSubtitle,
              style: TextStyles.textStyle_pageSubheader,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection1Para1,
              style: TextStyles.textStyle_normalParagraph,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection1Para2,
              style: TextStyles.textStyle_normalParagraph,
            ),
            Gaps.sectionGap,
            LoadAssetImage(
              "explore/minangkabau",
              format: "webp",
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection2Title,
              style: TextStyles.textStyle_sectionTitle,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection2Para1,
              style: TextStyles.textStyle_normalParagraph
            ),
            Gaps.sectionGap,
            Text(
              S.of(context).overviewSection3Title,
              style: TextStyles.textStyle_sectionTitle,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection3Para1,
              style: TextStyles.textStyle_normalParagraph,
            ),
            Gaps.sectionGap,
            LoadAssetImage(
              "explore/nsmap",
              format: "jpg",
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection4Title,
              style: TextStyles.textStyle_sectionTitle,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection4Para1,
              style: TextStyles.textStyle_normalParagraph,
            ),
            Gaps.sectionGap,
            Text(
              S.of(context).overviewSection5Title,
              style: TextStyles.textStyle_sectionTitle,
            ),
            Gaps.vGap16,
            Text(
              S.of(context).overviewSection5Para1,
              style: TextStyles.textStyle_normalParagraph,
            ),
          ],
        ),
      ),
    );
  }
}
