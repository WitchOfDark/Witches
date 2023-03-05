import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:darkknight/utils.dart';

import '../ui/d_theme.dart';
import '../ui/decoration.dart';
import '../ui/primitive.dart';
import 'input_formatters.dart';
import 'orca_field.dart';

Widget v3Builder<T>({
  final T? initialValue,
  required final String name,
  required final Widget Function(FormFieldState<T> fKey) builder,
}) {
  return FormBuilderField<T>(
    builder: (field) {
      return builder(field);
    },
    initialValue: initialValue,
    name: name,
  );
}

class ObscureController {
  final bool obscure;
  final TextEditingController controller;

  ObscureController(this.obscure, this.controller);

  ObscureController copyWith({
    bool? obscure,
    TextEditingController? controller,
  }) {
    return ObscureController(
      obscure ?? this.obscure,
      controller ?? this.controller,
    );
  }
}

Widget v3TextField<T>({
  final T? initialValue,
  final String? obscure,
  final Widget? prefix,
  final Widget? label,
  final String? headText,
  final Widget? suffix,
  final FormFieldValidator<T>? validator,
  final TextInputType? textInputType,
  final List<TextInputFormatter>? inputFormatter,
  final T? Function(String val)? valTransformer,
  final String mask = '',
  final bool signed = false,
  final bool optional = false,
  final bool textCenter = false,
  final TextEditingController? controller,
  required final String name,
  final String? hint,
  final bool enabled = true,
  final bool showTick = false,
  final bool showErrorText = false,
  final void Function(T? value) onChanged = emptyFunction,
  final Deco? deco,
}) {
  Deco d = deco ?? dTxf6;
  return Soup<ObscureController>(
    initValue: ObscureController(
        obscure != null, (controller ?? TextEditingController())..text = initialValue?.toString() ?? ''),
    dispose: (state) {
      state.controller.dispose();
    },
    builder: (state, soupState) {
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
                  cast<T>(valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(state.controller.text)) !=
                      cast<T>(valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(val))) {
                state.controller.value = TextEditingValue(
                  text: val,
                  selection: TextSelection.collapsed(
                    offset: val.length,
                  ),
                );
              }

              onChanged(value);
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
                child: TextField(
                  keyboardType: keyBoardType<T>(textInputType, signed),
                  inputFormatters: inputFormatters<T>(mask, signed, inputFormatter),

                  // initialValue: initialValue?.toString(),
                  controller: state.controller,
                  // ..text = field.value?.toString() ?? initialValue?.toString() ?? '',

                  enabled: enabled,

                  onChanged: (value) {
                    field.didChange(
                      cast<T>(
                        valueTransformer<T>(valTransformer ?? ((v) => cast<T>(v)), mask)(value),
                      ),
                    );
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

                  toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),

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
                                  icon: tx(state.obscure ? '🐞' : '🌝'),
                                  onPressed: () {
                                    soupState(state.copyWith(obscure: !state.obscure));
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
}

class TypeAheadController {
  final SuggestionsBoxController sugCon;
  final TextEditingController textCon;

  TypeAheadController(this.sugCon, this.textCon);
}

Widget v3Typeahead<T>({
  final T? initialValue,
  final String? initialString,
  required final Widget Function(BuildContext context, T value) itemBuilder,
  final Widget Function(BuildContext context)? noItemFoundBuilder,
  required final FutureOr<Iterable<T>> Function(String pattern, FormFieldState<T> field, TextEditingController textCon)
      suggestionsCallback,
  final void Function(T? suggestion, TextEditingController textCon)? onSuggestionSelected,
  final TextEditingController? textController,
  final SuggestionsBoxController? suggestionsBoxController,
  final void Function(T? value) onChanged = emptyFunction,
  final Widget? prefix,
  final Widget? label,
  final Widget? suffix,
  final String? headText,
  final bool textCenter = false,
  final FormFieldValidator<T>? validator,
  final TextInputType? textInputType,
  final List<TextInputFormatter>? inputFormatter,
  final dynamic Function(T? val)? valTransformer,
  final String mask = '',
  final bool signed = false,
  final bool enabled = true,
  required final String name,
  final String? hint,
  final Deco? deco,
}) {
  Deco d = deco ?? dTxf6;

  return SizedBox(
    width: d.W,
    height: d.H,
    child: header(
      title: tx(headText ?? '', deco: d),
      row: false,
      showHeader: headText != null,
      child: Soup(
        initValue: TypeAheadController(
          suggestionsBoxController ?? SuggestionsBoxController(),
          (textController ?? TextEditingController())..text = initialString ?? '',
        ),
        dispose: (state) {
          state.textCon.dispose();
        },
        builder: (initState, soupState) {
          //   return FormBuilderTypeAhead<T>(
          //     decoration: decoration,
          //     name: name,
          //     onChanged: onChanged,
          //     suggestionsBoxController: initState.sugCon,
          //     // hideSuggestionsOnKeyboardHide: false,
          //     onSuggestionSelected: onSuggestionSelected,
          //     itemBuilder: itemBuilder,
          //     controller: initState.textCon,
          //     initialValue: initialValue,
          //     valueTransformer: valTransformer,
          //     selectionToTextTransformer: ((suggestion) {
          //       return suggestion.toString();
          //     }),
          //     validator: validator,

          //       enabled: enabled,
          //     textFieldConfiguration: TextFieldConfiguration(
          //       style: d.ts(),
          //       decoration: decoration,
          //       keyboardType: keyBoardType<T>(textInputType, signed) ?? TextInputType.text,
          //       inputFormatters: inputFormatters<T>(mask, signed, inputFormatter),
          //     ),
          //     suggestionsCallback: suggestionsCallback,
          //   );
          // },

          return FormBuilderField<T>(
            name: name,
            validator: validator,
            onChanged: onChanged,
            initialValue: cast<T>(initialValue),
            valueTransformer: valTransformer,
            builder: (field) {
              final decoration = d.iDeco(
                hintText: hint,
                prefix: prefix,
                label: label,
                suffix: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (suffix != null) suffix,
                    // IconButton(
                    //   onPressed: () {
                    //     // print(controller.text);
                    //     // helloData
                    //     //     .add(Hello(name: controller.text, value: 10, icon: Icons.icecream_outlined));
                    //     // print(cntlr.value);
                    //   },
                    //   icon: Icon(CupertinoIcons.add),
                    // ),
                    if (field.value != null && initState.textCon.text != '')
                      icoBtn(
                        Icons.close,
                        () {
                          initState.textCon.clear();
                          field.didChange(null);
                        },
                        deco: d.cp(fs: 11),
                      ),
                    // IconButton(
                    //   onPressed: () {
                    //     // if (initState.sugCon.isOpened()) {
                    //     //   initState.sugCon.close();
                    //     // } else {
                    //     //   initState.sugCon.open();
                    //     // }
                    //     initState.sugCon.toggle();
                    //     // initState.sugCon.resize();
                    //   },
                    //   icon: const Icon(CupertinoIcons.chevron_down),
                    // ),
                  ],
                ),
              );

              return TypeAheadField<T>(
                textFieldConfiguration: TextFieldConfiguration(
                  enabled: enabled,
                  controller: initState.textCon,
                  // ..text = (field.value == null ? '' : field.value.toString()),
                  style: d.ts(),
                  decoration: decoration,
                  keyboardType: keyBoardType<T>(textInputType, signed) ?? TextInputType.text,
                  inputFormatters: inputFormatters<T>(mask, signed, inputFormatter),

                  cursorWidth: 1,
                  textAlign: textCenter ? TextAlign.center : TextAlign.start,
                  // textAlignVertical:
                ),
                suggestionsCallback: (value) async {
                  // initState.textCon.value = TextEditingValue(
                  //   text: value,
                  //   selection: TextSelection.collapsed(
                  //     offset: value.length,
                  //   ),
                  // );

                  return await suggestionsCallback(value, field, initState.textCon);
                },
                itemBuilder: itemBuilder,
                onSuggestionSelected: (T suggestion) {
                  if (enabled) {
                    initState.textCon.value = TextEditingValue(
                      text: suggestion.toString(),
                      selection: TextSelection.collapsed(offset: suggestion.toString().length),
                    );

                    field.didChange(suggestion);
                    onSuggestionSelected?.call(suggestion, initState.textCon);
                  }
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },

                // getImmediateSuggestions: getImmediateSuggestions,
                // errorBuilder: errorBuilder,
                noItemsFoundBuilder: noItemFoundBuilder,
                // loadingBuilder: loadingBuilder,
                // debounceDuration: debounceDuration,
                // suggestionsBoxDecoration: suggestionsBoxDecoration,
                // s+uggestionsBoxVerticalOffset: suggestionsBoxVerticalOffset,
                // animationDuration: animationDuration,
                // animationStart: animationStart,
                // direction: direction,
                hideOnLoading: true,
                // hideOnEmpty: hideOnEmpty,
                // hideOnError: hideOnError,
                // hideSuggestionsOnKeyboardHide: hideSuggestionsOnKeyboardHide,
                // keepSuggestionsOnLoading: keepSuggestionsOnLoading,
                // autoFlipDirection: autoFlipDirection,
                suggestionsBoxController: initState.sugCon,
                // keepSuggestionsOnSuggestionSelected: keepSuggestionsOnSuggestionSelected,
                // hideKeyboard: hideKeyboard,
                // scrollController: scrollController,
              );
            },
          );
        },
      ),
    ),
  );
}

List<TextInputFormatter> inputFormatters<T>(String mask, bool signed, List<TextInputFormatter>? inputFormatters) {
  if (mask == '') {
    final x = [
      if (inputFormatters != null) ...inputFormatters,
      if (T == int && !signed) FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
      if (T == int && signed) FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
      if (T == double && !signed) FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      if (T == double && signed) FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
    ];
    return x;
  }
  return [maskInputFormatter(mask)];
}

TextInputType? keyBoardType<T>(TextInputType? textInputType, bool signed) {
  return !(T == int || T == double)
      ? textInputType
      : TextInputType.numberWithOptions(signed: signed, decimal: T == double);
}

dynamic Function(String) valueTransformer<T>(T? Function(String v) valTransformer, String mask) {
  final helloTransformer = T == double ? doubleTransformer : (T == int ? intTransformer : valTransformer);

  if (mask != '') {
    return (String value) {
      final zero = helloTransformer(maskToReal(value, mask));
      return zero == 0 ? '' : zero;
    };
  }

  return helloTransformer;
}

int? intTransformer(String? value) {
  String v = '$value'.replaceAll(' ', '');
  return int.tryParse((v == 'null' || v == '') ? '0' : v);
  // return i < 9223372036854775807 ? i : 0;
}

double? doubleTransformer(String? value) {
  String v = '$value'.replaceAll(' ', '');
  return double.tryParse((v == 'null' || v == '') ? '0' : v);
}

Widget suffixCheck(GlobalKey<FormBuilderState>? formKey, String key) {
  return ((formKey?.currentState?.fields[key]?.hasError ?? false))
      ? const Icon(Icons.error, color: Colors.red)
      : const Icon(Icons.check, color: Colors.green);
}
