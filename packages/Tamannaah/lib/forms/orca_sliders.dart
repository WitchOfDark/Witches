import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:tamannaah/darkknight/utils.dart';

import '../ui/decoration.dart';
import '../ui/primitive.dart';

import 'form_lion.dart';
import 'orca_field.dart';

class OrcaSlider extends OrcaField {
  final double min;
  final double max;
  final int div;
  final double? initialValue;

  OrcaSlider({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    required this.min,
    required this.max,
    required this.div,
    this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    return FormBuilderField<double>(
      name: name,
      initialValue: cast<double>(initValue) ?? initialValue ?? ((max + min) / 2),
      builder: ((field) {
        return SliderTheme(
          data: SliderThemeData(
            trackHeight: deco.W ?? 2,
            showValueIndicator: ShowValueIndicator.always,
            overlayColor: deco.hS.withAlpha(100),
            thumbColor: deco.hS,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: deco.fs ?? 8, elevation: deco.elv ?? 5),
            activeTrackColor: deco.hS,
            inactiveTrackColor: deco.hF,
            valueIndicatorColor: deco.hB,
            valueIndicatorTextStyle: deco.ts(),
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
          ),
          child: Slider.adaptive(
            value: field.value ?? initValue ?? initialValue ?? ((max + min) / 2),
            min: min,
            max: max,
            divisions: div != 0 ? div * ((max - min) ~/ 1) : null,
            // displayValues: DisplayValues.none,
            // decoration: decoration,
            // decoration: InputDecoration.collapsed(hintText: hint),
            label: field.value.toString(),
            onChanged: ((value) {
              if (enabled) {
                field.didChange(value);
                onChanged(value);
              }
            }),
          ),
        );
      }),
    );
  }
}

class OrcaRange extends OrcaField {
  final double min;
  final double max;
  final int div;
  final RangeValues? initialValue;

  OrcaRange({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    required this.min,
    required this.max,
    required this.div,
    this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    return FormBuilderField<RangeValues>(
      name: name,
      initialValue: cast<RangeValues>(initValue) ?? initialValue,
      builder: ((field) {
        return SliderTheme(
          data: SliderThemeData(
            trackHeight: deco.W ?? 2,
            showValueIndicator: ShowValueIndicator.always,
            overlayColor: deco.hS.withAlpha(100),
            thumbColor: deco.hS,
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: deco.fs ?? 8, elevation: deco.elv ?? 5),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: deco.fs ?? 8, elevation: deco.elv ?? 5),
            activeTrackColor: deco.hS,
            inactiveTrackColor: deco.hF,
            valueIndicatorColor: deco.hB,
            valueIndicatorTextStyle: deco.ts(),
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
          ),
          child: RangeSlider(
            values: field.value ?? initValue ?? initialValue,
            min: min,
            max: max,
            divisions: div != 0 ? div * ((max - min) ~/ 1) : null,
            // displayValues: DisplayValues.none,
            // decoration: InputDecoration.collapsed(hintText: hint),
            labels: RangeLabels(
                field.value?.start.round().toString() ?? initialValue?.start.toString() ?? min.toString(),
                field.value?.end.round().toString() ?? initialValue?.end.toString() ?? max.toString()),
            onChanged: (value) {
              if (enabled) {
                field.didChange(value);
                onChanged(value);
              }
            },
          ),
        );
      }),
    );
  }
}

double normalize<T extends num>(T min, T v, T max) {
  return (v - min) / (max - min);
}

num denormalize<T extends num>(T min, T v, T max) {
  return ((v * (max - min)) + min);
}

class OrcaRating extends OrcaField {
  final double min;
  final double max;
  final int number;
  final int div;
  final double? initialValue;
  final IconData icon;
  final IconData? secondIcon;

  OrcaRating({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    required this.min,
    required this.max,
    required this.number,
    required this.div,
    this.initialValue,
    required this.icon,
    this.secondIcon,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    double ratings = normalize(min, cast<double>(formKey?.get<double>(name)) ?? initialValue ?? 0, max);

    return Padding(
      padding: deco.pad ?? e4,
      child: FormBuilderField<double>(
        name: name,
        onChanged: onChanged,
        // validator: validator,
        enabled: enabled,
        initialValue: cast<double>(initValue) ?? ratings,
        valueTransformer: ((v) {
          return denormalize(min, v ?? 0, max);
        }),
        builder: (field) => StatefulBuilder(
          builder: (BuildContext context, setState) {
            return GestureDetector(
              onHorizontalDragUpdate: ((details) {
                if (enabled) {
                  setState(
                    () {
                      ratings = math.max(0, math.min(1, details.localPosition.dx / (deco.W ?? 150)));
                      ratings = div > 1 ? (ratings * div).round() / div : ratings;
                    },
                  );
                  field.didChange(ratings);
                }
              }),
              onTapDown: ((details) {
                if (enabled) {
                  setState(
                    () {
                      ratings = math.max(0, math.min(1, details.localPosition.dx / (deco.W ?? 150)));
                      ratings = div > 1 ? (ratings * div).round() / div : ratings;
                      field.didChange(ratings);
                    },
                  );
                }
              }),
              child: Stack(
                children: [
                  box(
                    deco: deco.cp(W: deco.W ?? 200, H: deco.H ?? 50, mar: e0, pad: e0),
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: ((bounds) {
                        return LinearGradient(
                          colors: [deco.hF, deco.hF, deco.hS, deco.hS],
                          stops: [
                            0,
                            ratings,
                            ratings,
                            1,
                          ],
                        ).createShader(bounds);
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                          number,
                          (index) => Icon(
                            icon,
                            // color: deco.F,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            size: deco.fs,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (secondIcon != null)
                    box(
                      deco: deco.cp(W: deco.W ?? 200, H: deco.H ?? 50, mar: e0, pad: e0),
                      child: ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: ((bounds) {
                          return LinearGradient(
                            colors: [deco.hF, deco.hF, Colors.white, Colors.white],
                            stops: [
                              0,
                              ratings,
                              ratings,
                              1,
                            ],
                          ).createShader(bounds);
                        }),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                            number,
                            (index) => Icon(
                              secondIcon,
                              color: deco.F,
                              size: (deco.fs ?? 20) - 9,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
