import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/core/models/ads_model.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/ads_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class AdsSpace extends StatefulWidget {
  @override
  _AdsSpaceState createState() => _AdsSpaceState();
}

class _AdsSpaceState extends State<AdsSpace> {
  SwiperController _controller;
  SwiperPagination _pagination;

  @override
  void initState() {
    _controller = SwiperController();
    _controller.startAutoplay();
    _pagination = SwiperPagination();
    super.initState();
  }

  @override
  void dispose() {
    _controller.stopAutoplay();
    _controller?.dispose();

    super.dispose();
  }

  List<AdsModel> _adList = [AdsModel()];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: FutureBuilder<List<AdsModel>>(
          initialData: _adList,
          future: Provider.of<AdsProvider>(context, listen: false)
              .fetchAndInitAds(),
          builder: (ctx, snap) {
            if (snap.hasData) _adList = snap.data;
            return Swiper(
              curve: Curves.easeOut,
              controller: _controller,
              itemBuilder: (context, index) {
                return GestureDetector(
                  key: Key("ads-item-$index"),
                  onTap: () => _adList[index].linkTo != ""
                      ? NavigatorUtils.goWebViewPage(
                          context,
                          _adList[index].title,
                          _adList[index].linkTo,
                        )
                      : showToast(S.of(context).labelNoDetail),
                  child: LoadImage(
                    _adList[index].imageUrl ?? "",
                    fit: BoxFit.fitWidth,
                    key: Key("ads-item-image-$index"),
                  ),
                );
              },
              loop: false,
              pagination: _pagination,
              itemCount: _adList.length,
              autoplay: snap.hasData,
              autoplayDelay: 10000,
            );
          },
        ),
      ),
    );
  }
}
