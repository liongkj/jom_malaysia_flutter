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
  bool _isInit = true;
  SwiperController _controller;
  SwiperPagination _pagination;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isInit) {
        Provider.of<AdsProvider>(context, listen: false).fetchAndInitAds();
      }
      _isInit = false;
    });
    _controller = SwiperController();
    _pagination = SwiperPagination();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  List<AdsModel> _adList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Consumer<AdsProvider>(builder: (_, provider, __) {
          _adList = Provider.of<AdsProvider>(context, listen: false).adList;
          return Swiper(
            curve: Curves.easeOut,
            controller: _controller,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _adList[index].linkTo != ""
                    ? NavigatorUtils.goWebViewPage(
                        context,
                        _adList[index].title,
                        _adList[index].linkTo,
                      )
                    : showToast(S.of(context).labelNoDetail),
                child: LoadImage(
                  _adList[index].imageUrl.isNotEmpty
                      ? _adList[index].imageUrl
                      : "",
                  fit: BoxFit.fitWidth,
                ),
              );
            },
            pagination: _pagination,
            itemCount: _adList.length,
            autoplay: _adList.isNotEmpty,
            autoplayDelay: 10000,
          );
        }),
      ),
    );
  }
}
