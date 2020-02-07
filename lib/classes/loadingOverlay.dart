import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlay extends StatefulWidget {
  final duration;

  LoadingOverlay({this.duration = 500});

  @override
  State<StatefulWidget> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          color: Colors.blue,
          width: double.infinity,
          height: double.infinity,
          child: SpinKitWave(color: Colors.white, type: SpinKitWaveType.start),
        ),
      ),
    );
  }
}
