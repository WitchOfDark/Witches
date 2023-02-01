import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../tools/utils.dart';
import '../ui/decoration.dart';
import '../ui/primitive.dart';
import 'orca_field.dart';

class OrcaInputChips<T extends OrcaData> extends OrcaField {
  final List<T> initialValue;

  OrcaInputChips({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    required this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    Deco d = deco.disable(!enabled);

    return box(
      deco: d.cp(B: Colors.transparent),
      child: FormBuilderField<List<T>>(
        name: name,
        initialValue: cast<List<T>>(initValue) ?? initialValue,
        enabled: enabled,
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
                  deleteIconColor: enabled ? d.hS : null,
                  avatar: initialValue[index].icon != null
                      ? ico(initialValue[index].icon, deco: d)
                      : null,
                  label: tx(initialValue[index].name, deco: d),
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
}

class OrcaFilterChips<T extends OrcaData> extends OrcaField {
  final List<T> initialValue;
  final List<T> values;

  OrcaFilterChips({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    required this.values,
    required this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    assert(initialValue.length < values.length);

    return box(
      deco: deco.cp(B: Colors.transparent),
      child: FormBuilderField<List<T>>(
        name: name,
        initialValue: cast<List<T>>(initValue) ?? initialValue,
        enabled: enabled,
        builder: (field) {
          return Wrap(
            spacing: deco.mar?.right ?? 4,
            runSpacing: deco.mar?.top ?? 4,
            children: List.generate(
              values.length,
              (index) {
                List<T> n = field.value ?? [];
                bool selected = n.contains(values[index]);
                Deco d = deco.disable(!enabled);
                d = selected ? d.alt : d;

                return FilterChip(
                  showCheckmark: values[index].icon == null,
                  checkmarkColor: d.hS,
                  elevation: d.elv,
                  backgroundColor: d.hB,
                  selectedColor: d.hB,
                  selected: selected,
                  side: d.bs,
                  tooltip: name,
                  avatar: values[index].icon != null ? ico(values[index].icon, deco: d) : null,
                  label: tx(values[index].name, deco: d),
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
}

class OrcaChoiceChips<T extends OrcaData> extends OrcaField {
  final T initialValue;
  final List<T> values;

  OrcaChoiceChips({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    required this.values,
    required this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    return box(
      deco: deco.cp(B: Colors.transparent),
      child: FormBuilderField<T>(
        name: name,
        initialValue: cast<T>(initValue) ?? initialValue,
        enabled: enabled,
        builder: (field) {
          return Wrap(
            spacing: deco.mar?.right ?? 4,
            runSpacing: deco.mar?.top ?? 4,
            children: List.generate(
              values.length,
              (index) {
                T? n = field.value;
                bool selected = values[index] == n;
                Deco d = deco.disable(!enabled);
                d = selected ? d.alt : d;

                return FilterChip(
                  showCheckmark: values[index].icon == null,
                  checkmarkColor: d.hS,
                  elevation: d.elv,
                  backgroundColor: d.hB,
                  selectedColor: d.hB,
                  selected: selected,
                  side: d.bs,
                  tooltip: name,
                  avatar: values[index].icon != null ? ico(values[index].icon, deco: d) : null,
                  label: tx(values[index].name, deco: d),
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

                return ChoiceChip(
                  elevation: d.elv,
                  backgroundColor: d.hB,
                  selectedColor: d.hB,
                  selected: selected,
                  side: d.bs,
                  avatar: values[index].icon != null
                      ? ico(values[index].icon, deco: d.cp(fs: (d.fs ?? 20) + 5))
                      : null,
                  label: tx(values[index].name, deco: d),
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
}
