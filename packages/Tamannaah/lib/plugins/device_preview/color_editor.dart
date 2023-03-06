import 'package:tamannaah/darkknight/utils.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

import '../../ui/custom/circle_color_picker.dart';
import '../../ui/rainbow.dart';

import '../../ui/decoration.dart';
import '../../ui/primitive.dart';

class ColorEditor extends StatefulWidget {
  const ColorEditor({Key? key}) : super(key: key);

  @override
  State<ColorEditor> createState() => _ColorEditorState();
}

class _ColorEditorState extends State<ColorEditor> {
  bool add = true;
  String colorName = '0:S';
  ColorController controller = ColorController(initialColor: Colors.amber);

  void debugy(String d) {
    colorName = d;
    int ci = int.parse(colorName.split(':')[0]);
    String cd = colorName.split(':')[1];
    Color cc = HexColor.random();

    cc = (cd == 'F') ? rain[ci].F : cc;
    cc = (cd == 'B') ? rain[ci].B : cc;
    cc = (cd == 'S') ? rain[ci].S : cc;

    // setState(() {
    controller.color = cc;
    // });
  }

  void redebugy(Color cc) {
    int ci = int.parse(colorName.split(':')[0]);
    String cd = colorName.split(':')[1];

    List<Accent> my = rain;
    // lava(my[ci].toMap());
    final h = Accent(
      F: (cd == 'F') ? cc : rain[ci].F,
      B: (cd == 'B') ? cc : rain[ci].B,
      S: (cd == 'S') ? cc : rain[ci].S,
    );
    // lava(h.toMap());
    my[ci] = h;
    // lava(my[ci].toMap());
    setDummy(my);

    setState(() {
      add = !add;
    });
    final state = context.read<DevicePreviewStore>();

    state.data = state.data.copyWith(textScaleFactor: (state.data.textScaleFactor + (add ? .001 : -.001)));
  }

  @override
  Widget build(BuildContext context) {
    return ToolPanelSection(
      title: 'Color Editor',
      children: [
        ListTile(
          title: const Text('Randomize'),
          onTap: () {
            final state = context.read<DevicePreviewStore>();

            int ci = int.parse(colorName.split(':')[0]);
            String cd = colorName.split(':')[1];

            List<Accent> my = rain;
            final h = Accent(
              F: (cd == 'F') ? HexColor.random() : rain[ci].F,
              B: (cd == 'B') ? HexColor.random() : rain[ci].B,
              S: (cd == 'S') ? HexColor.random() : rain[ci].S,
            );

            my[ci] = h;
            setDummy(my);

            // print('Randomize');

            setState(() {
              add = !add;
            });

            state.data = state.data.copyWith(textScaleFactor: (state.data.textScaleFactor + (add ? .001 : -.001)));
          },
        ),
        Padding(
          padding: e16,
          child: ColorDebugger(
            debugy: debugy,
            redebugy: redebugy,
            controller: controller,
            colorName: colorName,
          ),
        )
      ],
    );
  }
}

class ColorDebugger extends StatelessWidget {
  const ColorDebugger(
      {required this.debugy, required this.redebugy, required this.colorName, required this.controller, Key? key})
      : super(key: key);

  final void Function(String) debugy;
  final void Function(Color) redebugy;
  final String colorName;
  final ColorController controller;

  @override
  Widget build(BuildContext context) {
    return box(
      deco: Deco(0, B: const Color.fromARGB(255, 240, 240, 240)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Box(deco: Deco(0, W: 50, H: 50, B: color)),
          // SizedBox(width: 10),
          tx(colorName),
          box(
            deco: Deco(3, W: 300, H: 160),
            child: ListView.builder(
              itemBuilder: (context, int i) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        child: txb(
                          i.toString(),
                          deco: Deco(0,
                              W: 30,
                              H: 30,
                              B: rain[i].B,
                              // br: br(s: BorderSide(width: 1, color: Colors.black), ltrb: 1111),
                              brR: brRgen(W: 4, ltrb: 1111),
                              align: Alignment.center),
                        ),
                        onTap: () {
                          debugy('$i:B');
                        }),
                    GestureDetector(
                        child: txb(
                          i.toString(),
                          deco: Deco(0,
                              W: 30,
                              H: 30,
                              B: rain[i].F,
                              // br: br(s: BorderSide(width: 1, color: Colors.black), ltrb: 1111),
                              brR: brRgen(W: 4, ltrb: 1111),
                              align: Alignment.center),
                        ),
                        onTap: () {
                          debugy('$i:F');
                        }),
                    GestureDetector(
                        child: txb(
                          i.toString(),
                          deco: Deco(0,
                              W: 30,
                              H: 30,
                              B: rain[i].S,
                              // br: br(s: BorderSide(width: 1, color: Colors.black), ltrb: 1111),
                              brR: brRgen(W: 4, ltrb: 1111),
                              align: Alignment.center),
                        ),
                        onTap: () {
                          debugy('$i:S');
                        }),
                  ],
                );
              },
              itemCount: rain.length,
            ),
          ),
          CircleColor(
            size: const Size(200, 200),
            controller: controller,
            // colorCodeBuilder: ((context, color) {
            //   return Tx('');
            // }),
            onChanged: (color) {
              redebugy(color);
            },
          ),
        ],
      ),
    );
  }
}
