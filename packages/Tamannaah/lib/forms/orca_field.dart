import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../ui/decoration.dart';
import '../ui/primitive.dart';
import 'form_lion.dart';

void emptyFunction(dynamic) {}

abstract class OrcaDato {
  Widget build(Deco d);
}

abstract class OrcaData {
  final String name;
  final IconData? icon;

  OrcaData({
    required this.name,
    this.icon,
  });

  Widget build(Deco d) {
    return tx(name, deco: d);
  }
}

abstract class OrcaField {
  final GlobalKey? key;

  final String name;
  final String hint;

  final bool enabled;

  final void Function(dynamic) onChanged;

  final Deco deco;

  OrcaField({
    required this.deco,
    this.key,
    required this.name,
    required this.hint,
    this.onChanged = emptyFunction,
    this.enabled = true,
  });

  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue});
}

extension Thunder on Deco {
  Widget orcaBox(List<OrcaField> ll,
      {Map<String, dynamic>? initialValue, GlobalKey<FormBuilderState>? formKey}) {
    assert(ll.isNotEmpty);

    return mBox(
      deco: this,
      child: Column(
        children: ll
            .map((e) => e.build(
                formKey: formKey, initValue: initialValue != null ? initialValue[e.name] : null))
            .toList(),
      ),
    );
  }
}

typedef OrcaBuilder = Widget Function(LionFormKey formKey, Map<String, dynamic>? initVal);
