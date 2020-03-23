import 'package:flutter/material.dart';

class HideFabOnScrollScaffold extends StatefulWidget {
  const HideFabOnScrollScaffold({
    Key key,
    this.body,
    this.floatingActionButton,
    this.controller,
  }) : super(key: key);

  final Widget body;
  final Widget floatingActionButton;
  final ScrollController controller;

  @override
  State<StatefulWidget> createState() => HideFabOnScrollScaffoldState();
}

class HideFabOnScrollScaffoldState extends State<HideFabOnScrollScaffold> {
  bool _fabVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateFabVisible);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateFabVisible);
    super.dispose();
  }

  void _updateFabVisible() {
    final newFabVisible = (widget.controller.offset == 0.0);
    if (_fabVisible != newFabVisible) {
      setState(() {
        _fabVisible = newFabVisible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      floatingActionButton: _fabVisible ? widget.floatingActionButton : null,
    );
  }
}
