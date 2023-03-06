import 'package:flutter/material.dart';

import 'package:tamannaah/darkknight/debug_functions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tamannaah/forms/v3_text.dart';

import 'package:tamannaah/darkknight/utils.dart';

import '../ui/d_theme.dart';
import '../ui/decoration.dart';
import '../ui/primitive.dart';

import 'input_formatters.dart';

class V6Text<T> extends StatefulWidget {
  const V6Text({
    super.key,
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

    //
    required this.name,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.validator,
  });

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
  final bool enabled;
  final FormFieldValidator<T>? validator;

  // AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  // bool enabled = true,
  // FocusNode? focusNode,
  // FormFieldSetter<T>? onSaved,
  // FormFieldValidator<T>? validator,
  // InputDecoration decoration = const InputDecoration(),
  final String name;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  // // ValueTransformer<T?>? valueTransformer,
  // VoidCallback? onReset,

  @override
  State<V6Text<T>> createState() => _V6TextState<T>();
}

class _V6TextState<T> extends State<V6Text<T>> {
  late TextEditingController controller;
  late bool obscureBool;

  @override
  void initState() {
    super.initState();
    //setting this to value instead of initialValue here is OK since we handle initial value in the parent class
    controller = widget.controller ?? TextEditingController(text: widget.initialValue?.toString() ?? '');

    obscureBool = widget.obscure != null;
  }

  @override
  void dispose() {
    // Dispose the _controller when initState created it
    if (null == widget.controller) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Deco d = widget.deco ?? dTxf6;
    return Container(
      // padding: d.pad,
      margin: d.mar,
      width: d.W,
      height: d.H,
      child: header(
        title: tx(widget.headText ?? '', deco: d),
        row: false,
        showHeader: widget.headText != null,
        child: FormBuilderField<T>(
          name: widget.name,
          // enabled: enabled,
          onChanged: (value) {
            // if (!enabled) {
            // state.controller.text = value.toString();
            // }

            final val =
                (widget.mask != '' ? realToMask(value?.toString() ?? '', widget.mask) : value?.toString()) ?? '';

            if ((val != controller.text) &&
                cast<T>(valueTransformer<T>(widget.valTransformer ?? ((v) => cast<T>(v)), widget.mask)(
                        controller.text)) !=
                    cast<T>(valueTransformer<T>(widget.valTransformer ?? ((v) => cast<T>(v)), widget.mask)(val))) {
              controller.value = TextEditingValue(
                text: val,
                selection: TextSelection.collapsed(
                  offset: val.length,
                ),
              );
            }

            widget.onChanged?.call(value);
          },
          initialValue: cast<T>(widget.initialValue),
          validator: (value) {
            // owl("OrcaTextForm : validator");
            // final val = cast<T>(valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(
            //     cast<String>(value) ?? ''));

            final val = value;

            if (!widget.optional && val == '' || val == null) {
              return 'Required';
            }

            return (widget.validator ??
                (m) {
                  return null;
                })(val);
          },

          builder: (field) {
            return header(
              title: widget.showErrorText ? tx(field.errorText ?? '', deco: dError) : empty,
              row: false,
              rev: true,
              child: TextFormField(
                keyboardType: keyBoardType<T>(widget.textInputType, widget.signed),
                inputFormatters: inputFormatters<T>(widget.mask, widget.signed, widget.inputFormatter),

                // initialValue: initialValue?.toString(),
                controller: controller,
                // ..text = field.value?.toString() ?? initialValue?.toString() ?? '',

                enabled: widget.enabled,

                // focusNode: field.effectiveFocusNode,

                onChanged: (value) {
                  field.didChange(
                    cast<T>(
                      valueTransformer<T>(widget.valTransformer ?? ((v) => cast<T>(v)), widget.mask)(value),
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
                obscuringCharacter:
                    (widget.obscure == null || widget.obscure == '') ? '•' : widget.obscure!, //✂⚗⚙❤☠♨⛑⛸♟♠♣♦⛏⚒⚖⛓⚔☎⚰⚱⌨✉
                obscureText: (widget.obscure != null && obscureBool) ? true : false,

                // toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),
                // contextMenuBuilder: (context, editableTextState) => ,

                textAlign: widget.textCenter ? TextAlign.center : TextAlign.start,
                // selectionControls: MaterialTextSelectionControls(),
                // strutStyle: StrutStyle(fontWeight: FontWeight.w300),

                minLines: 1,
                maxLines: (widget.obscure != null) ? 1 : d.fml,
                cursorWidth: 1,

                style: d.ts(),
                decoration: d.iDeco(
                  hintText: widget.hint,
                  prefix: widget.prefix,
                  label: widget.label,
                  suffix: ExcludeFocus(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.obscure == null
                            ? (widget.suffix ?? empty)
                            : IconButton(
                                icon: Icon(obscureBool ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                onPressed: () {
                                  obscureBool = !obscureBool;
                                  // field.setState(() {});
                                  setState(() {});
                                },
                              ),
                        if (widget.showTick)
                          field.hasError
                              ? const Icon(Icons.error, color: Colors.red)
                              : const Icon(Icons.check, color: Colors.green),
                        if (field.value != null && field.value != '')
                          icoBtn(
                            Icons.close,
                            () {
                              controller.clear();
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
  }
}
