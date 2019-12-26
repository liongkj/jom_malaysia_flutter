import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';

import 'package:provider/provider.dart';

class AdsSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OverviewPageProvider>(builder: (_, provider, child) {
      return SliverList(
        delegate: SliverChildListDelegate.fixed([
          Container(
            height: 200,
            margin: const EdgeInsets.only(top: 100),
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  "http://via.placeholder.com/288x188",
                  fit: BoxFit.fill,
                );
              },
              itemCount: 10,
              viewportFraction: 0.8,
              scale: 0.9,
              autoplay: true,
              autoplayDelay: 5000,
            ),
          ),
        ]),
      );
    });
  }
}
