import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormGrow<T> extends FormBuilderField<List<T>> {
  FormGrow({
    Key? key,
    List<TextInputFormatter>? inputFormatters,
    //From Super
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool enabled = true,
    FocusNode? focusNode,
    FormFieldSetter<List<T>>? onSaved,
    FormFieldValidator<List<T>>? validator,
    InputDecoration decoration = const InputDecoration(),
    List<T>? initialValue,
    required String name,
    ValueChanged<List<T>?>? onChanged,
    ValueTransformer<List<T>?>? valueTransformer,
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
          builder: (FormFieldState<List<T>> field) {
            final state = field as FormGrowState<T>;
            List<T> val = state.value ?? [];

            if (val.isEmpty) {
              val.add(((T == int || T == double) ? 0 : '') as T);
            }

            return StatefulBuilder(
              builder: (context, setState) {
                return ListView.builder(
                  key: Key('List $name'),
                  // shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Text('🥙$index : ${state.keys[index]}'),

                        //
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              key: Key('v ${state.keys[index]}'),
                              maxLines: null,
                              inputFormatters: inputFormatters,
                              initialValue: val.isNotEmpty ? val[index].toString() : null,
                              decoration: decoration,
                              // validator: (value) {},
                              onChanged: (o) {
                                T? e;
                                if (o == '') return;
                                if (T == int) {
                                  e = int.parse(o) as T;
                                }
                                if (T == double) {
                                  e = double.parse(o) as T;
                                }
                                e = e ?? o as T;

                                if (e != null) {
                                  val[index] = e;
                                  state.didChange(val);
                                }
                              },
                            ),
                          ),
                        ),

                        //
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          color: Colors.green,
                          onPressed: () {
                            setState(
                              () {
                                val.insert(index + 1, ((T == int || T == double) ? 0 : '') as T);
                                state.keys.insert(index + 1, val.length - 1);
                                state.didChange(val);
                              },
                            );
                          },
                        ),

                        //
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          color: Colors.red,
                          onPressed: (() async {
                            if (val.length > 1) {
                              final delete = false; //await showDeleteDialog(context);
                              if (delete) {
                                setState(
                                  () {
                                    val.removeAt(index);
                                    state.keys.removeAt(index);
                                    state.didChange(val);
                                  },
                                );
                              }
                            }
                          }),
                        ),
                      ],
                    );
                  },
                  itemCount: val.length + ((val.isEmpty) ? 1 : 0),
                );
              },
            );
          },
        );

  @override
  FormGrowState<T> createState() => FormGrowState<T>();
}

class FormGrowState<T> extends FormBuilderFieldState<FormGrow<T>, List<T>> {
  List<int> keys = [0];
}

////////////
////////////
////////////
////////////

class FbGrowTx extends StatefulWidget {
  const FbGrowTx({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<FbGrowTx> createState() => _FbGrowTxState();
}

class _FbGrowTxState extends State<FbGrowTx> {
  List<int> f = [0];

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<String>>(
      name: widget.name,
      initialValue: [''],
      builder: (field) {
        List<String> h = field.value!;

        return ListView.builder(
          key: Key('List ${widget.name}'),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('🥙$index : ${f[index]}'),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    key: Key('v ${f[index]}'),
                    maxLines: null,
                    initialValue: h[index],
                    onChanged: (e) {
                      h[index] = e;
                      field.didChange(h);
                    },
                  ),
                ),
                IconButton(
                  icon: Text('+'),
                  onPressed: () {
                    h.add('');
                    f.add(h.length - 1);
                    field.didChange(h);
                  },
                ),
                IconButton(
                  icon: Text('-'),
                  onPressed: (() {
                    if (h.length > 1) {
                      h.removeAt(index);
                      f.removeAt(index);
                      field.didChange(h);
                    }
                  }),
                ),
              ],
            );
          },
          itemCount: field.value?.length,
        );
      },
    );
  }
}
