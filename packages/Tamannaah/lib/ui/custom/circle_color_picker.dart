import 'dart:math' show min, max;

import 'package:tamannaah/darkknight/debug_functions.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../d_theme.dart';
import '../decoration.dart';
import '../primitive.dart';

const List<Color> hueColors = [
  Color.fromARGB(255, 255, 0, 0),
  Color.fromARGB(255, 255, 255, 0),
  Color.fromARGB(255, 0, 255, 0),
  Color.fromARGB(255, 0, 255, 255),
  Color.fromARGB(255, 0, 0, 255),
  Color.fromARGB(255, 255, 0, 255)
];

Color lerp(List<Color> l, double v) {
  v = v < 0 ? 0 : (v > 1 ? 1 : v);
  int b = max(0, (v * (l.length - 1)).floor());
  int e = min(l.length - 1, b + 1);
  final t = ColorTween(
    begin: l[b],
    end: l[e],
  );
  return t.lerp(v * (l.length - 1) - b) ?? Colors.white;
}

class ColorController {
  final Color? initialColor;
  Color? color;
  double xV;
  double yV;

  ColorController({this.color, this.initialColor, this.xV = 0, this.yV = 0});
}

class CircleColor extends StatelessWidget {
  const CircleColor({super.key, required this.size, required this.onChanged, required this.controller});

  final Size size;
  final void Function(Color color) onChanged;
  final ColorController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          SleekCircularSlider(
            appearance: CircularSliderAppearance(
                spinnerMode: false,
                customColors: CustomSliderColors(
                  progressBarColors: [
                    Colors.red,
                    Colors.yellow,
                    Colors.blue,
                    Colors.purple,
                  ],
                  trackColors: [
                    Colors.red,
                    Colors.yellow,
                    Colors.blue,
                    Colors.purple,
                  ],
                ),
                customWidths: CustomSliderWidths(
                  trackWidth: 20,
                  progressBarWidth: 20,
                )),
            onChange: (double value) {
              onChanged(lerp(hueColors, value / 100));
            },
          ),
        ],
      ),
    );
  }
}

class GradientSlider extends StatefulWidget {
  const GradientSlider({Key? key, this.deco, required this.onChanged, required this.controller, this.radius})
      : super(key: key);

  final void Function(Color color) onChanged;
  final ColorController controller;
  final Deco? deco;
  final double? radius;

  @override
  State<GradientSlider> createState() => _GradientSliderState();
}

class _GradientSliderState extends State<GradientSlider> {
  @override
  Widget build(BuildContext context) {
    Deco deco = (widget.deco ?? dRating10);
    deco = deco.cp(
      W: deco.W ?? 200,
      H: deco.H ?? 30,
      bW: 1,
    );
    double radius = widget.radius ?? 10;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        lava(details.localPosition.dx);

        widget.controller.xV = details.localPosition.dx / deco.W!;
        widget.controller.color = lerp(hueColors, widget.controller.xV);
        widget.onChanged(widget.controller.color ?? Colors.white);
        setState(() {});
      },
      child: box(
        deco: deco,
        child: Stack(
          children: [
            Positioned(
              top: (deco.H! - radius) / 2,
              child: box(
                deco: Deco(
                  5,
                  W: deco.W,
                  H: radius,
                  brR: brR_a_10,
                  grad: const LinearGradient(colors: hueColors),
                ),
              ),
            ),
            Positioned(
              left: deco.W! * widget.controller.xV - 10,
              top: deco.H! / 2 - radius,
              child: box(
                deco: deco.cp(
                  B: widget.controller.color,
                  brR: brR_no,
                  W: radius * 2,
                  H: radius * 2,
                ),
                // child: tx('.', deco: Deco(5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientBox extends StatefulWidget {
  const GradientBox({Key? key, this.deco, required this.onChanged, required this.controller, this.radius})
      : super(key: key);

  final void Function(Color color) onChanged;
  final ColorController controller;
  final Deco? deco;
  final double? radius;

  @override
  State<GradientBox> createState() => _GradientBoxState();
}

class _GradientBoxState extends State<GradientBox> {
  @override
  Widget build(BuildContext context) {
    Deco deco = (widget.deco ?? dRating10);
    deco = deco.cp(
      W: deco.W ?? 150,
      H: deco.H ?? 150,
      bW: 1,
    );
    double radius = widget.radius ?? 10;
    Color initColor = widget.controller.initialColor ?? Colors.amber;

    return GestureDetector(
      onPanUpdate: ((details) {
        widget.controller.xV = details.localPosition.dx / deco.W!;

        widget.controller.yV = details.localPosition.dy / deco.H!;

        widget.controller.color = lerp([
          lerp([Colors.white, initColor], widget.controller.xV),
          Colors.black,
        ], widget.controller.yV);

        widget.onChanged(widget.controller.color ?? Colors.white);

        setState(() {});
      }),
      child: box(
        deco: deco,
        child: Stack(
          children: [
            Container(
              width: deco.W,
              height: deco.H,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, initColor],
                ),
              ),
              foregroundDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                ),
              ),
            ),
            Positioned(
              left: deco.W! * widget.controller.xV - 10,
              top: deco.H! * widget.controller.yV - 10,
              child: box(
                deco: deco.cp(
                  B: widget.controller.color,
                  brR: brR_no,
                  W: radius * 2,
                  H: radius * 2,
                ),
                // child: tx('.', deco: Deco(5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget colorSwatch() {
  return box(
    deco: dIos,
    child: Wrap(
      spacing: 4,
      runSpacing: 4,
      children: List.generate(
        100,
        (i) => CircleAvatar(
          backgroundColor: lerp(hueColors, i * 0.01),
          radius: 10,
        ),
      ),
    ),
  );
}
