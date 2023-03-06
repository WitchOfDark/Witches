import 'package:tamannaah/darkknight/debug_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tamannaah/forms/v3_text.dart';

import 'package:tamannaah/darkknight/utils.dart';

import '../ui/d_theme.dart';
import '../ui/decoration.dart';
import '../ui/primitive.dart';

import 'input_formatters.dart';

class V4Text<T> extends FormBuilderField<T> {
  //
  final TextEditingController? controller;
  final String? obscure;
  final Widget? prefix;
  final Widget? label;
  final String? headText;
  final Widget? suffix;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final T? Function(String val)? valTransformer;
  final String mask;
  final bool signed;
  final bool optional;
  final bool textCenter;
  final String? hint;
  final bool showTick;
  final bool showErrorText;
  final Deco? deco;

  V4Text({
    Key? key,

    //
    this.controller,
    this.obscure,
    this.prefix,
    this.label,
    this.headText,
    this.suffix,
    this.textInputType,
    this.inputFormatter,
    this.valTransformer,
    this.hint,
    this.deco,
    this.mask = '',
    this.signed = false,
    this.optional = false,
    this.textCenter = false,
    this.showTick = false,
    this.showErrorText = false,

    //From Super
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool enabled = true,
    FocusNode? focusNode,
    FormFieldSetter<T>? onSaved,
    FormFieldValidator<T>? validator,
    InputDecoration decoration = const InputDecoration(),
    required String name,
    T? initialValue,
    ValueChanged<T?>? onChanged,
    // ValueTransformer<T?>? valueTransformer,
    VoidCallback? onReset,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          // valueTransformer: valueTransformer,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<T?> field) {
            final state = field as V4TextState<T>;
            // final theme = Theme.of(state.context);

            Deco d = deco ?? dTxf6;
            return Container(
              // padding: d.pad,
              margin: d.mar,
              width: d.W,
              height: d.H,
              child: header(
                title: tx(headText ?? '', deco: d),
                row: false,
                showHeader: headText != null,
                child: FormBuilderField<T>(
                  name: name,
                  // enabled: enabled,
                  onChanged: ((value) {
                    // if (!enabled) {
                    // state.controller.text = value.toString();
                    // }

                    final val = (mask != '' ? realToMask(value?.toString() ?? '', mask) : value?.toString()) ?? '';

                    if ((val != state.controller.text) &&
                        cast<T>(valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(
                                state.controller.text)) !=
                            cast<T>(valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(val))) {
                      state.controller.value = TextEditingValue(
                        text: val,
                        selection: TextSelection.collapsed(
                          offset: val.length,
                        ),
                      );
                    }

                    onChanged?.call(value);
                  }),
                  initialValue: cast<T>(initialValue),
                  validator: (value) {
                    // owl("OrcaTextForm : validator");
                    // final val = cast<T>(valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(
                    //     cast<String>(value) ?? ''));

                    final val = value;

                    if (!optional && val == '' || val == null) {
                      return 'Required';
                    }

                    return (validator ??
                        (m) {
                          return null;
                        })(val);
                  },

                  builder: (field) {
                    return header(
                      title: showErrorText ? tx(field.errorText ?? '', deco: dError) : empty,
                      row: false,
                      rev: true,
                      child: TextFormField(
                        keyboardType: keyBoardType<T>(textInputType, signed),
                        inputFormatters: inputFormatters<T>(mask, signed, inputFormatter),

                        // initialValue: initialValue?.toString(),
                        controller: state.controller,
                        // ..text = field.value?.toString() ?? initialValue?.toString() ?? '',

                        enabled: enabled,

                        focusNode: state.effectiveFocusNode,

                        onChanged: (value) {
                          field.didChange(
                            cast<T>(
                              valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(value),
                            ),
                          );
                        },
                        onFieldSubmitted: (value) {
                          lava('on Field Submitted');
                        },
                        onSaved: (newValue) {
                          lava('Field saved');
                        },
                        // validator: (value) {
                        //   final val = cast<T>(valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(
                        //       cast<String>(value) ?? ''));

                        //   if (!optional && val == '' || val == null) {
                        //     return 'Required';
                        //   }

                        //   return (validator ??
                        //       (m) {
                        //         return null;
                        //       })(val);
                        // },
                        obscuringCharacter: (obscure == null || obscure == '') ? '•' : obscure, //✂⚗⚙❤☠♨⛑⛸♟♠♣♦⛏⚒⚖⛓⚔☎⚰⚱⌨✉
                        obscureText: (obscure != null && state.obscure) ? true : false,

                        // toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
                        // contextMenuBuilder: (context, editableTextState) => ,

                        textAlign: textCenter ? TextAlign.center : TextAlign.start,
                        // selectionControls: MaterialTextSelectionControls(),
                        // strutStyle: StrutStyle(fontWeight: FontWeight.w300),

                        minLines: 1,
                        maxLines: (obscure != null) ? 1 : d.fml,
                        cursorWidth: 1,

                        style: d.ts(),
                        decoration: d.iDeco(
                          hintText: hint,
                          prefix: prefix,
                          label: label,
                          suffix: ExcludeFocus(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                obscure == null
                                    ? (suffix ?? empty)
                                    : IconButton(
                                        icon: Icon(
                                            state.obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                        onPressed: () {
                                          state.obscure = !state.obscure;
                                          field.setState(() {});
                                        },
                                      ),
                                if (showTick)
                                  field.hasError
                                      ? const Icon(Icons.error, color: Colors.red)
                                      : const Icon(Icons.check, color: Colors.green),
                                if (field.value != null && field.value != '')
                                  icoBtn(
                                    Icons.close,
                                    () {
                                      state.controller.clear();
                                      // state.controller.text = '';
                                      field.didChange(cast<T>(''));
                                    },
                                    deco: d.cp(fs: 11),
                                  ),
                                // if (showTick || obscure != null) const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );

  @override
  V4TextState<T> createState() => V4TextState<T>();
}

class V4TextState<T> extends FormBuilderFieldState<V4Text<T>, T> {
  late TextEditingController controller;
  late bool obscure;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController(text: initialValue?.toString() ?? '');
    obscure = widget.obscure != null;
    // controller.addListener(_handleControllerChanged);
  }

  @override
  void didChange(T? value) {
    super.didChange(value);
    var text = value.toString();

    if (controller.text != text) {
      controller.text = text;
    }
  }

  @override
  void dispose() {
    lava('Controller Disposed');
    // Dispose the controller when initState created it
    controller.dispose();
    super.dispose();
  }

  @override
  void reset() {
    super.reset();

    controller.text = initialValue.toString();
  }
}
