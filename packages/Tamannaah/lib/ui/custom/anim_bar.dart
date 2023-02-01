import 'package:flutter/material.dart';
import 'circle_color_picker.dart';
import '../lego.dart';
import '../primitive.dart';

import '../decoration.dart';

class AnimBar extends StatefulWidget {
  const AnimBar({
    super.key,
    required this.legos,
    this.deco,
    this.boxdeco,
    this.row = false,
    this.boxrow = true,
    this.showName = false,
    this.multi = false,
  });

  final List<Lego> legos;
  final bool row;
  final bool boxrow;
  final Deco? deco;
  final Deco? boxdeco;
  final bool showName;
  final bool multi;

  @override
  State<AnimBar> createState() => _AnimBarState();
}

class _AnimBarState extends State<AnimBar> {
  List<int> selectedIndex = [0];

  @override
  Widget build(BuildContext context) {
    final double range = selectedIndex.isNotEmpty ? (2 * ((selectedIndex[0]) / (widget.legos.length - 1))) - 1 : 0;
    return Container(
      color: widget.boxdeco?.B,
      padding: widget.boxdeco?.pad,
      margin: widget.boxdeco?.mar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.boxdeco?.W,
            height: widget.boxdeco?.H,
            child: Stack(
              children: [
                if (widget.showName)
                  AnimatedAlign(
                    alignment: Alignment(range, 0),
                    duration: const Duration(milliseconds: 300),
                    child: box(
                      deco: widget.deco?.cp(
                        W: (widget.deco?.W ?? 100),
                        H: widget.deco?.H ?? 64,
                        B: widget.boxdeco?.hS,
                        // brR: brRadius(
                        //   selectedIndex[0],
                        //   widget.deco?.brR,
                        //   true,
                        //   widget.legos.length,
                        // ),
                      ),
                    ),
                  ),
                RowCol(
                  children: list(),
                  row: widget.boxrow,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> list() {
    return widget.legos
        .asMap()
        .entries
        .map(
          (e) => InkWell(
            onTap: () {
              if (widget.multi) {
                if (selectedIndex.contains(e.key)) {
                  selectedIndex.remove(e.key);
                } else {
                  selectedIndex.add(e.key);
                }
              } else {
                selectedIndex = [e.key];
              }
              setState(() {});
              (e.value.fn ?? () {})();
            },
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: (selectedIndex.contains(e.key) ? 0 : 1),
                end: (selectedIndex.contains(e.key) ? 1 : 0),
              ),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              builder: (context, value, child) => Container(
                width: (widget.showName ? 1 : value) * ((widget.deco?.W ?? 100) - 40) + 40,
                height: widget.deco?.H ?? 64,
                decoration: BoxDecoration(
                  color: lerp([widget.deco?.hS ?? const Color.fromARGB(72, 255, 255, 255), e.value.deco.hB], value),
                  borderRadius: widget.deco?.brR,
                  // border: Border.all(width: 1, color: Colors.red),
                ),
                padding: widget.deco?.pad,
                margin: widget.deco?.mar,
                child: RowCol(
                  row: widget.row, //widget.width == null,
                  children: [
                    Icon(
                      e.value.icon,
                      color: (selectedIndex.contains(e.key)) ? e.value.deco.hB : widget.deco?.hF,
                      size: (widget.deco?.fs ?? 15) + 5,
                    ),
                    if (selectedIndex.contains(e.key) || widget.showName)
                      SizedBox(width: 8 /*4 + 4 * value*/, height: 4 /*2 + 2 * value*/),
                    if (selectedIndex.contains(e.key) || widget.showName)
                      // Container(
                      // decoration: BoxDecoration(border: Border.all()),
                      // child:

                      LimitedBox(
                        maxWidth: ((widget.deco?.W ?? 100) - 64) * (widget.showName ? 1 : value),
                        child: tx(
                          deco: widget.deco?.cp(
                            fml: 1,
                            fw: FontWeight.w600,
                            fto: TextOverflow.clip,
                            F: (selectedIndex.contains(e.key)) ? e.value.deco.hF : widget.deco?.hF,
                          ),
                          (selectedIndex.contains(e.key) || widget.showName) ? e.value.name : '',
                        ),
                      ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}

BorderRadius brRadius(int id, BorderRadius? rad, bool horizontal, int length) {
  double r = rad?.topLeft.x ?? 1;
  return id == 0
      ? (horizontal ? brRgen(W: r, ltrb: 1001) : brRgen(W: r, ltrb: 1100))
      : ((id == (length - 1))
          ? (horizontal ? brRgen(W: r, ltrb: 0110) : brRgen(W: r, ltrb: 0011))
          : brRgen(W: 2, ltrb: 1111));
}
