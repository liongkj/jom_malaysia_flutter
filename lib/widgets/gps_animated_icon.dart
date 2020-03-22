import 'package:flutter/material.dart';

class GpsAnimatedIcon extends StatefulWidget {
  GpsAnimatedIcon({Key key}) : super(key: key);

  @override
  _GpsAnimatedIconState createState() => _GpsAnimatedIconState();
}

class _GpsAnimatedIconState extends State<GpsAnimatedIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int _currentIcon = 0;
  final List<IconData> icon = [
    Icons.gps_fixed,
    Icons.gps_not_fixed,
    // Icons.gps_fixed,
    // Icons.gps_not_fixed
  ];
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        animationBehavior: AnimationBehavior.preserve,
        vsync: this,
        duration: const Duration(milliseconds: 800));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (++_currentIcon == icon.length) {
            _currentIcon = 0;
          }
        });

        _controller.forward(from: 0.0);
      }
    });

    _controller.forward();
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Icon(icon[_currentIcon]);
  }
}
