import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/core/models/ads_model.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:oktoast/oktoast.dart';

class AdsSpace extends StatelessWidget {
  final SwiperController controller;

  final List<AdsModel> adList;

  AdsSpace({
    Key key,
    @required this.controller,
    @required this.adList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Swiper(
          curve: Curves.easeOut,
          controller: controller,
          itemBuilder: (context, index) {
            return GestureDetector(
              key: Key("ads-item-$index"),
              onTap: () => adList[index].linkTo != ""
                  ? NavigatorUtils.goWebViewPage(
                      context,
                      adList[index].title,
                      adList[index].linkTo,
                    )
                  : showToast(S.of(context).labelNoDetail),
              child: LoadImage(
                adList[index].imageUrl ?? "",
                fit: BoxFit.fitWidth,
                key: Key("ads-item-image-$index"),
              ),
            );
          },
          loop: false,
          pagination: SwiperPagination(),
          itemCount: adList.length,
          autoplay: adList.isNotEmpty,
          autoplayDelay: 10000,
        ),
      ),
    );
  }
}
