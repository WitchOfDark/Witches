import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' show min;

import '../../forms/form_lion.dart';
import '../../forms/v3_grow.dart';

import 'package:tamannaah/darkknight/utils.dart';
import 'package:tamannaah/darkknight/extensions/build_context.dart';

import '../d_theme.dart';
import '../decoration.dart';
import '../lego.dart';
import '../primitive.dart';

import 'package:http/http.dart' as http;

Widget popupMenu(List<Lego?> btns, {Widget? child, Deco? deco}) {
  return PopupMenuButton<int>(
    icon: child == null ? const Icon(Icons.more_vert) : null,
    iconSize: 20,
    padding: e0,
    splashRadius: 24,
    color: deco?.hB,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    itemBuilder: (context) {
      final List<PopupMenuEntry<int>> hello = [
        const PopupMenuItem<int>(
          value: 0,
          child: Text('Settings'),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Share'),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: const [
              Icon(Icons.logout),
              SizedBox(width: 8),
              Text('Sign Out'),
            ],
          ),
        ),
      ];
      final List<PopupMenuEntry<int>> henno = btns
          .asMap()
          .entries
          .map<PopupMenuEntry<int>>(
            (e) =>
                cast<PopupMenuEntry<int>>(((e.value != null)
                    ? PopupMenuItem<int>(
                        value: e.key,
                        child: e.value?.popup(),
                      )
                    : const PopupMenuDivider())) ??
                const PopupMenuDivider(),
          )
          .toList();

      return [...henno, ...hello];
    },
    onSelected: (value) {
      (btns[value]?.fn ?? () {})();
    },
    child: child,
  );
}

void marioBar({
  required BuildContext context,
  required String content,
  String? title,
  Widget? icon,
  List<Widget>? actions,
  bool close = true,
  Deco? deco,
}) {
  Deco d = deco ?? dError;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: d.hB,
      margin: (d.mar ?? e8).copyWith(bottom: 60),
      padding: d.pad ?? e8,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: d.brR ?? BorderRadius.zero,
        side: d.bs,
      ),
      elevation: d.elv,
      duration: const Duration(seconds: 6),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          if (icon != null) icon,
          if (icon != null) const SizedBox(width: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) tx(title, deco: d.cp(fw: FontWeight.w600)),
              const SizedBox(height: 6),
              tx(content, deco: d.cp(fs: 15)),
            ],
          ),
          const Spacer(),
          ...?actions,
          const SizedBox(width: 10),
          if (close)
            icoBtn(Icons.close, () {
              ScaffoldMessenger.of(context).clearSnackBars();
            }),
        ],
      ),
    ),
  );
}

void marioBanner({
  required BuildContext context,
  required String title,
  Widget? icon,
  required String content,
  List<Widget>? actions,
  Deco? deco,
}) {
  Deco d = deco ?? dError;
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tx(title, deco: d.cp(fw: FontWeight.w600)),
              icoBtn(Icons.close, () {
                ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
              }),
            ],
          ),
          tx(content, deco: d.cp(fs: 15)),
        ],
      ),
      backgroundColor: d.hB,
      padding: d.pad ?? e8,
      leading: icon,
      elevation: d.elv,
      actions: [
        empty,
        ...?actions,
      ],
    ),
  );
}

// void rootPop(BuildContext context) {
//   Navigator.of(context).popUntil((route) {
//     print(ModalRoute.of(context)?.settings);
//     print(route.settings.name);
//     return true;
//     return route.settings.name == '/';
//   });
// }

Future<T?> marioActionSheet<T>({
  required BuildContext context,
  Widget? title,
  Widget? message,
  required List<Widget> children,
}) async {
  return await showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        title: title,
        message: message,
        actions: children,
        cancelButton: txbtn(
          'Cancel',
          deco: dIos.cp(F: Colors.red, fs: 20, bW: 0),
          fn: () {
            Navigator.pop(context, 5);
          },
        ),
      );
    },
  );
}

Future<T?> marioSheet<T>({
  required BuildContext context,
  required List<Widget> children,
  required Deco deco,
  Future<bool> Function()? onWillPop,
}) async {
  return await showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return WillPopScope(
        onWillPop: onWillPop,
        child: box(
          deco: deco.cp(W: deco.W ?? 300, H: deco.H ?? 300),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 3,
                  width: 30,
                  margin: e8,
                  color: Colors.grey[300],
                ),
                ...children,
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<T?> marioDialog<T>({
  required BuildContext context,
  required List<Widget> children,
  required Deco deco,
  Future<bool> Function()? onWillPop,
}) {
  return showDialog<T>(
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: onWillPop,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: brR_a_10),
          child: box(
            deco: deco.cp(W: deco.W ?? 300, H: deco.H ?? 300),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...children,
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<Map<String, dynamic>?> showLionDialog({
  required BuildContext context,
  required V3Builder orcaBuilder,
  required Deco deco,
  final LionFormKey? leoKey,
  Map<String, dynamic>? initValue,
  final Function(Map<String, dynamic>? value)? submitFn,
  Future<bool> Function()? onWillPop,
}) async {
  final formkey = lionKey();

  return await showDialog<Map<String, dynamic>?>(
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: onWillPop,
        child: Dialog(
          child: box(
            deco: deco.cp(W: deco.W ?? 300, H: deco.H ?? 300),
            child: LionForm(
              key: leoKey ?? Key(randomString(5)),
              formKey: formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    orcaBuilder(formkey, initValue),
                    txbtn(
                      'Submit',
                      deco: dBtn8,
                      fn: () async {
                        if (submitFn != null) {
                          await submitFn(formkey.value());
                        }
                        if (context.mounted) {
                          Navigator.pop(context, formkey.value());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required List<Widget> actions,
  Deco? deco,
}) {
  Deco d = deco ?? dError;

  if (!Device.isIos) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(/*icon*/ Icons.airplay_rounded, color: d.hS, size: 32),
              const SizedBox(width: 8),
              tx(title, deco: d.cp(fto: TextOverflow.ellipsis)),
            ],
          ),
          content: tx(content),
          actions: actions,
          backgroundColor: d.hB,
          semanticLabel: title,
          elevation: d.elv,
          shape: RoundedRectangleBorder(
            borderRadius: d.brR ?? BorderRadius.zero,
            side: d.bs,
          ),
        );
      },
    );
  } else {
    return showCupertinoDialog<T>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: tx(title, deco: deco),
          content: tx(content, deco: deco),
          actions: actions,
        );
      },
    );
  }
}

// showLicensePage(context: context);
// showAboutDialog(context: context);

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required Widget content,
}) {
  return showDialog<T>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: brR_a_10),
        child: content,
      );
    },
  );
}

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete this item?',
    actions: [
      txbtn('Cancel', fn: (() => Navigator.pop(context, false))),
      txbtn('Yes', fn: (() => Navigator.pop(context, true))),
    ],
    deco: dError,
  ).then((value) => value ?? false);
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to log out?',
    actions: [
      txbtn('Cancel', fn: (() => Navigator.pop(context, false))),
      txbtn('Log out', fn: (() => Navigator.pop(context, true))),
    ],
    deco: dError,
  ).then((value) => value ?? false);
}

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content: 'We have now sent you a password reset link. Please check your email for more information',
    actions: [
      txbtn('Ok', fn: (() => Navigator.pop(context))),
    ],
    deco: dError,
  );
}

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete account',
    content: 'Are you sure you want to delete your account? You cannot undo this operation!',
    actions: [
      txbtn('Cancel', fn: (() => Navigator.pop(context, false))),
      txbtn('Delete account', fn: (() => Navigator.pop(context, true))),
    ],
    deco: dError,
  ).then(
    (value) => value ?? false,
  );
}

/////////////////////////

class MySearchDelegate extends SearchDelegate {
  List<String> searchRes = [
    'Earth',
    'Sun',
    'Saturn',
    'Mercury',
    'Moon',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          }
          query = '';
        },
      ),
      IconButton(
        icon: const Icon(Icons.translate),
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: tx(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> res = searchRes.where((e) {
      return e.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: FutureBuilder(
            future: http.get(Uri.https('zenquotes.io', '/api/quotes')),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(query),
                      ...json
                          .decode(snapshot.data!.body)
                          .map(
                            (e) => ListTile(
                              title: tx(e['q'].toString()),
                              onTap: () {
                                query = e['q'];

                                showResults(context);
                              },
                            ),
                          )
                          .toList()
                    ],
                  ),
                );
              } else {
                return const Text("Nothing");
              }
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: ListView.builder(
            itemBuilder: (context, i) {
              return ListTile(
                title: tx(res[i]),
                onTap: () {
                  query = res[i];

                  showResults(context);
                },
              );
            },
            itemCount: res.length,
          ),
        ),
      ],
    );
  }
}

//////|___________|//////
//////|           |//////
//////|  Overlay  |//////
//////|           |//////
//////|___________|//////

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingScreenController({required this.close, required this.update});
}

class LoadingScreen {
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();
  factory LoadingScreen() => _shared;

  LoadingScreenController? controller;

  void show({required BuildContext context, required String text}) {
    if (controller?.update(text) ?? false) {
      return;
    } else {
      controller = showOverlay(context: context, text: text);
    }
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final infoText = StreamController<String>();
    infoText.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            LoadingScreen().hide();
          },
          child: Material(
            color: Colors.black.withAlpha(150),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 400,
                  maxHeight: size.height * 0.8,
                  minWidth: min(size.width * 0.5, 400),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        const CircularProgressIndicator.adaptive(),
                        const SizedBox(height: 10),
                        StreamBuilder(
                          stream: infoText.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data as String,
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        infoText.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        infoText.add(text);
        return true;
      },
    );
  }
}

Widget contextIosMenu(BuildContext context, Widget child, List<Lego> btns) {
  return CupertinoContextMenu.builder(
    builder: (context, animation) {
      return Material(
        child: SizedBox.expand(
          child: box(
            deco: Deco(
              5,
              W: 200,
              H: 100,
              B: Colors.blue,
              F: Colors.red,
              align: Alignment.center,
            ),
            child: Column(children: [tx('Helo'), child]),
          ),
        ),
      );
    },
    actions: [
      ...btns.map(
        (e) => CupertinoContextMenuAction(
          trailingIcon: e.icon,
          isDefaultAction: true,
          onPressed: e.fn,
          child: tx(e.name ?? ''),
        ),
      ),
      CupertinoContextMenuAction(
        isDestructiveAction: true,
        trailingIcon: CupertinoIcons.lab_flask,
        onPressed: () {
          Navigator.pop(context);
        },
        child: tx('Close'),
      ),
    ],
  );
}

class ContextMenu extends StatelessWidget {
  const ContextMenu({Key? key, required this.child, required this.options}) : super(key: key);

  final Widget child;
  final List<Lego> options;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressEnd: (details) {
        ContextOverlay().show(
          context: context,
          btns: options,
        );
      },
      child: child,
    );
  }
}

class ContextOverlay {
  static final ContextOverlay _shared = ContextOverlay._sharedInstance();
  ContextOverlay._sharedInstance();
  factory ContextOverlay() => _shared;

  LoadingScreenController? controller;

  void show({required BuildContext context, required List<Lego> btns}) {
    controller = showOverlay(context: context, btns: btns);
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required List<Lego> btns,
  }) {
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    final ssize = (Scaffold.of(context).context.findRenderObject() as RenderBox).size;
    bool down = ssize.height / 2 > offset.dy;

    final overlay = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            ContextOverlay().hide();
          },
          onPanStart: ((details) {
            ContextOverlay().hide();
          }),
          onDoubleTap: () {
            ContextOverlay().hide();
          },
          child: Material(
            color: const Color.fromARGB(50, 243, 103, 33),
            child: Stack(
              children: [
                Positioned(
                  left: (offset.dx + 160 - ssize.width > 0) ? (ssize.width - 160) : offset.dx,
                  top: offset.dy + (down ? size.height : -btns.length * 42),
                  child: box(
                    deco: Deco(1, B: Colors.white, brR: brR_a_10, W: 160, pad: e8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: btns
                          .map(
                            (e) => txbtn(
                              e.name ?? '',
                              deco: e.deco,
                              // icon: e.icon,
                              fn: () {
                                if (e.fn != null) (e.fn ?? () {})();
                                ContextOverlay().hide();
                              },
                            ),
                          )
                          .toList(),
                      // children: btns.fold(
                      //     [],
                      //     (p, e) => p
                      //       ..addAll([
                      //         e
                      //             .cp(
                      //               fn: () {
                      //                 if (e.fn != null) e.fn!();
                      //                 ContextOverlay().hide();
                      //               },
                      //               pad: e12,
                      //               elv: 0,
                      //               fs: 20,
                      //               mAlign: MainAxisAlignment.spaceBetween,
                      //               mSize: MainAxisSize.max,
                      //             )
                      //             .btn(),
                      //         if (e != btns.last)
                      //           const Divider(
                      //               height: 6, thickness: 0, color: Color.fromARGB(45, 55, 55, 55)),
                      //       ])),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (btns.isNotEmpty) {
      state.insert(overlay);
    }

    return LoadingScreenController(
      close: () {
        overlay.remove();
        return true;
      },
      update: (text) {
        return true;
      },
    );
  }
}
