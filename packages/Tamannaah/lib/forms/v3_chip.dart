import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../tools/utils.dart';
import '../ui/d_theme.dart';
import '../ui/decoration.dart';
import '../ui/primitive.dart';
import 'v3_basic.dart';

Widget v3InputChip<T>({
  Deco? deco,
  required final String name,
  final bool enabled = true,
  required List<T> initialValue,
  final void Function(List<T>?)? onChanged,
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
                label: T is V3Data ? cast<V3Data>(initialValue[index])!.build(d) : Text(initialValue[index].toString()),
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
                label: T is V3Data ? cast<V3Data>(values[index])!.build(d) : Text(values[index].toString()),
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
                label: T is V3Data ? cast<V3Data>(values[index])!.build(d) : Text(values[index].toString()),
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
