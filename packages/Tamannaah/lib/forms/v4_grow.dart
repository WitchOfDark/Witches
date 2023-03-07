import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../ui/d_theme.dart';
import '../ui/decoration.dart';
import '../ui/mario/mario.dart';
import '../ui/primitive.dart';
import 'form_lion.dart';

import 'v3_grow.dart';

class V4Grow extends FormBuilderField<List<Map<String, dynamic>>> {
  final GrowController? growController;

  // final String name;
  final String? title;
  final Deco? deco;
  final Deco? dialogDeco;
  final V3Builder orcaBuilder;

  /// while typing
  V4Grow({
    Key? key,

    //
    this.growController,
    this.title,
    this.deco,
    this.dialogDeco,
    required this.orcaBuilder,

    //From Super
    final bool enabled = true,
    required String name,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    FocusNode? focusNode,
    FormFieldSetter<List<Map<String, dynamic>>>? onSaved,
    List<Map<String, dynamic>> initialValue = const [],
    FormFieldValidator<List<Map<String, dynamic>>>? validator,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<List<Map<String, dynamic>>?>? onChanged,
    ValueTransformer<List<Map<String, dynamic>>?>? valueTransformer,
    VoidCallback? onReset,
  }) : super(
          autovalidateMode: autovalidateMode,
          decoration: decoration,
          enabled: enabled,
          focusNode: focusNode,
          initialValue: initialValue,
          key: key,
          name: name,
          onChanged: onChanged,
          onReset: onReset,
          onSaved: onSaved,
          validator: validator,
          valueTransformer: valueTransformer,
          builder: (FormFieldState<List<Map<String, dynamic>>?> field) {
            final state = field as V4GrowState;

            // lava(state.growController.keys.length);
            // unicorn(state.growController.toString());
            // dino(field.value?.length);
            // owl(field.value);
            assert(state.growController.keys.length == field.value?.length);
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
                          addButton(context, orcaBuilder, dialogDeco, state.growController, field),
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
                              state.growController,
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
                              LionFormKey indexFormKey = state.growController.keys[index];
                              return Dismissible(
                                key: Key('dismiss:${indexFormKey.toString()}'),
                                // key: Key('${randomString(4)}$index'),

                                background: dismissBack(MainAxisAlignment.start),
                                secondaryBackground: dismissBack(MainAxisAlignment.end),

                                onDismissed: (direction) {
                                  if (direction == DismissDirection.endToStart ||
                                      direction == DismissDirection.startToEnd) {
                                    deleteAt(index, state.growController, field);
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
                                            // growKeys: state.growController.keys,
                                          ),
                                        ),

                                        //       //
                                        //       const Divider(),
                                        //     ],
                                        //   ),
                                      ),

                                      //
                                      popy(context, orcaBuilder, dialogDeco, state.growController, field, index,
                                          indexFormKey),
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

  @override
  V4GrowState createState() => V4GrowState();
}

class V4GrowState extends FormBuilderFieldState<V4Grow, List<Map<String, dynamic>>> {
  late GrowController growController;

  @override
  void initState() {
    super.initState();
    growController = (widget.growController ?? GrowController())
      ..keys = (widget.initialValue ?? []).map((e) => lionKey()).toList();
  }

  @override
  void didChange(List<Map<String, dynamic>>? value) {
    super.didChange(value);
    // lava('-----------------------');
    // dino({'didChange': value});

    if (value == null || value.isEmpty) {
      growController.keys = [];
      return;
    }

    // owl('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    if (growController.keys.length == value.length) {
      for (int ii = 0; ii < value.length; ii++) {
        if (growController.keys[ii].value() != value[ii]) {
          // unicorn(ii);
          // dino(growController.keys[ii].value());
          // owl(value[ii]);
          // owl('Grow 1');
          growController.keys[ii].patch(value[ii]);
        }
      }
    }

    if (growController.keys.length > value.length) {
      for (int ii = 0; ii < growController.keys.length; ii++) {
        // dino(ii);
        if (ii >= value.length) {
          // final revList = growController.keys.reversed.toList();
          // revList.removeAt(ii);
          // growController.keys = revList;
          growController.keys.removeAt(ii);
          // lava(growController.keys);
        } else {
          // dino(growController.keys[ii].value());
          // owl(value[ii]);
          // unicorn(growController.keys[ii].value() != value[ii]);
          if (growController.keys[ii].value() != value[ii]) {
            // owl('Grow 2');
            growController.keys[ii].patch(value[ii]);
          }
          // lava('$ii ${growController.keys.length} : ${value.length}');
        }
      }
    }
    // dino('*****************************');

    if (growController.keys.length < value.length) {
      for (int ii = 0; ii < value.length; ii++) {
        // unicorn(ii);
        if (ii >= growController.keys.length) {
          growController.keys.add(LionFormKey());
        } else {
          // dino(growController.keys[ii].value());
          // owl(value[ii]);
          // unicorn(growController.keys[ii].value() != value[ii]);

          if (growController.keys[ii].value() != value[ii]) {
            // owl('Grow 3');
            growController.keys[ii].patch(value[ii]);
          }
          // unicorn('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
          // lava('$ii ${growController.keys.length} : ${value.length}');
          // dino('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
        }
      }
    }

    // dino('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    // lava('${growController.keys.length} : ${value.length}');
    // dino('+++++++++++++++++++++++++++++++++');
  }

  @override
  void dispose() {
    // Dispose the _typeAheadController when initState created it
    super.dispose();
    // _typeAheadController.dispose();
  }

  // @override
  // void reset() {
  //   super.reset();

  //   // _typeAheadController.text = _getTextString(initialValue);
  // }
}
