import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:tamannaah/darkknight/utils.dart';

import '../ui/d_theme.dart';
import '../ui/decoration.dart';
import '../ui/primitive.dart';

Widget v3InputChip<T>({
  Deco? deco,
  required final String name,
  final bool enabled = true,
  required List<T> initialValue,
  final void Function(List<T>?)? onChanged,
  final Widget Function(T obj, Deco? d)? builder,
}) {
  Deco d = (deco ?? dChip12).disable(!enabled);

  return box(
    deco: d.cp(B: Colors.transparent),
    child: FormBuilderField<List<T>>(
      name: name,
      initialValue: List<T>.from(initialValue),
      enabled: enabled,
      onChanged: onChanged,
      builder: (field) {
        return Wrap(
          spacing: d.mar?.right ?? 4,
          runSpacing: d.mar?.top ?? 4,
          children: List.generate(
            initialValue.length,
            (index) {
              return InputChip(
                // showCheckmark: false,
                // selected: true,
                // selectedColor: d.alt.B,
                elevation: d.elv,
                backgroundColor: d.hB,
                side: d.bs,
                tooltip: name,
                shape: RoundedRectangleBorder(borderRadius: d.brR ?? BorderRadius.zero, side: d.bs),
                deleteIconColor: enabled ? d.hS : null,
                // avatar: initialValue[index].icon != null
                //     ? ico(initialValue[index].icon, deco: d)
                //     : null,
                label: builder != null ? builder(initialValue[index], d) : Text(initialValue[index].toString()),
                onDeleted: () {
                  if (enabled) {
                    List<T>? n = field.value;
                    n?.removeAt(index);
                    field.didChange(n);
                  }
                },
                // onPressed: (() {}),
                // onSelected: ((value) {}),
              );
            },
          ),
        );
      },
    ),
  );
}

Widget v3FilterChip<T>({
  Deco? yDeco,
  Deco? nDeco,
  required final String name,
  final bool enabled = true,
  required List<T> initialValue,
  required List<T> values,
  final void Function(List<T>?)? onChanged,
  final Widget Function(T obj, Deco? d)? builder,
}) {
  Deco yd = (yDeco ?? dIos).disable(!enabled);
  Deco nd = (nDeco ?? dError).disable(!enabled);

  assert(initialValue.length < values.length);

  return box(
    deco: yd.cp(B: Colors.transparent),
    child: FormBuilderField<List<T>>(
      name: name,
      initialValue: List<T>.from(initialValue),
      enabled: enabled,
      builder: (field) {
        return Wrap(
          spacing: yd.mar?.right ?? 4,
          runSpacing: yd.mar?.top ?? 4,
          children: List.generate(
            values.length,
            (index) {
              List<T> n = field.value ?? [];
              bool selected = n.contains(values[index]);
              Deco d = selected ? yd : nd;

              return FilterChip(
                // showCheckmark: values[index].icon == null,
                checkmarkColor: d.hS,
                elevation: d.elv,
                backgroundColor: d.hB,
                selectedColor: d.hB,
                selected: selected,
                side: d.bs,
                tooltip: name,
                shape: RoundedRectangleBorder(borderRadius: d.brR ?? BorderRadius.zero, side: d.bs),
                // avatar: values[index].icon != null ? ico(values[index].icon, deco: d) : null,
                label: builder != null ? builder(values[index], d) : Text(values[index].toString()),

                onSelected: (selection) {
                  if (enabled) {
                    if (selected) {
                      n.remove(values[index]);
                    } else {
                      n.insert(n.length, values[index]);
                    }
                    field.didChange(n);
                  }
                },
              );
            },
          ),
        );
      },
    ),
  );
}

Widget v3ChoiceChip<T>({
  Deco? yDeco,
  Deco? nDeco,
  required final String name,
  final bool enabled = true,
  required T initialValue,
  required List<T> values,
  final void Function(List<T>?)? onChanged,
  final Widget Function(T obj, Deco? d)? builder,
}) {
  Deco yd = (yDeco ?? dIos).disable(!enabled);
  Deco nd = (nDeco ?? dError).disable(!enabled);

  return box(
    deco: yd.cp(B: Colors.transparent),
    child: FormBuilderField<T>(
      name: name,
      initialValue: cast<T>(initialValue),
      enabled: enabled,
      builder: (field) {
        return Wrap(
          spacing: yd.mar?.right ?? 4,
          runSpacing: yd.mar?.top ?? 4,
          children: List.generate(
            values.length,
            (index) {
              T? n = field.value;
              bool selected = values[index] == n;
              Deco d = selected ? yd : nd;

              return FilterChip(
                // showCheckmark: values[index].icon == null,
                checkmarkColor: d.hS,
                elevation: d.elv,
                backgroundColor: d.hB,
                selectedColor: d.hB,
                selected: selected,
                side: d.bs,
                tooltip: name,
                shape: RoundedRectangleBorder(borderRadius: d.brR ?? BorderRadius.zero, side: d.bs),
                // avatar: values[index].icon != null ? ico(values[index].icon, deco: d) : null,
                label: builder != null ? builder(values[index], d) : Text(values[index].toString()),

                onSelected: (selection) {
                  n = values[index];
                  if (enabled) {
                    if (selected) {
                      field.didChange(null);
                    } else {
                      field.didChange(n);
                    }
                  }
                },
              );
            },
          ),
        );
      },
    ),
  );
}

Widget v3Segmented<T>({
  required final String name,
  final bool enabled = true,
  required dynamic initialValue,
  List<T> disabledValues = const [],
  required List<T> values,
  final Deco? deco,
  final void Function(List<T>?)? onChanged,
  final Widget Function(T obj, Deco? d)? builder,
}) {
  Type type = initialValue.runtimeType;
  assert(type == T || type == List<T>);

  Widget segmented(field) => SegmentedButton<T>(
        style: deco != null
            ? ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return deco.hS;
                  }
                  if (states.contains(MaterialState.disabled)) {
                    return deco.disable(true).hB;
                  }
                  return deco.hB;
                }),
              )
            : null,
        segments: values
            .map(
              (e) => ButtonSegment<T>(
                value: e,
                label: builder != null ? builder(e, deco) : Text(e.toString()),
                enabled: !disabledValues.contains(e),
              ),
            )
            .toList(),
        selected: field.value != null ? (type == T ? <T>{field.value} : field.value.toSet()) : <T>{},
        onSelectionChanged: (Set<T> newSelection) {
          if (enabled) {
            if (type == T) {
              field.didChange(newSelection.first);
            } else if (type == List<T>) {
              field.didChange(newSelection.toList());
            }
          }
        },
        multiSelectionEnabled: type == List<T>,
      );

  if (type == List<T>) {
    assert(initialValue.length < values.length);

    return FormBuilderField<List<T>>(
      name: name,
      initialValue: List<T>.from(initialValue),
      enabled: enabled,
      builder: (field) {
        return segmented(field);
      },
    );
  }

  return FormBuilderField<T>(
    name: name,
    initialValue: cast<T>(initialValue),
    enabled: enabled,
    builder: (field) {
      return segmented(field);
    },
  );
}
