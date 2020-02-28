import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isInit) {
        Provider.of<AdsProvider>(context, listen: false).fetchAndInitAds();
      }
      _isInit = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          Container(
            height: MediaQuery.of(context).size.height * 0.24,
            margin: const EdgeInsets.only(top: 80),
            child: Consumer<AdsProvider>(
              builder: (context, adsProvider, child) => Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => adsProvider.adList[index].linkTo != ""
                        ? NavigatorUtils.goWebViewPage(
                            context,
                            adsProvider.adList[index].title,
                            adsProvider.adList[index].linkTo,
                          )
                        : showToast(S.of(context).labelNoDetail),
                    child: LoadImage(
                      adsProvider.adList[index].imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  );
                },
                pagination: new SwiperPagination(),
                itemCount: adsProvider.adList.length,
                autoplay: adsProvider.adList.isNotEmpty,
                autoplayDelay: 8000,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
