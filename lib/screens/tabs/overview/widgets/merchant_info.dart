import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/widgets/my_card.dart';

class MerchantInfo extends StatelessWidget {
  const MerchantInfo({
    Key key,
    @required this.merchant,
  }) : super(key: key);

  final MerchantVM merchant;

  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: MyCard(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  S.of(context).placeDetailMerchantInfoLabel,
                  style: textTextStyle,
                ),
                Gaps.vGap12,
                _MerchantInfoItem(
                  title: S.of(context).placeDetailMerchantRegistrationNameLabel,
                  data: merchant.registrationName,
                ),
                Gaps.vGap12,
                _MerchantInfoItem(
                  title: S.of(context).placeDetailMerchantSSMLabel,
                  data: merchant.ssmId,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MerchantInfoItem extends StatelessWidget {
  const _MerchantInfoItem({
    @required this.title,
    this.data,
    Key key,
  }) : super(key: key);
  final String title;
  final String data;
  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    return Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: textTextStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Gaps.vGap12,
        Expanded(
          flex: 5,
          child: Text(
            data,
            style: Theme.of(context).textTheme.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
