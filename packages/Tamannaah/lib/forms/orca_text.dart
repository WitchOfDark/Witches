import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../tools/utils.dart';
import '../ui/decoration.dart';
import 'form_typeahead.dart';
import '../ui/primitive.dart';

import 'input_formatters.dart';
import 'orca_field.dart';

class OrcaGeneric<T> extends OrcaField {
  final T initialValue;
  final Widget Function(FormFieldState<T> fKey) builder;

  OrcaGeneric({
    required super.name,
    required super.hint,
    required super.deco,
    required this.builder,
    required this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    return FormBuilderField<T>(
      builder: (field) {
        return builder(field);
      },
      initialValue: cast<T>(initValue) ?? initialValue,
      name: name,
    );
  }
}

class OrcaText<T> extends OrcaField {
  final T initialValue;

  OrcaText({
    required super.name,
    required super.hint,
    required super.deco,
    required this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    return FormBuilderField<T>(
      builder: (field) {
        return tx(field.value.toString(), deco: deco);
      },
      initialValue: cast<T>(initValue) ?? initialValue,
      name: name,
    );
  }
}

// class _OrcaTextForm<T> extends StatefulWidget {
//   final String name;
//   final String hint;
//   final Deco deco;
//   final T? initValue;
//   final T? initialValue;
//   final String? obscure;
//   final Widget? prefix;
//   final Widget? label;
//   final Widget? suffix;
//   final String mask;
//   final bool signed;

//   final bool enabled;

//   final Function(T?)? onChanged;
//   final FormFieldValidator<T>? validator;
//   final T? Function(String)? valueTransformer;
//   final TextInputType? textInputType;
//   final List<TextInputFormatter>? inputFormatter;

//   final GlobalKey<FormBuilderState>? formKey;

//   const _OrcaTextForm({
//     super.key,
//     required this.name,
//     required this.hint,
//     required this.deco,
//     this.initValue,
//     this.initialValue,
//     this.obscure,
//     this.prefix,
//     this.label,
//     this.suffix,
//     this.mask = '',
//     this.signed = false,
//     this.enabled = true,
//     this.onChanged,
//     this.validator,
//     this.valueTransformer,
//     this.textInputType,
//     this.inputFormatter,
//     this.formKey,
//   });

//   @override
//   State<_OrcaTextForm<T>> createState() => __OrcaTextFormState<T>();
// }

// class __OrcaTextFormState<T> extends State<_OrcaTextForm<T>> {
//   bool obscurepassword = true;

//   @override
//   Widget build(BuildContext context) {
//     print('OrcaTextForm');
//     return FormBuilderField<T>(
//       name: widget.name,
//       enabled: widget.enabled,
//       onChanged: widget.onChanged,
//       validator: widget.validator,
//       initialValue: cast<T>(widget.initValue) ?? widget.initialValue,
//       builder: (field) {
//         return TextFormField(
//           keyboardType: keyBoardType<T>(widget.textInputType, widget.signed),
//           inputFormatters: inputFormatters<T>(widget.mask, widget.signed, widget.inputFormatter),
//           initialValue: (cast<T>(widget.initValue) ?? widget.initialValue)?.toString(),

//           enabled: widget.enabled,
//           onChanged: (value) {
//             field.didChange(cast<T>(valueTransformer<T>(
//                 widget.valueTransformer ?? ((v) => cast<T>(v)), widget.mask)(value)));
//           },
//           validator: (value) {
//             print("OrcaTextForm : validator");
//             final val = cast<T>(valueTransformer<T>(
//                 widget.valueTransformer ?? ((v) => cast<T>(v)), widget.mask)(value ?? ''));
//             return (widget.validator ??
//                 (m) {
//                   return null;
//                 })(cast<T>(val));
//           },
//           obscuringCharacter: widget.obscure ?? '❤', //✂⚗⚙❤☠♨⛑⛸♟♠♣♦⛏⚒⚖⛓⚔☎⚰⚱⌨✉
//           obscureText: (widget.obscure != null && obscurepassword) ? true : false,

//           toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),

//           maxLines: (widget.obscure != null) ? 1 : widget.deco.fml,
//           style: widget.deco.ts(),
//           decoration: widget.deco.iDeco(
//             hintText: widget.hint,
//             prefix: widget.prefix,
//             label: widget.label,
//             suffix: widget.obscure == null
//                 ? widget.suffix
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Tx(obscurepassword ? '🐞' : '🌝'),
//                         onPressed: () {
//                           setState(() {
//                             obscurepassword = !obscurepassword;
//                           });
//                         },
//                       ),
//                       field.hasError
//                           ? const Icon(Icons.error, color: Colors.red)
//                           : const Icon(Icons.check, color: Colors.green),
//                       const SizedBox(width: 10)
//                     ],
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }

class OrcaTextField<T> extends OrcaField {
  final T? initialValue;
  final String? obscure;
  final Widget? prefix;
  final Widget? label;
  final Widget? suffix;
  final FormFieldValidator<T>? validator;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final T? Function(String)? valTransformer;
  final String mask;
  final bool signed;
  final bool optional;
  final TextEditingController? controller;

  OrcaTextField({
    required super.name,
    required super.hint,
    required super.deco,
    super.enabled,
    super.onChanged,
    this.initialValue,
    super.key,
    this.prefix,
    this.label,
    this.suffix,
    this.obscure,
    this.validator,
    this.inputFormatter,
    this.valTransformer,
    this.textInputType,
    this.mask = '',
    this.signed = false,
    this.optional = false,
    this.controller,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    // return _OrcaTextForm<T>(
    //   name: name,
    //   hint: hint,
    //   deco: deco,
    //   enabled: enabled,
    //   onChanged: onChanged,
    //   initValue: initValue,
    //   initialValue: initialValue,
    //   key: key,
    //   prefix: prefix,
    //   label: label,
    //   suffix: suffix,
    //   obscure: obscure,
    //   validator: validator,
    //   inputFormatter: inputFormatter,
    //   textInputType: textInputType,
    //   mask: mask,
    //   signed: signed,
    //   formKey: formKey,
    // );

    return Soup<bool>(
      initValue: true,
      builder: ((obscurepassword, soupState) {
        print('OrcaTextForm');
        return FormBuilderField<T>(
          name: name,
          enabled: enabled,
          onChanged: onChanged,
          initialValue: cast<T>(initValue) ?? initialValue,
          builder: (field) {
            return TextFormField(
              keyboardType: keyBoardType<T>(textInputType, signed),
              inputFormatters: inputFormatters<T>(mask, signed, inputFormatter),
              initialValue: (cast<T>(initValue) ?? initialValue)?.toString(),

              controller: controller,

              enabled: enabled,
              onChanged: (value) {
                field.didChange(cast<T>(
                    valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(value)));
              },
              validator: (value) {
                print("OrcaTextForm : validator");
                final val = cast<T>(
                    valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(value ?? ''));

                if (!optional && val == '' || val == null) {
                  return 'Required';
                }

                return (validator ??
                    (m) {
                      return null;
                    })(cast<T>(val));
              },
              obscuringCharacter: obscure ?? '❤', //✂⚗⚙❤☠♨⛑⛸♟♠♣♦⛏⚒⚖⛓⚔☎⚰⚱⌨✉
              obscureText: (obscure != null && obscurepassword) ? true : false,

              toolbarOptions:
                  const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),

              maxLines: (obscure != null) ? 1 : deco.fml,
              style: deco.ts(),
              decoration: deco.iDeco(
                hintText: hint,
                prefix: prefix,
                label: label,
                suffix: obscure == null
                    ? suffix
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: tx(obscurepassword ? '🐞' : '🌝'),
                            onPressed: () {
                              soupState(!obscurepassword);
                            },
                          ),
                          field.hasError
                              ? const Icon(Icons.error, color: Colors.red)
                              : const Icon(Icons.check, color: Colors.green),
                          const SizedBox(width: 10)
                        ],
                      ),
              ),
            );
          },
        );
      }),
    );

    // return Soup<bool>(
    //   initValueBuilder: true,
    //   builder: ((obscurepassword, soupState) {
    //     print('Soup Orca Text');
    //     return FormBuilderTextField(
    //       key: key,
    //       name: name,
    //       enabled: enabled,
    //       onChanged: onChanged,
    //       validator: ((value) {
    //         print("OrcaTextForm : validator");
    //         final val = cast<T>(
    //             valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(value ?? ''));
    //         return (validator ??
    //             (m) {
    //               return null;
    //             })(cast<T>(val));
    //       }),
    //       initialValue: (cast<String>(initValue) ?? initialValue) != null
    //           ? (cast<String>(initValue) ?? initialValue).toString()
    //           : '',
    //       keyboardType: keyBoardType<T>(textInputType, signed),
    //       inputFormatters: inputFormatters<T>(mask, signed, inputFormatter),

    //       valueTransformer: ((value) {
    //         print('OrcaTextForm : ValueTransformer');
    //         return valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(value ?? '');
    //       }),

    //       // autofocus: autofocus,
    //       obscuringCharacter: obscure ?? '❤', //✂⚗⚙❤☠♨⛑⛸♟♠♣♦⛏⚒⚖⛓⚔☎⚰⚱⌨✉
    //       obscureText: (obscure != null && obscurepassword) ? true : false,

    //       toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),

    //       maxLines: (obscure != null) ? 1 : deco.fml,
    //       style: deco.ts(),
    //       decoration: deco.iDeco(
    //         hintText: initValue ?? hint,
    //         prefix: prefix,
    //         label: label,
    //         suffix: obscure == null
    //             ? suffix
    //             : Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   IconButton(
    //                     icon: Tx(obscurepassword ? '🐞' : '🌝'),
    //                     onPressed: () {
    //                       soupState(!obscurepassword);
    //                     },
    //                   ),
    //                   if (formKey != null) suffixCheck(formKey, name),
    //                 ],
    //               ),
    //       ),
    //     );
    //   }),
    // );
  }
}

class OrcaTypeAhead<T> extends OrcaField {
  final T initialValue;
  final Widget Function(BuildContext context, T value) itemBuilder;
  final SuggestionsCallback<T> suggestionsCallback;
  final SuggestionSelectionCallback<T> onSuggestionSelected;
  final TextEditingController controller;
  final SuggestionsBoxController suggestionsBoxController;

  final Widget? prefix;
  final Widget? label;
  final Widget? suffix;

  final FormFieldValidator<T>? validator;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final dynamic Function(T?)? valTransformer;
  final String mask;
  final bool signed;

  OrcaTypeAhead({
    required super.deco,
    required super.name,
    required super.hint,
    super.onChanged,
    super.enabled,
    super.key,
    this.prefix,
    this.label,
    this.suffix,
    required this.initialValue,
    required this.itemBuilder,
    required this.suggestionsCallback,
    required this.onSuggestionSelected,
    required this.controller,
    required this.suggestionsBoxController,
    this.validator,
    this.inputFormatter,
    this.valTransformer,
    this.textInputType,
    this.mask = '',
    this.signed = false,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    final decoration = deco.iDeco(
      hintText: hint,
      prefix: prefix,
      label: label,
      suffix: suffix,
    );
    return FormBuilderTypeAhead<T>(
      decoration: decoration,
      name: name,
      onChanged: onChanged,
      suggestionsBoxController: suggestionsBoxController,
      // hideSuggestionsOnKeyboardHide: false,
      onSuggestionSelected: onSuggestionSelected,
      itemBuilder: itemBuilder,
      controller: controller,
      initialValue: initValue ?? initialValue,
      valueTransformer: valTransformer,
      selectionToTextTransformer: ((suggestion) {
        return suggestion.toString();
      }),
      validator: (value) {
        print("OrcaTextAhead : validator");
        return (validator ??
            (m) {
              return null;
            })(value);
      },

      textFieldConfiguration: TextFieldConfiguration(
        style: deco.ts(),
        decoration: decoration,
        keyboardType: keyBoardType<T>(textInputType, signed) ?? TextInputType.text,
        inputFormatters: inputFormatters<T>(mask, signed, inputFormatter),
      ),
      suggestionsCallback: suggestionsCallback,
    );
  }
}

List<TextInputFormatter> inputFormatters<T>(
    String mask, bool signed, List<TextInputFormatter>? inputFormatters) {
  final x = [
    if (inputFormatters != null) ...inputFormatters,
    if (T == int && !signed) FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
    if (T == int && signed) FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
    if (T == double && !signed) FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
    if (T == double && signed) FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),

    //
    if (mask != '') maskInputFormatter(mask),
  ];
  return x;
}

TextInputType? keyBoardType<T>(TextInputType? textInputType, bool signed) {
  return !(T == int || T == double)
      ? textInputType
      : TextInputType.numberWithOptions(signed: signed, decimal: T == double);
}

dynamic Function(String) valueTransformer<T>(T? Function(String v) valTransformer, String mask) {
  if (mask != '') {
    return (String value) {
      return maskToReal(value, mask);
    };
  }

  return T == double
      ? doubleTransformer
      : (T == int ? intTransformer : (T == String ? stringTransformer : valTransformer));
}

String? reqField(value) {
  if (value == null) {
    return 'Required';
  }
  return null;
}

int intTransformer(String? value) {
  String v = '$value'.replaceAll(' ', '');
  int i = int.tryParse((v == 'null' || v == '') ? '0' : v) ?? 0;
  return i;
  // return i < 9223372036854775807 ? i : 0;
}

double doubleTransformer(String? value) {
  String v = '$value'.replaceAll(' ', '');
  return double.tryParse((v == 'null' || v == '') ? '0' : v) ?? 0;
}

String stringTransformer(String? value) {
  return value.toString();
}

Widget suffixCheck(GlobalKey<FormBuilderState>? formKey, String key) {
  return ((formKey?.currentState?.fields[key]?.hasError ?? false))
      ? const Icon(Icons.error, color: Colors.red)
      : const Icon(Icons.check, color: Colors.green);
}

// SuggestionsBoxController typeAheadSuggestionsBoxController() {
//   return SuggestionsBoxController();
// }
















//////////////////////////
///
///
///
///
///
///
///
///
///
///
///
///

// class _OrcaStatefulTextField<T> extends StatefulWidget {
//   const _OrcaStatefulTextField({
//     Key? key,
//     this.initialValue,
//     this.obscure,
//     this.prefix,
//     this.label,
//     this.suffix,
//     required this.name,
//     required this.hint,
//     this.initValue,
//     this.enabled = true,
//     required this.deco,
//     this.onChanged,
//     this.validator,
//     this.mask = '',
//     this.inputFormatter,
//     this.signed = false,
//     this.textInputType,
//     this.formKey,
//   }) : super(key: key);

//   final String name;
//   final String hint;
//   final T? initValue;
//   final T? initialValue;
//   final String? obscure;
//   final Widget? prefix;
//   final Widget? label;
//   final Widget? suffix;
//   final String mask;
//   final bool signed;

//   final bool enabled;

//   final Function(T?)? onChanged;
//   final FormFieldValidator? validator;
//   final TextInputType? textInputType;
//   final List<TextInputFormatter>? inputFormatter;

//   final GlobalKey<FormBuilderState>? formKey;

//   final Deco deco;

//   @override
//   State<_OrcaStatefulTextField<T>> createState() => __OrcaStatefulTextFieldState<T>();
// }

// class __OrcaStatefulTextFieldState<T> extends State<_OrcaStatefulTextField> {
//   bool obscurepassword = true;

//   @override
//   Widget build(BuildContext context) {
//     print(T);
//     return FormBuilderField<T>(
//       name: widget.name,
//       enabled: widget.enabled,
//       onChanged: widget.onChanged,
//       validator: widget.validator,
//       initialValue: cast<T>(widget.initValue) ?? widget.initialValue,
//       builder: (field) {
//         return TextFormField(
//           keyboardType: keyBoardType<T>(widget.textInputType, widget.signed),
//           validator: widget.validator,
//           inputFormatters: inputFormatters<T>(widget.mask, widget.signed, widget.inputFormatter),
//           initialValue: cast<T>(widget.initValue) ?? widget.initialValue,

//           enabled: widget.enabled,
//           onChanged: (value) {
//             field.didChange(cast<T>(valueTransformer<T>(value, (v) => null, widget.mask)(value)));
//           },
//           obscuringCharacter: widget.obscure ?? '❤', //✂⚗⚙❤☠♨⛑⛸♟♠♣♦⛏⚒⚖⛓⚔☎⚰⚱⌨✉
//           obscureText: (widget.obscure != null && obscurepassword) ? true : false,

//           toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),

//           maxLines: (widget.obscure != null) ? 1 : widget.deco.fml,
//           style: ts(widget.deco),
//           decoration: iDeco(
//             deco: widget.deco,
//             hintText: widget.initValue ?? widget.hint,
//             prefix: widget.prefix,
//             label: widget.label,
//             suffix: widget.obscure == null
//                 ? widget.suffix
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Tx(obscurepassword ? '🐞' : '🌝'),
//                         onPressed: () {
//                           setState(() {
//                             obscurepassword = !obscurepassword;
//                           });
//                         },
//                       ),
//                       field.hasError
//                           ? const Icon(Icons.error, color: Colors.red)
//                           : const Icon(Icons.check, color: Colors.green),
//                       const SizedBox(width: 10)
//                     ],
//                   ),
//           ),
//         );
//       },
//     );

//     return FormBuilderTextField(
//       name: widget.name,

//       enabled: widget.enabled,
//       onChanged: widget.onChanged,
//       // autofocus: autofocus,
//       obscuringCharacter: widget.obscure ?? '❤', //✂⚗⚙❤☠♨⛑⛸♟♠♣♦⛏⚒⚖⛓⚔☎⚰⚱⌨✉
//       obscureText: (widget.obscure != null && obscurepassword) ? true : false,

//       toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),

//       maxLines: (widget.obscure != null) ? 1 : widget.deco.fml,
//       style: ts(widget.deco),
//       decoration: iDeco(
//         deco: widget.deco,
//         hintText: widget.initValue ?? widget.hint,
//         prefix: widget.prefix,
//         label: widget.label,
//         suffix: widget.obscure == null
//             ? widget.suffix
//             : Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: Tx(obscurepassword ? '🐞' : '🌝'),
//                     onPressed: () {
//                       setState(() {
//                         obscurepassword = !obscurepassword;
//                       });
//                     },
//                   ),
//                   if (widget.formKey != null) suffixCheck(widget.formKey, widget.name),
//                 ],
//               ),
//       ),

//       // keyboardType: _keyboardType,
//       validator: widget.validator,
//       // inputFormatters: widget.inputFormatter,
//       // valueTransformer: _valueTransformer,
//     );
//   }
// }















