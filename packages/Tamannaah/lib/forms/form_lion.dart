import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tamannaah/forms/v3_grow.dart';
import '../forms/form_grow.dart';
import '../forms/input_formatters.dart';

import '../tools/debug_functions.dart';
import '../tools/utils.dart';
import '../ui/decoration.dart';
import '../ui/primitive.dart';
import 'form_typeahead.dart';

extension Volcano on GlobalKey<FormBuilderState> {
  T? get<T>(String name) {
    return cast<T>(currentState?.fields[name]?.transformedValue);
  }

  Map<String, dynamic> value() {
    Map<String, dynamic> val = currentState?.value ?? {};
    if (val.isEmpty) {
      val = currentState?.instantValue ?? {};
    }

    return val;
  }

  bool validate(LionController lionController) {
    lionController.validate = true;
    return currentState?.saveAndValidate() ?? false;
  }

  void update<T>(String name, T value) {
    if (value != get(name)) {
      final f = currentState?.fields[name];

      // unicorn('${name} : ${f.runtimeType} : ${value} : ${ji(value)}');
      // if(currentState?.instantValue[name].runtimeType == FormBuilderFieldState<FormBuilderField<int>, int>){
      //   dino('${name} : ${f.runtimeType} : ${value} : ${ji(value)}');
      // }

      f?.didChange(value);
    }
  }

  void delta(Map<String, dynamic> val) {
    val.forEach((key, value) {
      if (currentState?.fields.containsKey(key) ?? false) {
        final v = get(key);
        update(
          key,
          (v.runtimeType == num || v.runtimeType == int || v.runtimeType == double) ? v + value : value,
        );
      }
    });
  }

  void patch(Map<String, dynamic> val) {
    val.forEach((key, value) {
      if (currentState?.fields.containsKey(key) ?? false) {
        update(key, value);
      }
    });
  }
}

enum Lion {
  tx,
  text,
  password,

  //Typed
  grow,
  multiSelect,
  checkgroup,
  filterchip,
  inputchip,

  //
  dropdown,
  singleSelect,
  checkbox,
  choicechip,
  radiogroup,
  sswitch,
  boolicon,

  //
  range,
  slider,
  ratings,

  //
  typeAhead,

  //
  dateRange,
  dateTime,
}

@immutable
class LionFields<T> {
  final GlobalKey? eKey;

  final String name;
  final String hintText;
  final Lion type;

  final Widget Function(Widget child, GlobalKey<FormBuilderState>? formKey)? wrapper;

  final bool signed;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;

  final bool? tristate;
  final bool horizontal;

  final String? obscure;

  final Widget? prefix;
  final Widget? label;
  final Widget? suffix;

  final List<IconData>? icons;

  final Function(dynamic)? onChanged;
  final TextInputType? textInputType;
  final FormFieldValidator<dynamic>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final ValueTransformer<dynamic>? valueTransformer;

  //TypeAhead
  final Widget Function(BuildContext, T)? itemBuilder;
  final SuggestionsCallback<T>? suggestionsCallback;
  final SuggestionSelectionCallback<T>? onSuggestionSelected;
  final TextEditingController? controller;
  final SuggestionsBoxController? suggestionsBoxController;

  final Deco? deco;

  //Formatted
  final String mask;

  final dynamic initialValue;
  final List<T> values;

  //Slider, Range
  final double min;
  final double max;
  final int div;

  const LionFields({
    this.eKey,
    required this.name,
    required this.hintText,
    required this.type,
    this.wrapper,

    //
    this.signed = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.horizontal = true,
    this.tristate = true,

    //
    this.deco,
    this.mask = '',

    //
    this.values = const [],
    this.initialValue,

    //
    this.min = 0,
    this.max = 10,
    this.div = 0,

    //
    this.obscure,
    this.prefix,
    this.label,
    this.suffix,
    this.icons,

    //
    this.onChanged,
    this.textInputType,
    this.validator,
    this.inputFormatters,
    this.valueTransformer,

    //
    this.itemBuilder,
    this.suggestionsCallback,
    this.onSuggestionSelected,
    this.controller,
    this.suggestionsBoxController,
  });

  Widget toWidget({GlobalKey<FormBuilderState>? formKey}) {
    Widget w = Container(
      width: 50,
      height: 50,
      color: Colors.red,
    );

    // print('$eKey   :   $name  :  $type');

    final List<TextInputFormatter> _inputFormatters = [
      if (inputFormatters != null) ...inputFormatters!,
      if (T == int && !signed) FilteringTextInputFormatter.allow(RegExp(r'^\d*')),
      if (T == int && signed) FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
      if (T == double && !signed) FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      if (T == double && signed) FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),

      //
      if (type == Lion.text && mask != '') maskInputFormatter(mask),
    ];

    final _keyboardType = !(T == int || T == double)
        ? textInputType
        : TextInputType.numberWithOptions(signed: signed, decimal: T == double);

    final _valueTransformer = (type == Lion.text && mask != '')
        ? (value) {
            String val = maskToReal(value ?? '', mask);

            return (T == double) ? doubleTransformer(val) : ((T == int) ? intTransformer(val) : stringTransformer(val));
          }
        : (T == double)
            ? doubleTransformer
            : ((T == int) ? intTransformer : (T == String ? stringTransformer : valueTransformer));

    final decoration = deco?.iDeco(
      hintText: hintText,
      prefix: prefix,
      label: label,
      suffix: suffix,
    );

    switch (type) {
      case Lion.ratings:
        double ratings = math.max(0, math.min(1, initialValue ?? 0));

        w = FormBuilderField(
          name: name,
          onChanged: onChanged,
          validator: validator,
          enabled: enabled,
          valueTransformer: _valueTransformer,
          builder: (field) => StatefulBuilder(
            builder: (BuildContext context, setState) {
              return GestureDetector(
                onHorizontalDragUpdate: ((details) {
                  setState(
                    () {
                      ratings = math.max(0, math.min(1, details.localPosition.dx / (deco?.W ?? 150)));
                      ratings = div > 1 ? (ratings * div).round() / div : ratings;
                    },
                  );
                }),
                onHorizontalDragEnd: ((details) {
                  field.didChange(ratings);
                }),
                onTapDown: ((details) {
                  setState(
                    () {
                      ratings = math.max(0, math.min(1, details.localPosition.dx / (deco?.W ?? 150)));
                      ratings = div > 1 ? (ratings * div).round() / div : ratings;
                      field.didChange(ratings);
                    },
                  );
                }),
                child: box(
                  deco: deco ?? Deco(3, W: 150, H: 30),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(
                          max.toInt(),
                          (index) => Icon(
                            icons?[0] ?? Icons.star,
                            color: deco?.F,
                            size: deco?.fs,
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: ratings,
                        child: Container(
                          decoration: BoxDecoration(
                            backgroundBlendMode: BlendMode.colorBurn,
                            color: deco?.S ?? Colors.yellow[400],
                            borderRadius: deco?.brR,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
        break;
      case Lion.slider:
        String sliderLabel = formKey?.get(name).toString() ?? '0';

        w = StatefulBuilder(
          builder: (context, setState) => SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              showValueIndicator: ShowValueIndicator.always,
              overlayColor: deco?.S?.withAlpha(100),
              thumbColor: deco?.S,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10, elevation: 5),
              activeTrackColor: deco?.B,
              valueIndicatorColor: deco?.B,
              valueIndicatorTextStyle: deco?.ts(),
              activeTickMarkColor: Colors.transparent,
              inactiveTickMarkColor: Colors.transparent,
            ),
            child: FormBuilderSlider(
              name: name,
              initialValue: (max + min) / 2,
              min: min,
              max: max,
              divisions: div != 0 ? div * ((max - min) ~/ 1) : null,
              displayValues: DisplayValues.none,
              // decoration: decoration,
              decoration: InputDecoration.collapsed(hintText: hintText),
              label: sliderLabel,
              onChanged: ((value) {
                setState(() {
                  sliderLabel = '${value?.round()}';
                });
                if (onChanged != null) onChanged!(value);
              }),
            ),
          ),
        );
        break;
      case Lion.range:
        String startLabel = formKey?.get(name)?.start.toString() ?? '0';
        String endLabel = formKey?.get(name)?.end.toString() ?? '0';
        w = StatefulBuilder(
          builder: (context, setState) => SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              showValueIndicator: ShowValueIndicator.always,
              overlayColor: deco?.S?.withAlpha(100),
              thumbColor: deco?.S,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10, elevation: 5),
              activeTrackColor: deco?.B,
              valueIndicatorColor: deco?.B,
              activeTickMarkColor: Colors.transparent,
              inactiveTickMarkColor: Colors.transparent,
            ),
            child: FormBuilderRangeSlider(
              name: name,
              min: min,
              initialValue: RangeValues(min, max),
              max: max,
              divisions: div != 0 ? div * ((max - min) ~/ 1) : null,
              displayValues: DisplayValues.none,
              decoration: InputDecoration.collapsed(hintText: hintText),
              labels: RangeLabels(startLabel, endLabel),
              onChanged: (value) {
                setState(
                  () {
                    startLabel = '${value?.start.round()}';
                    endLabel = '${value?.end.round()}';
                  },
                );
                if (onChanged != null) onChanged!(value);
              },
            ),
          ),
        );
        break;

      case Lion.grow:
        w = FormGrow<T>(
          name: name,
          initialValue: initialValue,
          enabled: enabled,
          onChanged: onChanged,
          // valueTransformer: _valueTransformer,
          validator: validator,
          inputFormatters: _inputFormatters,
        );
        break;

      case Lion.checkgroup:
        w = FormBuilderCheckboxGroup<T>(
          name: name,
          initialValue: initialValue,
          options: List.generate(
            values.length,
            (index) => FormBuilderFieldOption(
              value: values[index],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if ((tristate == true || tristate == null) && index < (icons?.length ?? 0))
                    Icon(
                      icons?[index],
                      color: deco?.F,
                      size: deco?.fs,
                    ),
                  if ((tristate == true) && index < (icons?.length ?? 0)) const SizedBox(width: 6),
                  if (tristate == true || tristate == false)
                    tx(
                      values[index].toString(),
                      deco: deco?.cp(F: deco?.F),
                    ),
                ],
              ),
            ),
          ),
          orientation: OptionsOrientation.vertical,
          onChanged: onChanged,
          // decoration: decoration,
          decoration: InputDecoration.collapsed(hintText: hintText),
          checkColor: deco?.F,
          activeColor: deco?.S,
        );
        break;
      case Lion.inputchip:
        w = FormBuilderField<List<T>>(
          name: name,
          initialValue: initialValue,
          builder: (field) {
            return Wrap(
              // padding: deco?.pad,
              spacing: deco?.mar?.right ?? 4,
              runSpacing: deco?.mar?.top ?? 4,
              children: List.generate(
                initialValue.length,
                (index) {
                  return InputChip(
                    avatar: (icons?.length ?? 0) > index
                        ? Icon(
                            icons?[index],
                            color: deco?.F,
                            size: deco?.fs ?? 15,
                          )
                        : null,
                    label: tx(
                      initialValue[index].toString(),
                      deco: deco?.cp(F: deco?.F),
                    ),
                    onDeleted: () {
                      print(field.value);
                      List<T>? n = field.value;
                      n?.removeAt(index);
                      field.didChange(n);
                    },
                  );
                },
              ),
            );
          },
        );
        break;
      case Lion.filterchip:
        w = FormBuilderFilterChip<T>(
          name: name,
          // decoration: decoration,
          decoration: InputDecoration.collapsed(hintText: hintText),
          selectedColor: deco?.S,
          backgroundColor: deco?.B,

          padding: deco?.pad,
          spacing: deco?.mar?.right ?? 4,
          runSpacing: deco?.mar?.top ?? 4,

          initialValue: initialValue,
          options: List.generate(
            values.length,
            (index) => FormBuilderChipOption(
              value: values[index],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index < (icons?.length ?? 0))
                    Icon(
                      icons?[index],
                      color: deco?.F,
                      size: deco?.fs,
                    ),
                  if (index < (icons?.length ?? 0)) const SizedBox(width: 6),
                  tx(
                    values[index].toString(),
                    deco: deco?.cp(F: deco?.F),
                  ),
                ],
              ),
            ),
          ),
          onChanged: onChanged,
        );
        break;

      //
      case Lion.dropdown:
        w = Theme(
          data: ThemeData(canvasColor: deco?.S),
          child: FormBuilderDropdown<T>(
            name: name,
            key: eKey,
            initialValue: initialValue,

            //
            icon: const Icon(Icons.keyboard_arrow_down),

            focusColor: Colors.transparent,
            style: deco?.ts(),
            borderRadius: deco?.brR,
            isDense: true,
            isExpanded: false,
            //

            items: List.generate(
              values.length,
              (index) => DropdownMenuItem(
                alignment: AlignmentDirectional.center,
                value: values[index],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (index < (icons?.length ?? 0))
                      Icon(
                        icons?[index],
                        color: deco?.F,
                        size: deco?.fs,
                      ),
                    // if (index < (icons?.length ?? 0)) const SizedBox(width: 6),
                    tx(
                      values[index].toString(),
                      deco: deco?.cp(F: deco?.F),
                    ),
                  ],
                ),
              ),
            ),
            onChanged: onChanged,
          ),
        );
        break;

      case Lion.checkbox:
        w = FormBuilderCheckbox(
          name: name,
          title: tx(hintText, deco: deco),
          initialValue: initialValue,
          enabled: enabled,
          onChanged: onChanged,
          autofocus: autofocus,
          valueTransformer: _valueTransformer,
          validator: validator,
          decoration: InputDecoration.collapsed(hintText: hintText),
          checkColor: deco?.F,
          activeColor: deco?.S,
        );
        break;
      case Lion.choicechip:
        w = FormBuilderChoiceChip<T>(
          name: name,
          // decoration: decoration,
          decoration: InputDecoration.collapsed(hintText: hintText),
          selectedColor: deco?.S,
          backgroundColor: deco?.B,

          padding: deco?.pad,
          spacing: deco?.mar?.right ?? 4,
          runSpacing: deco?.mar?.top ?? 4,

          onChanged: onChanged,

          initialValue: initialValue,
          options: List.generate(
            values.length,
            (index) => FormBuilderChipOption(
              value: values[index],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index < (icons?.length ?? 0))
                    Icon(
                      icons?[index],
                      color: deco?.F,
                      size: deco?.fs,
                    ),
                  if (index < (icons?.length ?? 0)) const SizedBox(width: 6),
                  tx(
                    values[index].toString(),
                    deco: deco?.cp(F: deco?.F),
                  ),
                ],
              ),
            ),
          ),
        );
        break;
      case Lion.radiogroup:
        w = FormBuilderRadioGroup<T>(
          name: name,
          decoration: InputDecoration.collapsed(hintText: hintText),
          initialValue: initialValue,
          onChanged: onChanged,
          orientation: horizontal ? OptionsOrientation.horizontal : OptionsOrientation.vertical,
          activeColor: deco?.S,
          options: List.generate(
            values.length,
            (index) => FormBuilderFieldOption(
              value: values[index],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index < (icons?.length ?? 0))
                    Icon(
                      icons?[index],
                      color: deco?.F,
                      size: deco?.fs,
                    ),
                  if (index < (icons?.length ?? 0)) const SizedBox(width: 6),
                  tx(
                    values[index].toString(),
                    deco: deco?.cp(F: deco?.F),
                  ),
                ],
              ),
            ),
          ),
        );
        break;

      case Lion.sswitch:
        w = FormBuilderField<bool>(
          key: eKey,
          name: name,
          initialValue: initialValue,
          enabled: enabled,
          onChanged: onChanged,
          valueTransformer: _valueTransformer,
          validator: validator,
          decoration: InputDecoration.collapsed(hintText: hintText),
          builder: (field) {
            return CupertinoSwitch(
              value: field.value ?? false,
              onChanged: ((value) {
                field.didChange(value);
                if (onChanged != null) onChanged!(value);
              }),
              activeColor: deco?.S,
            );
          },
        );
        // w = FormBuilderSwitch(
        //   name: name,
        //   title: Tx(hintText, deco: deco),
        //   initialValue: initialValue,
        //   enabled: enabled,
        //   onChanged: onChanged,
        //   valueTransformer: _valueTransformer,
        //   validator: validator,
        //   decoration: InputDecoration.collapsed(hintText: hintText),
        //   activeColor: deco?.S,
        // );
        break;

      case Lion.boolicon:
        w = FormBuilderField<bool>(
          name: name,
          initialValue: cast<bool>(initialValue) ?? false,
          enabled: enabled,
          onChanged: onChanged,
          valueTransformer: _valueTransformer,
          validator: validator,
          decoration: InputDecoration.collapsed(hintText: hintText),
          builder: (FormFieldState<bool> field) {
            return IconButton(
              onPressed: () {
                field.didChange(!(field.value ?? false));
              },
              icon: (field.value ?? false) ? Icon(icons?[0]) : Icon(icons?[1]),
              iconSize: deco?.W,
              padding: deco?.pad ?? e2,
              tooltip: hintText,
              color: deco?.F,
              splashRadius: deco?.W,
            );
          },
        );
        break;

      //

      case Lion.typeAhead:
        w = FormBuilderTypeAhead<T>(
          name: name,
          onChanged: onChanged,
          suggestionsBoxController: suggestionsBoxController,
          // hideSuggestionsOnKeyboardHide: false,
          onSuggestionSelected: onSuggestionSelected ?? ((suggestion) {}),
          itemBuilder: itemBuilder ??
              (context, T) {
                return Container(width: 30, height: 30, color: Colors.red);
              },
          controller: controller,
          initialValue: initialValue,
          valueTransformer: _valueTransformer,
          selectionToTextTransformer: ((suggestion) {
            return suggestion.toString();
          }),
          validator: validator,
          textFieldConfiguration: TextFieldConfiguration(
            inputFormatters: _inputFormatters,
          ),
          suggestionsCallback: suggestionsCallback ??
              (s) {
                return [];
              },
        );
        break;

      //
      case Lion.dateRange:
        w = FormBuilderDateRangePicker(
          name: name,
          firstDate: DateTime.utc(2021, 1, 7),
          lastDate: DateTime.utc(2022, 5, 18),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
        );
        break;
      case Lion.dateTime:
        w = FormBuilderDateTimePicker(
          name: name,
          initialDatePickerMode: DatePickerMode.day,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          timePickerInitialEntryMode: TimePickerEntryMode.dialOnly,
        );

        break;

      //
      case Lion.password:
        bool obscurepassword = true;

        w = StatefulBuilder(
          builder: (context, setState) {
            return FormBuilderTextField(
              name: name,

              enabled: enabled,
              readOnly: readOnly,
              onChanged: ((value) {
                onChanged != null ? onChanged!(value) : () {};
                print(obscurepassword);
                setState(() {});
              }),
              autofocus: autofocus,
              obscuringCharacter:
                  obscure ?? '❤', //⚗,⚙❤🌦☠♨🎟☠👁🎞🎟🖼🕶🛍⛑⛸🎖🕹♟♠♣♥♦🎙🎚🎛🗝⛏⚒🛠⚙🗜🛢⚗⚖⛓🛡🗡⚔☎⚰⚱🖥🖨⌨🖱🖲📽🕯🗞🏷✉
              obscureText: obscurepassword ? true : false,

              toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),

              decoration: deco?.iDeco(
                    hintText: hintText,
                    prefix: prefix,
                    suffix: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: tx(obscurepassword ? '🐞' : '🌝'),
                          onPressed: () {
                            setState(() {
                              obscurepassword = !obscurepassword;
                            });
                          },
                        ),
                        if (formKey != null) suffixCheck(formKey, name),
                      ],
                    ),
                    label: label,
                  ) ??
                  InputDecoration(),

              keyboardType: _keyboardType,
              validator: validator,
              inputFormatters: _inputFormatters,
              valueTransformer: _valueTransformer,
            );
          },
        );
        break;

      case Lion.text:
        w = FormBuilderTextField(
          name: name,

          enabled: enabled,
          readOnly: readOnly,
          onChanged: onChanged,
          autofocus: autofocus,
          obscuringCharacter:
              obscure ?? '❤', //⚗,⚙❤🌦☠♨🎟☠👁🎞🎟🖼🕶🛍⛑⛸🎖🕹♟♠♣♥♦🎙🎚🎛🗝⛏⚒🛠⚙🗜🛢⚗⚖⛓🛡🗡⚔☎⚰⚱🖥🖨⌨🖱🖲📽🕯🗞🏷✉
          obscureText: obscure != null ? true : false,

          toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),

          maxLines: deco?.fml,

          keyboardType: _keyboardType,
          validator: validator,
          inputFormatters: _inputFormatters,
          valueTransformer: _valueTransformer,
        );
        break;
      case Lion.tx:
      default:
        w = FormBuilderField<String>(
          builder: (field) {
            return tx(
              initialValue,
              deco: deco,
            );
          },
          initialValue: initialValue,
          name: name,
        );
        break;
    }

    return wrapper != null ? wrapper!(w, formKey) : w;
  }
}

@immutable
class LionForm extends StatefulWidget {
  const LionForm({
    Key? key,
    this.formKey,
    this.update,
    required this.child,
    this.initialValues,
    this.lionController,
  }) : super(key: key);

  final GlobalKey<FormBuilderState>? formKey;
  final void Function(GlobalKey<FormBuilderState> fKey)? update;
  final Widget child;
  final Map<String, dynamic>? initialValues;
  final LionController? lionController;

  @override
  State<LionForm> createState() => LionFormState();
}

class LionFormState extends State<LionForm> {
  late final GlobalKey<FormBuilderState> formKey;

  @override
  void initState() {
    super.initState();

    formKey = widget.formKey ?? GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      onChanged: () {
        formKey.currentState?.save();
        if (widget.lionController?.validate == true) {
          formKey.currentState?.validate();
        }
        // setState(() {});

        formKey.currentState?.fields.entries.toList().forEach((e) {
          if (e.value.errorText != null) print(e.value.errorText);
        });
        if (widget.update != null) {
          widget.update!(formKey);
        }
        // print(formKey.currentState?.value);
      },
      // autovalidateMode: AutovalidateMode.disabled,
      skipDisabled: true,
      autoFocusOnValidationFailure: true,

      initialValue: widget.initialValues ?? {},

      //
      child: widget.child,
    );
  }
}

class LionController {
  bool validate = false;
}

typedef LionFormKey = GlobalKey<FormBuilderState>;
GlobalKey<FormBuilderState> lionKey({String? debugLabel}) {
  return GlobalKey<FormBuilderState>(debugLabel: debugLabel);
}

typedef LionFieldState<T> = FormFieldState<T>;

int intTransformer(value) {
  String v = '$value'.replaceAll(' ', '');
  int i = int.parse((v == 'null' || v == '') ? '0' : v);
  return i;
  // return i < 9223372036854775807 ? i : 0;
}

double doubleTransformer(value) {
  String v = '$value'.replaceAll(' ', '');
  return double.parse((v == 'null' || v == '') ? '0' : v);
}

String stringTransformer(value) {
  return value.toString();
}

List listStringTransformer(value) {
  return value ?? <String>[];
}

Widget suffixCheck(GlobalKey<FormBuilderState> formKey, String key) {
  return ((formKey.currentState?.fields[key]?.hasError ?? false))
      ? const Icon(Icons.error, color: Colors.red)
      : const Icon(Icons.check, color: Colors.green);
}

SuggestionsBoxController typeAheadSuggestionsBoxController() {
  return SuggestionsBoxController();
}
