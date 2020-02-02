import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/util/image_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

import 'package:provider/provider.dart';

class AdsSpace extends StatelessWidget {
  final List<String> _adList = [
    "https://res.cloudinary.com/jomn9-com/image/upload/v1578318037/ads/ad1_eowzgj.jpg",
    "https://res.cloudinary.com/jomn9-com/image/upload/v1578318038/ads/ad2_j6fpt4.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        Container(
          height: MediaQuery.of(context).size.height * 0.24,
          margin: const EdgeInsets.only(top: 100),
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return LoadImage(
                _adList[index],
              );
            },
            itemCount: _adList.length,
            viewportFraction: 0.8,
            scale: 0.9,
            autoplay: true,
            autoplayDelay: 7000,
          ),
        ),
      ]),
    );
  }
}
