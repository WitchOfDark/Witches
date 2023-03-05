import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:tamannaah/darkknight/utils.dart';

import '../ui/decoration.dart';
import '../ui/primitive.dart';

import 'orca_field.dart';

class OrcaDropDown<T extends OrcaDato> extends OrcaField {
  final T initialValue;
  final List<T> values;

  OrcaDropDown({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    super.key,
    required this.values,
    required this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    Deco d = deco.disable(!enabled);

    return box(
      deco: d.cp(B: Colors.transparent, W: d.W),
      child: FormBuilderField<T>(
        name: name,
        key: key,
        initialValue: cast<T>(initValue) ?? initialValue,
        enabled: enabled,
        builder: (field) {
          return IgnorePointer(
            ignoring: !enabled,
            child: DropdownButton<T>(
              value: field.value,
              borderRadius: deco.brR,
              underline: empty,
              dropdownColor: deco.B,
              icon: Icon(
                CupertinoIcons.chevron_down,
                size: d.fs,
                color: d.F,
              ),
              isDense: true,
              isExpanded: true,
              items: values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: e.build(d),
                      ))
                  .toList(),
              onChanged: (value) {
                if (enabled) {
                  field.didChange(value);
                  if (onChanged != emptyFunction) onChanged(value);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class OrcaSwitch extends OrcaField {
  final bool initialValue;

  OrcaSwitch({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    super.key,
    required this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    Deco d = deco.disable(!enabled);

    return FormBuilderField<bool>(
      key: key,
      name: name,
      initialValue: cast<bool>(initValue) ?? initialValue,
      enabled: enabled,
      onChanged: onChanged,
      decoration: InputDecoration.collapsed(hintText: hint),
      builder: (field) {
        return Switch.adaptive(
          value: field.value ?? false,
          onChanged: ((value) {
            if (enabled) {
              field.didChange(value);
              if (onChanged == emptyFunction) onChanged(value);
            }
          }),
          activeColor: d.hS,
        );
      },
    );
  }
}

class OrcaBoolIcon extends OrcaField {
  final bool initialValue;
  final IconData falseIcon;
  final IconData trueIcon;

  OrcaBoolIcon({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    super.key,
    required this.falseIcon,
    required this.trueIcon,
    required this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    Deco d = deco.disable(!enabled);

    return FormBuilderField<bool>(
      name: name,
      key: key,
      initialValue: cast<bool>(initValue) ?? initialValue,
      enabled: enabled,
      onChanged: onChanged,
      decoration: InputDecoration.collapsed(hintText: hint),
      builder: (FormFieldState<bool> field) {
        return icoBtn(
          deco: d,
          label: name,
          (field.value ?? false) ? trueIcon : falseIcon,
          () {
            if (enabled) {
              field.didChange(!(field.value ?? false));
            }
          },
        );
      },
    );
  }
}

class OrcaCheckBox extends OrcaField {
  final bool initialValue;

  OrcaCheckBox({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    super.key,
    required this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    Deco d = deco.disable(!enabled);

    return FormBuilderField<bool>(
      name: name,
      key: key,
      enabled: enabled,
      initialValue: cast<bool>(initValue) ?? initialValue,
      onChanged: onChanged,
      builder: (field) {
        return Checkbox(
          value: field.value,
          onChanged: (value) {
            if (enabled) {
              field.didChange(!(field.value ?? false));
            }
          },
          checkColor: d.hB,
          activeColor: d.hS,
        );
      },
    );

    // return FormBuilderCheckbox(
    //   name: name,
    //   title: tx(hint, deco: deco),
    //   initialValue: initialValue,
    //   enabled: enabled,
    //   onChanged: onChanged,
    //   decoration: InputDecoration.collapsed(hintText: hint),
    //   checkColor: deco.hF,
    //   activeColor: deco.hS,
    // );
  }
}

class OrcaRadioGroup<T extends OrcaData> extends OrcaField {
  final T initialValue;
  final List<T> values;
  final bool vertical;

  OrcaRadioGroup({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    this.vertical = true,
    required this.initialValue,
    required this.values,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    Deco d = deco.disable(!enabled);

    return FormBuilderRadioGroup<T>(
      name: name,
      decoration: InputDecoration.collapsed(hintText: hint),
      initialValue: cast<T>(initValue) ?? initialValue,
      onChanged: onChanged,
      orientation: vertical ? OptionsOrientation.vertical : OptionsOrientation.horizontal,
      activeColor: d.hS,
      options: List.generate(
        values.length,
        (index) => FormBuilderFieldOption(
          value: values[index],
          child: values[index].build(d),
        ),
      ),
    );
  }
}

class OrcaCheckboxGroup<T extends OrcaData> extends OrcaField {
  final List<T> initialValue;
  final List<T> values;
  final bool vertical;

  OrcaCheckboxGroup({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    this.vertical = true,
    required this.initialValue,
    required this.values,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    Deco d = deco.disable(!enabled);

    return FormBuilderCheckboxGroup<T>(
      name: name,
      initialValue: cast<List<T>>(initValue) ?? initialValue,
      options: List.generate(
        values.length,
        (index) => FormBuilderFieldOption(
          value: values[index],
          child: values[index].build(d),
        ),
      ),
      orientation: vertical ? OptionsOrientation.vertical : OptionsOrientation.horizontal,
      onChanged: onChanged,
      // decoration: decoration,
      decoration: InputDecoration.collapsed(hintText: hint),
      checkColor: d.hF,
      activeColor: d.hS,
    );
  }
}
