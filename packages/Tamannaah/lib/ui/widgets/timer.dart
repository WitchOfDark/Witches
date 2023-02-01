import 'dart:async';

import 'package:flutter/material.dart';

class EpochTimer extends StatefulWidget {
  const EpochTimer({required this.expire, required this.sec, Key? key})
      : super(key: key);

  final int sec;
  final int expire;

  @override
  State<EpochTimer> createState() => _EpochTimerState();
}

class _EpochTimerState extends State<EpochTimer> {
  late int expire;
  late int sec;
  late Timer timer;

  @override
  void initState() {
    sec = widget.sec;
    expire = (widget.expire - DateTime.now().millisecondsSinceEpoch) ~/ 1000;
    timer = Timer.periodic(
      Duration(seconds: sec),
      (timer) {
        setState(() {
          expire = expire - sec;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text("$expire sec = ${expire ~/ 60} min");
  }
}
