import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../ui/d_theme.dart';
import '../ui/decoration.dart';
import '../ui/primitive.dart';

import 'orca_field.dart';

Widget v3Slider({
  required final double min,
  required final double max,
  required final int div,
  final double? initialValue,
  final Deco? d,
  required final String name,
  final bool enabled = true,
  final void Function(double) onChanged = emptyFunction,
}) {
  Deco deco = d ?? dSlider9;
  return FormBuilderField<double>(
    name: name,
    initialValue: initialValue ?? ((max + min) / 2),
    builder: ((field) {
      return SliderTheme(
        data: SliderThemeData(
          trackHeight: deco.H ?? 2,
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
          value: field.value ?? initialValue ?? ((max + min) / 2),
          min: min,
          max: max,
          divisions: div != 0 ? div * ((max - min) ~/ 1) : null,
          label: field.value?.toStringAsPrecision(2),
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

Widget v3Range({
  required final double min,
  required final double max,
  required final int div,
  final RangeValues? initialValue,
  final Deco? d,
  required final String name,
  final bool enabled = true,
  final void Function(RangeValues) onChanged = emptyFunction,
}) {
  Deco deco = dSlider9;
  return FormBuilderField<RangeValues>(
    name: name,
    initialValue: initialValue,
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
          values: field.value ?? initialValue ?? RangeValues(min, max),
          min: min,
          max: max,
          divisions: div != 0 ? div * ((max - min) ~/ 1) : null,
          // displayValues: DisplayValues.none,
          // decoration: InputDecoration.collapsed(hintText: hint),
          labels: RangeLabels(field.value?.start.round().toString() ?? initialValue?.start.toString() ?? min.toString(),
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

double normalize<T extends num>(T min, T v, T max) {
  return (v - min) / (max - min);
}

num denormalize<T extends num>(T min, T v, T max) {
  return ((v * (max - min)) + min);
}

Widget v3Ratings({
  required final double min,
  required final double max,
  required final int number,
  required final int div,
  final double? initialValue,
  required final IconData icon,
  final IconData? secondIcon,
  Deco? d,
  required String name,
  bool enabled = true,
  final void Function(double?) onChanged = emptyFunction,
}) {
  Deco deco = (d ?? dRating10);
  deco = deco.cp(W: deco.W ?? 200);
  double ratings = normalize(min, /*cast<double>(formKey?.get<double>(name)) ??*/ initialValue ?? 0, max);

  return Container(
    padding: deco.pad,
    margin: deco.mar,
    color: deco.B,
    child: FormBuilderField<double>(
      name: name,
      onChanged: onChanged,
      // validator: validator,
      enabled: enabled,
      initialValue: ratings,
      valueTransformer: ((v) {
        return denormalize(min, v ?? 0, max);
      }),
      builder: (field) => GestureDetector(
        onHorizontalDragUpdate: ((details) {
          if (enabled) {
            ratings = math.max(0, math.min(1, details.localPosition.dx / (deco.W!)));
            ratings = div > 1 ? (ratings * div).round() / div : ratings;
            field.didChange(ratings);
            // print(ratings);
          }
        }),
        onTapDown: ((details) {
          if (enabled) {
            ratings = math.max(0, math.min(1, details.localPosition.dx / (deco.W!)));
            ratings = div > 1 ? (ratings * div).round() / div : ratings;
            field.didChange(ratings);
            // print(ratings);
          }
        }),
        child: SizedBox(
          width: deco.W,
          height: deco.H,
          // deco: deco.cp(pad: e0, mar: e0, bW: 0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ShaderMask(
                // blendMode: BlendMode.colorBurn,
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
                      color: deco.F,
                      // color: const Color.fromARGB(255, 255, 255, 255),
                      size: deco.fs,
                    ),
                  ),
                ),
              ),
              if (secondIcon != null)
                ShaderMask(
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
            ],
          ),
        ),
      ),
    ),
  );
}
