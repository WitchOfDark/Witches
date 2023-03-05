import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:darkknight/debug_functions.dart';
import 'package:darkknight/utils.dart';

import '../ui/d_theme.dart';
import '../ui/decoration.dart';
import '../ui/lego.dart';
import '../ui/mario/mario.dart';
import '../ui/primitive.dart';
import 'form_lion.dart';

List<T> emptyTFunction<T>(List<String> s) {
  return [];
}

typedef V3Builder = Widget Function(
  LionFormKey formKey,
  Map<String, dynamic>? initVal,
  /*{List<LionFormKey>? growKeys}*/
);

class GrowController {
  List<LionFormKey> keys;

  GrowController({this.keys = const []});

  GrowController copyWith(List<LionFormKey> newKeys) {
    keys = newKeys;
    return this;
  }
}

Widget v3Grow({
  required final String name,
  final String? title,
  final Deco? deco,
  final Deco? dialogDeco,
  final bool enabled = true,
  final GrowController? growCon,
  List<Map<String, dynamic>> initialValue = const [],
  required final V3Builder orcaBuilder,
}) {
  lava('Building V3Grow');
  return FormBuilderField<List<Map<String, dynamic>>>(
    name: name,
    initialValue: cast<List<Map<String, dynamic>>>(initialValue),
    // onChanged: ((value) {
    //   lava('-------------------------');
    //   lava(value);
    //   lava('-------------------------');

    //   // gc.keys.forEach((element) {
    //   //   dino(element.value());
    //   // });

    //   // void growUpdate(GrowController growCon, List<Map<String, dynamic>> newV) {
    //   // for (int ii = 0; ii < newV.length; ii++) {
    //   //   lava(growCon.keys[ii].value());
    //   //   dino(newV[ii]);
    //   //   owl(growCon.keys[ii].value() != newV[ii]);
    //   //   if (growCon.keys[ii].value() != newV[ii]) {
    //   //     growCon.keys[ii].patch(newV[ii]);
    //   //   }
    //   // }
    //   // }
    // }),
    builder: (field) {
      lava('Building Soup');

      return Soup(
        // initValue: (growCon ?? GrowController())..keys = (field.value ?? []).map((e) => lionKey()).toList(),
        initValue: GrowController(keys: (field.value ?? []).map((e) => lionKey()).toList()),
        // initValue: GrowController()..keys = (field.value ?? []).map((e) => lionKey()).toList(),
        builder: (initState, soupSet) {
          lava(growCon?.keys);
          dino(initState.keys);
          owl(growCon == initState);
          assert(initState.keys.length == field.value?.length);
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
                        addButton(context, orcaBuilder, dialogDeco, initState, field),
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
                          reorder(
                            oldIndex: oldIndex,
                            newIndex: newIndex,
                            initState,
                            field,
                          );
                        },
                        // padding: e16,
                        // prototypeItem: Text('prototype'),
                        // header: Text('Header'),
                        // footer: Text('Footer'),
                        children: (field.value ?? []).asMap().entries.map(
                          (e) {
                            final index = e.key;
                            final formVal = e.value;
                            LionFormKey indexFormKey = initState.keys[index];
                            return Dismissible(
                              key: Key('dismiss:${indexFormKey.toString()}'),
                              // key: Key('${randomString(4)}$index'),

                              background: dismissBack(MainAxisAlignment.start),
                              secondaryBackground: dismissBack(MainAxisAlignment.end),

                              onDismissed: (direction) {
                                if (direction == DismissDirection.endToStart ||
                                    direction == DismissDirection.startToEnd) {
                                  deleteAt(index, initState, field);
                                }
                              },
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.endToStart ||
                                    direction == DismissDirection.startToEnd) {
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
                                          n[index] = fKey.value();
                                          field.didChange(n);
                                        },
                                        // child: d0.orcaBox(orcas, initialValue: (field.value ?? [])[index]),
                                        child: orcaBuilder(
                                          indexFormKey,
                                          formVal,
                                          // growKeys: initState.keys,
                                        ),
                                      ),

                                      //       //
                                      //       const Divider(),
                                      //     ],
                                      //   ),
                                    ),

                                    //
                                    popy(context, orcaBuilder, dialogDeco, initState, field, index, indexFormKey),
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
    },
  );
}

Widget popy(
  BuildContext context,
  V3Builder orcaBuilder,
  Deco? deco,
  GrowController initState,
  FormFieldState field,
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
          deleteAt(index, initState, field);
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

            reorder(
              oldIndex: index,
              newIndex: index - 1,
              initState,
              field,
            );
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
              oldIndex: index,
              newIndex: index + 1,
              initState,
              field,
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

void deleteAt(int index, GrowController initState, FormFieldState field) {
  initState.keys.removeAt(index);

  final n = field.value ?? [];
  n.removeAt(index);
  field.didChange(n);
}

void reorder(
  GrowController initState,
  FormFieldState field, {
  required int oldIndex,
  required int newIndex,
}) {
  List<LionFormKey> lKeys = initState.keys;
  final kr = lKeys.removeAt(oldIndex);
  lKeys.insert(newIndex, kr);
  initState.keys = lKeys;

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
  FormFieldState field,
) async {
  List<Map<String, dynamic>> n = field.value ?? [];

  final hello = await showLionDialog(
    context: context,
    initValue: n[index],
    // leoKey: indexFormKey,
    orcaBuilder: orcaBuilder,
    deco: deco ?? dIos,
  );

  if (hello != null) {
    n[index] = hello;
    indexFormKey.patch(hello);
  }
}

Widget addButton(
  BuildContext context,
  V3Builder orcaBuilder,
  Deco? deco,
  GrowController initState,
  FormFieldState field,
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

          List<Map<String, dynamic>> n = (field.value ?? []);
          if (hello != null) {
            initState.keys.add(lionKey());

            field.didChange([...n, hello]);
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
