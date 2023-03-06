import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tamannaah/darkknight/utils.dart';
import 'package:tamannaah/darkknight/extensions/build_context.dart';

import '../custom/circle_color_picker.dart';
import '../d_theme.dart';
import '../decoration.dart';
import '../lego.dart';
import '../mario/mario.dart';
import '../custom/anim_bar.dart';
import '../primitive.dart';
import '../rainbow.dart';

enum DeviceType {
  mobile,
  tablet,
  mac,
  desktop,
}

class SafeScuffy extends StatelessWidget {
  final String title;
  final Deco deco;
  final List<Widget>? drawer;
  final Widget mobile;
  final Widget? tablet;
  final Widget? mac;
  final Widget? desktop;
  final List<Lego>? btnInfos;
  final List<Widget>? actions;
  final bool showAppbar;

  SafeScuffy({
    super.key,
    required this.title,
    Deco? deco,
    this.drawer,
    required this.mobile,
    this.tablet,
    this.mac,
    this.desktop,
    this.btnInfos,
    this.actions,
    this.showAppbar = true,
  }) : deco = deco ?? dScaf0;

  @override
  Widget build(BuildContext context) {
    // DeviceType type = DeviceType.mobile;
    Widget body = mobile;
    double drawerWidth = 180;

    bool portrait = context.heightPx > context.widthPx;

    if (context.widthPx < 450) {
      // type = DeviceType.mobile;
    } else if (context.widthPx < 750) {
      // type = DeviceType.tablet;
      body = tablet ?? mobile;
      drawerWidth = 270;
    } else if (context.widthPx < 1100) {
      // type = DeviceType.mac;
      drawerWidth = 350;
      body = mac ?? (tablet ?? mobile);
    } else {
      // type = DeviceType.desktop;
      drawerWidth = 400;
      body = desktop ?? (mac ?? (tablet ?? mobile));
    }

    return Scaffold(
      appBar: !showAppbar
          ? null
          : AppBar(
              elevation: deco.elv,
              toolbarHeight: deco.H,
              leading: icoBtn(
                CupertinoIcons.chevron_back,
                () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    context.go('/');
                  }
                },
                deco: deco.cp(S: deco.hF, fs: 20),
                label: 'Return back',
              ),
              centerTitle: true,
              title: tx('$title : ${GoRouter.of(context).location}', deco: deco),
              backgroundColor: deco.hS,
              foregroundColor: deco.hF,
              actions: [
                ...?actions,
                icoBtn(
                  CupertinoIcons.settings,
                  () {
                    context.pushNamed('settings');
                  },
                  label: 'Settings',
                  deco: deco.cp(S: deco.hF, fs: 20),
                ),
                icoBtn(
                  Icons.search,
                  () {
                    showSearch(context: context, delegate: MySearchDelegate());
                  },
                  deco: deco.cp(S: deco.hF, fs: 20),
                  label: 'Search',
                ),
                if (drawer != null)
                  Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(CupertinoIcons.list_dash),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      );
                    },
                  ),
              ],
            ),
      backgroundColor: deco.hB,
      endDrawer: drawer?.isNotEmpty != null
          ? box(
              deco: deco.cp(W: drawerWidth),
              child: Column(
                children: drawer ?? [],
              ),
            )
          : null,
      body: SafeArea(
        child: portrait
            ?
            // body
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Expanded(
                  // child: Center(
                  // child: SingleChildScrollView(
                  // child:
                  body,
                  // ),
                  // ),
                  // ),
                  // if (btnInfos != null && !context.keyboardVisible)
                  //   AnimBar(
                  //     deco: dIos.cp(W: null),
                  //     legos: btnInfos!,
                  //   ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (btnInfos != null && !context.keyboardVisible)
                    AnimBar(
                      deco: dIos.cp(W: 80),
                      boxdeco: dIos.cp(H: 250),
                      legos: btnInfos!,
                      boxrow: false,
                      showName: true,
                    ), //////////////
                  // Expanded(
                  // child: Center(
                  // child: SingleChildScrollView(
                  // child:
                  body,
                  // ),
                  // ),
                  // ),
                ],
              ),
      ),
      bottomNavigationBar: (portrait && btnInfos != null)
          ? AnimBar(
              deco: dIos.cp(W: null),
              legos: btnInfos!,
            )
          : null,
    );
  }
}

class DecoDebugScuffy extends StatelessWidget {
  final String title;
  final Deco deco;
  final List<Widget>? drawer;
  final Widget Function() mobile;
  final Widget Function()? tablet;
  final Widget Function()? mac;
  final Widget Function()? desktop;
  final List<Lego>? btnInfos;
  final List<Widget>? actions;

  DecoDebugScuffy({
    super.key,
    required this.title,
    Deco? deco,
    this.drawer,
    required this.mobile,
    this.tablet,
    this.mac,
    this.desktop,
    this.btnInfos,
    this.actions,
  }) : deco = deco ?? dScaf0;

  @override
  Widget build(BuildContext context) {
    // DeviceType type = DeviceType.mobile;
    Widget Function() body = mobile;
    double drawerWidth = 180;

    bool portrait = context.heightPx > context.widthPx;

    if (context.widthPx < 450) {
      // type = DeviceType.mobile;
    } else if (context.widthPx < 750) {
      // type = DeviceType.tablet;
      body = tablet ?? mobile;
      drawerWidth = 270;
    } else if (context.widthPx < 1100) {
      // type = DeviceType.mac;
      drawerWidth = 350;
      body = mac ?? (tablet ?? mobile);
    } else {
      // type = DeviceType.desktop;
      drawerWidth = 400;
      body = desktop ?? (mac ?? (tablet ?? mobile));
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          leading: Navigator.canPop(context)
              ? icoBtn(
                  CupertinoIcons.chevron_back,
                  () {
                    Navigator.pop(context);
                  },
                  deco: deco.cp(S: deco.hF),
                  label: 'Return back',
                )
              : null,
          centerTitle: true,
          title: tx(title, deco: deco),
          backgroundColor: deco.hS,
          actions: [
            ...?actions,
            if (drawer != null)
              Builder(builder: (context) {
                return IconButton(
                  icon: const Icon(CupertinoIcons.list_dash),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              }),
          ],
        ),
        backgroundColor: deco.hB,
        endDrawer: drawer?.isNotEmpty != null
            ? box(
                deco: deco.cp(W: drawerWidth),
                child: Column(
                  children: drawer ?? [],
                ),
              )
            : null,
        body: portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: body(),
                      ),
                    ),
                  ),
                  if (btnInfos != null && !context.keyboardVisible)
                    AnimBar(
                      deco: dIos.cp(W: null),
                      legos: btnInfos!,
                    ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (btnInfos != null && !context.keyboardVisible)
                    AnimBar(
                      deco: dIos.cp(W: 100),
                      legos: btnInfos!,
                    ), //////////////
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: body(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class DebugScuffy extends StatefulWidget {
  final String title;
  final Deco? deco;

  final Widget Function() body;

  DebugScuffy({
    super.key,
    required this.title,
    required this.body,
    Deco? deco,
  }) : deco = deco ?? dScaf0;

  @override
  State<DebugScuffy> createState() => _DebugScuffyState();
}

class _DebugScuffyState extends State<DebugScuffy> {
  String colorName = '1:S';
  ColorController controller = ColorController(initialColor: Colors.amber);
  bool colorDebug = false;

  void debugy(String d) {
    colorName = d;
    int ci = int.parse(colorName.split(':')[0]);
    String cd = colorName.split(':')[1];
    Color cc = HexColor.random();

    cc = (cd == 'F') ? rain[ci].F : cc;
    cc = (cd == 'B') ? rain[ci].B : cc;
    cc = (cd == 'S') ? rain[ci].S : cc;

    setState(() {
      controller.color = cc;
    });
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

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: tx(widget.title, deco: widget.deco),
          actions: [
            ActionChip(
              label: tx('👻'),
              onPressed: () {
                setState(() {
                  colorDebug = !colorDebug;
                });
              },
            ),
          ],
          backgroundColor: widget.deco?.gS,
        ),
        backgroundColor: widget.deco?.B,
        body: !colorDebug
            ? Center(
                child: SingleChildScrollView(child: widget.body()),
              )
            : Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: SingleChildScrollView(
                        child: widget.body(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ColorDebugger(
                      debugy: debugy,
                      redebugy: redebugy,
                      controller: controller,
                      colorName: colorName,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class ColorDebugger extends StatelessWidget {
  const ColorDebugger({
    required this.debugy,
    required this.redebugy,
    required this.colorName,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final void Function(String) debugy;
  final void Function(Color) redebugy;
  final String colorName;
  final ColorController controller;

  @override
  Widget build(BuildContext context) {
    return box(
      deco: Deco(0, B: const Color.fromARGB(255, 240, 240, 240)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Box(deco: Deco(0, W: 50, H: 50, B: color)),
          // SizedBox(width: 10),
          tx(colorName),
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
          Column(
            children: [
              tx('Dummy'),
              box(
                deco: Deco(0, W: 210, H: 160),
                child: ListView.builder(
                  itemBuilder: (context, int i) {
                    return box(
                      deco: Deco(0, B: Colors.blue),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          btn(
                              deco: Deco(0, W: 30, H: 30, B: rain[i].B),
                              fn: () {
                                debugy('$i:B');
                              },
                              child: tx(i.toString())),
                          btn(
                              deco: Deco(0, W: 30, H: 30, B: rain[i].F),
                              fn: () {
                                debugy('$i:F');
                              },
                              child: tx(i.toString())),
                          btn(
                              deco: Deco(0, W: 30, H: 30, B: rain[i].S),
                              fn: () {
                                debugy('$i:S');
                              },
                              child: tx(i.toString())),
                        ],
                      ),
                    );
                  },
                  itemCount: rain.length,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
