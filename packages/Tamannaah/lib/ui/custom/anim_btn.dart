import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../ui/custom/shimmer_boxes.dart';

import '../d_theme.dart';
import '../decoration.dart';
import '../primitive.dart';

class AnimSlide extends StatefulWidget {
  const AnimSlide({Key? key, this.deco, this.radius}) : super(key: key);

  final Deco? deco;
  final double? radius;

  @override
  State<AnimSlide> createState() => _AnimSlideState();
}

class _AnimSlideState extends State<AnimSlide> with SingleTickerProviderStateMixin {
  double position = 0;
  bool dragging = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Deco deco = (widget.deco ?? dIos);
    deco = deco.cp(
      W: deco.W ?? 100,
      H: deco.H ?? 50,
      pad: e0,
      mar: e0,
      bW: 1,
    );
    double radius = widget.radius ?? 40;

    return GestureDetector(
      onHorizontalDragStart: (details) {
        dragging = true;
      },
      onHorizontalDragEnd: (details) {
        dragging = false;
        setState(() {});
      },
      onHorizontalDragUpdate: (details) {
        position = details.localPosition.dx;

        setState(() {});
      },
      child: box(
        deco: deco,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                ShimmerBox(
                  isLoading: position > deco.W! / 2,
                  child: Container(
                    child: tx('left', deco: deco),
                    color: Colors.blue,
                  ),
                ),
                Spacer(),
              ],
            ),
            Row(
              children: [
                Spacer(),
                ShimmerBox(
                  isLoading: position < deco.W! / 2,
                  child: Container(
                    child: tx('left', deco: deco),
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            TweenAnimationBuilder<double>(
              duration: 200.ms,
              tween: Tween<double>(
                begin: position,
                end: position < deco.W! / 2 ? 0 : deco.W! - radius,
              ),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Positioned(
                  left: dragging ? position : value,
                  top: deco.H! / 2 - radius / 2,
                  child: Transform.rotate(
                    angle: 2 * pi * ((dragging ? position : value) / (deco.W! - radius)),
                    child: box(
                      deco: deco.cp(
                        B: Colors.red,
                        // brR: brR_no,
                        W: radius,
                        H: radius,
                      ),
                      child: tx('$value ${position.toStringAsFixed(1)}', deco: Deco(5)),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class simpleLoadingBtn extends StatefulWidget {
  const simpleLoadingBtn({super.key});

  @override
  State<simpleLoadingBtn> createState() => _simpleLoadingBtnState();
}

class _simpleLoadingBtnState extends State<simpleLoadingBtn> {
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          btn(
            deco: Deco(5, S: Colors.transparent, B: Colors.transparent),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 50,
              width: isLoading == null ? 100 : 50,
              padding: e8,
              decoration: Deco(
                4,
                brR: isLoading == null ? brR_a_10 : BorderRadius.all(Radius.circular(30)),
                B: Colors.black,
              ).bDeco(),
              alignment: Alignment.center,
              child: isLoading == null
                  ? txb('Button', deco: Deco(2, B: Colors.transparent, fml: 1, fs: 18))
                  : (isLoading!
                      ? Center(
                          child: AspectRatio(
                          aspectRatio: 1,
                          child: CircularProgressIndicator.adaptive(),
                        ))
                      : tx('☕', deco: Deco(2, fs: 22))),
            ),
            fn: () {
              if (isLoading == null) {
                setState(() {
                  isLoading = true;
                });
              }
              Future.delayed(Duration(milliseconds: 2000), () {
                setState(() {
                  isLoading = false;
                });
              });
              Future.delayed(Duration(milliseconds: 4000), () {
                setState(() {
                  isLoading = null;
                });
              });
            },
          ),
        ],
      ),
    );
  }
}
