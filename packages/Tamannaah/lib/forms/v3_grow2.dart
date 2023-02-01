// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../tools/debug_functions.dart';
import '../tools/utils.dart';
import '../ui/d_theme.dart';
import '../ui/decoration.dart';
import '../ui/lego.dart';
import '../ui/mario/mario.dart';
import '../ui/primitive.dart';
import 'form_lion.dart';

List<T> emptyTFunction<T>(List<String> s) {
  return [];
}

typedef V3Builder = Widget Function(LionFormKey formKey, Map<String, dynamic>? initVal, {List<LionFormKey>? growKeys});

class GrowItem {
  LionFormKey? key;
  Map<String, dynamic>? value;

  GrowItem({
    this.key,
    this.value,
  });

  GrowItem copyWith({
    LionFormKey? key,
    Map<String, dynamic>? value,
  }) {
    return GrowItem(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return value ?? {};
  }

  static List<GrowItem>? mapToGrow(List<Map<String, dynamic>>? m) {
    return m?.map((e) => GrowItem(key: lionKey(), value: e)).toList();
  }

  static List<GrowItem>? mix(List<Map<String, dynamic>>? m, List<LionFormKey> k) {
    List<GrowItem> newL = [];
    for (int ii = 0; ii < k.length; ii++) {
      newL.add(GrowItem(
        key: k[ii],
        value: m?[ii],
      ));
    }
    return newL;
  }
}

Widget v3Grow2({
  required final String name,
  final String? title,
  final Deco? deco,
  final Deco? dialogDeco,
  final bool enabled = true,
  List<GrowItem> initialValue = const [],
  void Function(List<GrowItem>? value)? onChanged,
  required final V3Builder orcaBuilder,
}) {
  lava('Building V3Grow');
  return FormBuilderField<List<GrowItem>>(
    name: name,
    initialValue: cast<List<GrowItem>>(initialValue),
    onChanged: ((value) {
      lava('-------------------------');
      lava(value);
      lava('-------------------------');

      if (value != null) {
        for (int ii = 0; ii < value.length; ii++) {
          owl(value[ii].key?.value());
          unicorn(value[ii].value);
          if (value[ii].key?.value() != value[ii].value) {
            value[ii].key?.patch(value[ii].value ?? {});
          }
          owl(value[ii].key?.value());
        }
      }

      dino('-------------------------');
      if (onChanged != null) {
        onChanged(value);
      }
    }),
    builder: (field) {
      lava('Building Soup');

      return box(
        deco: deco?.cp(W: deco.W ?? 300, H: deco.H ?? 300),
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    tx(title ?? '', deco: deco),
                    const SizedBox(width: 10),
                    addButton(context, orcaBuilder, dialogDeco, field),
                  ],
                ),

                //
                Expanded(
                  child: ReorderableListView(
                    buildDefaultDragHandles: false,
                    onReorder: (oldIndex, newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      reorder(oldIndex: oldIndex, newIndex: newIndex, field);
                    },
                    // padding: e16,
                    // prototypeItem: Text('prototype'),
                    // header: Text('Header'),
                    // footer: Text('Footer'),
                    children: (field.value ?? []).asMap().entries.map(
                      (e) {
                        final index = e.key;
                        LionFormKey indexFormKey = e.value.key!;
                        final formVal = e.value.value;
                        return Dismissible(
                          key: Key('dismiss:${indexFormKey.toString()}'),
                          // key: Key('${randomString(4)}$index'),

                          background: dismissBack(MainAxisAlignment.start),
                          secondaryBackground: dismissBack(MainAxisAlignment.end),

                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart || direction == DismissDirection.startToEnd) {
                              deleteAt(index, field);
                            }
                          },
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart || direction == DismissDirection.startToEnd) {
                              return await showDeleteDialog(context);
                            }
                            return false;
                          },
                          // height: 200,
                          child: inky(
                            deco: dIos.cp(bW: 1),
                            onTap: () async {
                              await update(context, index, orcaBuilder, dialogDeco, indexFormKey, field);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ReorderableDragStartListener(
                                  index: index,
                                  child: const Icon(Icons.drag_indicator),
                                ),
                                Expanded(
                                  child:
                                      // Column(
                                      //     children: [
                                      //       Text(indexFormKey
                                      //           .toString()
                                      //           .split('#')
                                      //           .last),
                                      //       mapToWidget(formVal),
                                      LionForm(
                                    key: Key('element:${indexFormKey.toString()}'),
                                    // key: Key(randomString(5)),
                                    // key: Key('$index'),
                                    formKey: indexFormKey,
                                    initialValues: formVal,
                                    update: (fKey) {
                                      final n = field.value ?? [];
                                      n[index] = e.value.copyWith(value: fKey.value());
                                      field.didChange(n);
                                    },
                                    // child: d0.orcaBox(orcas, initialValue: (field.value ?? [])[index]),
                                    child: orcaBuilder(
                                      indexFormKey,
                                      formVal,
                                      growKeys: field.value?.map((e) => e.key!).toList(),
                                    ),
                                  ),

                                  //       //
                                  //       const Divider(),
                                  //     ],
                                  //   ),
                                ),

                                //
                                popy(context, orcaBuilder, dialogDeco, field, index, indexFormKey),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

Widget popy(
  BuildContext context,
  V3Builder orcaBuilder,
  Deco? deco,
  FormFieldState<List<GrowItem>> field,
  int index,
  LionFormKey indexFormKey,
) {
  return popupMenu(
    [
      Lego(
        name: 'Delete',
        deco: dPopup8,
        icon: Icons.delete,
        fn: () {
          deleteAt(index, field);
        },
      ),
      Lego(
        name: 'Up',
        deco: dPopup8,
        icon: Icons.arrow_upward_outlined,
        fn: () {
          if (index > 0) {
            // final n = field.value ?? [];

            // final lkey = initState.keys[index];
            // initState.keys.insert(index - 1, lkey);
            // initState.keys.removeAt(index + 1);

            // final o = n[index];
            // n.insert(index - 1, o);
            // n.removeAt(index + 1);
            // field.didChange(n);

            reorder(field, oldIndex: index, newIndex: index - 1);
          }
        },
      ),
      Lego(
        name: 'Down',
        deco: dPopup8,
        icon: Icons.arrow_downward_outlined,
        fn: () {
          final n = field.value ?? [];
          if (index < n.length - 1) {
            // final lkey = initState.keys.removeAt(index);
            // initState.keys.removeAt(index);
            // initState.keys.insert(index + 1, lkey);

            // final o = n[index];
            // n.removeAt(index);
            // n.insert(index + 1, o);
            // field.didChange(n);

            reorder(
              field,
              oldIndex: index,
              newIndex: index + 1,
            );
          }
        },
      ),
      Lego(
        name: 'Update',
        deco: dPopup8,
        icon: Icons.color_lens,
        fn: () async {
          await update(context, index, orcaBuilder, deco, indexFormKey, field);
        },
      ),
    ],
  );
}

void deleteAt(int index, FormFieldState<List<GrowItem>> field) {
  final n = field.value ?? [];
  n.removeAt(index);
  field.didChange(n);
}

void reorder(
  FormFieldState<List<GrowItem>> field, {
  required int oldIndex,
  required int newIndex,
}) {
  final n = field.value ?? [];
  final o = n.removeAt(oldIndex);
  n.insert(newIndex, o);
  field.didChange(n);
}

Future<void> update(
  BuildContext context,
  int index,
  V3Builder orcaBuilder,
  Deco? deco,
  LionFormKey indexFormKey,
  FormFieldState<List<GrowItem>> field,
) async {
  List<GrowItem> n = field.value ?? [];

  final hello = await showLionDialog(
    context: context,
    initValue: n[index].value,
    // leoKey: indexFormKey,
    orcaBuilder: orcaBuilder,
    deco: deco ?? dIos,
  );

  if (hello != null) {
    n[index] = n[index].copyWith(value: hello);
    indexFormKey.patch(hello);
  }
}

Widget addButton(
  BuildContext context,
  V3Builder orcaBuilder,
  Deco? deco,
  FormFieldState<List<GrowItem>> field,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      icoBtn(
        Icons.add_outlined,
        () async {
          final hello = await showLionDialog(
            context: context,
            orcaBuilder: orcaBuilder,
            deco: deco ?? dIos,
          );

          List<GrowItem> n = (field.value ?? []);
          if (hello != null) {
            field.didChange([
              ...n,
              GrowItem(key: lionKey(), value: hello),
            ]);
          }
        },
      ),
    ],
  );
}

Widget dismissBack(MainAxisAlignment align) {
  return Container(
    color: Colors.red,
    padding: e8,
    child: Row(
      mainAxisAlignment: align,
      children: const [
        Icon(Icons.delete, color: Colors.white),
      ],
    ),
  );
}
