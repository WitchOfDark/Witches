import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../ui/d_theme.dart';

import 'package:darkknight/utils.dart';

import '../ui/decoration.dart';
import '../ui/primitive.dart';

void emptyFunction(dynamic) {}

Widget v3AddSub({
  required final num initialValue,
  required final num delta,
  final Deco? deco,
  final bool? showBoth,
  required final String name,
  final bool enabled = true,
  final void Function(num?) onChanged = emptyFunction,
}) {
  Deco d = (deco ?? dIos).disable(!enabled);

  return FormBuilderField<num>(
    name: name,
    initialValue: initialValue,
    onChanged: onChanged,
    builder: (field) {
      return mBox(
          deco: d,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showBoth == null || showBoth == false)
                icoBtn(
                  Icons.remove,
                  () {
                    final num n = field.value ?? initialValue;
                    if (enabled) field.didChange(n - delta);
                  },
                  deco: d,
                ),
              tx(field.value.toString(), deco: d),
              if (showBoth == null || showBoth == true)
                icoBtn(
                  Icons.add,
                  () {
                    final num n = field.value ?? initialValue;
                    if (enabled) field.didChange(n + delta);
                  },
                  deco: d,
                ),
            ],
          ));
    },
  );
}

Widget v3DropDown<T>({
  final T? initialValue,
  required final List<T> values,
  final Deco? deco,
  required final String name,
  final String? headText,
  final Widget? prefix,
  final String? hint,
  final Widget? label,
  final Widget Function(T obj, Deco? d)? builder,
  final bool enabled = true,
  final void Function(T?) onChanged = emptyFunction,
}) {
  Deco d = (deco ?? dIos).disable(!enabled);

  return Container(
    margin: d.mar,
    width: d.W,
    child: FormBuilderField<T>(
      name: name,
      initialValue: cast<T>(initialValue),
      enabled: enabled,
      builder: (field) {
        return header(
          title: tx(headText ?? '', deco: d),
          row: false,
          showHeader: headText != null,
          child: DropdownButtonFormField<T>(
            value: field.value,
            borderRadius: d.brR,
            decoration: d.iDeco(prefix: prefix, label: label, hintText: hint),
            dropdownColor: d.hB,
            hint: (initialValue == null) ? tx(hint ?? name) : null,
            icon: Icon(
              CupertinoIcons.chevron_down,
              size: d.fs,
              color: d.hF,
            ),
            isDense: true,
            menuMaxHeight: d.H,
            elevation: d.elv?.toInt() ?? 8,
            isExpanded: true,
            style: d.ts(),
            focusColor: Colors.transparent,
            items: values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: builder != null ? builder(e, d) : Text(e.toString()),
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

Widget v3Switch({
  required final bool initialValue,
  final Deco? deco,
  required final String name,
  final Widget? title,
  final bool enabled = true,
  final ListTileControlAffinity controlAffinity = ListTileControlAffinity.trailing,
  final void Function(bool?) onChanged = emptyFunction,
}) {
  Deco d = (deco ?? dIos).disable(!enabled);

  return FormBuilderField<bool>(
    name: name,
    initialValue: initialValue,
    enabled: enabled,
    onChanged: onChanged,
    builder: (field) {
      if (title == null) {
        return Switch.adaptive(
          value: field.value ?? false,
          onChanged: (value) {
            if (enabled) {
              field.didChange(value);
              if (onChanged == emptyFunction) onChanged(value);
            }
          },
          activeColor: d.hS,
        );
      }

      return SwitchListTile.adaptive(
        value: field.value ?? false,
        onChanged: (value) {
          if (enabled) {
            field.didChange(value);
            if (onChanged == emptyFunction) onChanged(value);
          }
        },
        title: title,
        activeColor: d.hS,
        dense: true,
        contentPadding: d.pad,
        tileColor: d.hB,
        controlAffinity: controlAffinity,
      );
    },
  );
}

Widget v3BoolIcon({
  required final bool initialValue,
  required final IconData falseIcon,
  required final IconData trueIcon,
  final Deco? deco,
  required final String name,
  final String? hint,
  final bool enabled = true,
  final void Function(bool?) onChanged = emptyFunction,
}) {
  Deco d = (deco ?? dIos).disable(!enabled);

  return FormBuilderField<bool>(
    name: name,
    initialValue: initialValue,
    enabled: enabled,
    onChanged: onChanged,
    decoration: InputDecoration.collapsed(hintText: hint),
    builder: (FormFieldState<bool> field) {
      return icoBtn(
        (field.value ?? false) ? trueIcon : falseIcon,
        deco: d,
        () {
          if (enabled) {
            field.didChange(!(field.value ?? false));
          }
        },
      );
    },
  );
}

Widget v3CheckBox({
  required final bool initialValue,
  final Deco? deco,
  required final String name,
  final Widget? title,
  final bool enabled = true,
  final ListTileControlAffinity controlAffinity = ListTileControlAffinity.trailing,
  final void Function(bool?) onChanged = emptyFunction,
}) {
  Deco d = (deco ?? dIos).disable(!enabled);

  return FormBuilderField<bool>(
    name: name,
    enabled: enabled,
    initialValue: initialValue,
    onChanged: onChanged,
    builder: (field) {
      if (title == null) {
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
      }

      return CheckboxListTile(
        value: field.value,
        onChanged: (value) {
          if (enabled) {
            field.didChange(!(field.value ?? false));
          }
        },
        checkColor: d.hB,
        activeColor: d.hS,
        tileColor: d.hB,
        title: title,
        dense: true,
        contentPadding: d.pad,
        controlAffinity: controlAffinity,
      );
    },
  );
}

Widget v3RadioGroup<T>({
  final T? initialValue,
  required final List<T> values,
  final bool vertical = true,
  final Deco? deco,
  required final String name,
  final bool enabled = true,
  final Widget Function(T obj, Deco? d)? builder,
  final ListTileControlAffinity controlAffinity = ListTileControlAffinity.trailing,
  final void Function(T?) onChanged = emptyFunction,
}) {
  Deco d = (deco ?? dIos).disable(!enabled);

  return FormBuilderField<T>(
    name: name,
    initialValue: cast<T>(initialValue),
    enabled: enabled,
    onChanged: onChanged,
    builder: (field) {
      return Column(
        // spacing: d.mar?.right ?? 4,
        // runSpacing: d.mar?.top ?? 4,
        children: List.generate(
          values.length,
          (index) {
            T? n = field.value;
            return RadioListTile<T>(
              groupValue: n,
              value: values[index],
              onChanged: (value) {
                if (enabled) {
                  if (value != n) {
                    field.didChange(value);
                  }
                }
              },
              tileColor: d.hB,
              activeColor: d.hS,
              title: builder != null ? builder(values[index], d) : Text(values[index].toString()),
              dense: true,
              contentPadding: d.pad,
              controlAffinity: controlAffinity,
            );
          },
        ),
      );
    },
  );
}

Widget v3CheckboxGroup<T>({
  required final List<T> allValues,
  required final List<T> selectedValues,
  final bool vertical = true,
  final Deco? deco,
  required final String name,
  final bool enabled = true,
  final Widget Function(T obj, Deco? d)? builder,
  final ListTileControlAffinity controlAffinity = ListTileControlAffinity.trailing,
  final void Function(List<T>?) onChanged = emptyFunction,
}) {
  Deco d = (deco ?? dIos).disable(!enabled);

  return FormBuilderField<List<T>>(
    name: name,
    initialValue: List<T>.from(selectedValues),
    enabled: enabled,
    onChanged: onChanged,
    builder: (field) {
      return Column(
        // spacing: d.mar?.right ?? 4,
        // runSpacing: d.mar?.top ?? 4,
        children: List.generate(
          allValues.length,
          (index) {
            List<T>? n = field.value;
            return CheckboxListTile(
              value: n?.contains(allValues[index]) ?? false,
              onChanged: (value) {
                if (enabled) {
                  if (n?.contains(allValues[index]) ?? false) {
                    n?.remove(allValues[index]);
                  } else {
                    n?.insert(n.length, allValues[index]);
                  }
                  field.didChange(n);
                }
              },
              tileColor: d.hB,
              activeColor: d.hS,
              checkColor: d.hF,
              title: builder != null ? builder(allValues[index], d) : Text(allValues[index].toString()),
              dense: true,
              contentPadding: d.pad,
              controlAffinity: controlAffinity,
            );
          },
        ),
      );
    },
  );
}
