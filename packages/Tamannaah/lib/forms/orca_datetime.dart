import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'package:darkknight/utils.dart';

import '../ui/primitive.dart';

import 'form_lion.dart';
import 'orca_field.dart';
import 'orca_text.dart';

class OrcaDateTime extends OrcaField {
  final DateTime? initialValue;
  final bool? onlyTime;
  final Widget? prefix;
  final Widget? label;
  final bool optional;

  OrcaDateTime({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    this.initialValue,
    this.onlyTime,
    this.label,
    this.prefix,
    this.optional = false,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    return FormBuilderDateTimePicker(
      name: name,
      initialValue: cast<DateTime>(initValue) ?? initialValue,
      decoration: deco.iDeco(
        hintText: hint,
        prefix: prefix,
        label: label,
        suffix: icoBtn(
          Icons.date_range_outlined,
          deco: deco,
          () {},
        ),
      ),
      style: deco.ts(),
      validator: optional ? null : reqField,
      inputFormatters: [
        TextInputFormatter.withFunction((oldValue, newValue) {
          DateTime value = DateTime.parse(newValue.text);

          if (onlyTime == true) {
            return TextEditingValue(text: DateFormat().add_Hm().format(value));
          } else if (onlyTime == false) {
            return TextEditingValue(text: DateFormat().add_yMMMd().format(value));
          }
          return newValue;
        })
      ],
      inputType: onlyTime == null
          ? InputType.both
          : onlyTime == false
              ? InputType.date
              : InputType.time,
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      timePickerInitialEntryMode: TimePickerEntryMode.dialOnly,
    );
  }
}

class OrcaDateRange extends OrcaField {
  final DateTimeRange? initialValue;
  final DateTime firstDate;
  final DateTime lastDate;

  OrcaDateRange({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    this.initialValue,
    required this.firstDate,
    required this.lastDate,
  });
  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    return FormBuilderDateRangePicker(
      name: name,
      initialValue: cast<DateTimeRange>(initValue) ?? initialValue,
      firstDate: firstDate,
      lastDate: lastDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
  }
}

class OrcaDateTimeIos extends OrcaField {
  final DateTime? initialValue;
  CupertinoDatePickerMode mode;

  OrcaDateTimeIos({
    required super.deco,
    required super.name,
    required super.hint,
    super.enabled,
    required this.mode,
    this.initialValue,
  });

  @override
  Widget build({GlobalKey<FormBuilderState>? formKey, dynamic initValue}) {
    DateTime? datetime = formKey?.get<DateTime>(name) ?? initialValue ?? DateTime.now();
    return Builder(builder: (context) {
      return FormBuilderField<DateTime>(
        name: name,
        initialValue: cast<DateTime>(initValue) ?? initialValue,
        builder: (field) {
          return Row(
            children: [
              Text(DateFormat.yMMMd().format(datetime ?? DateTime.now())),
              TextButton(
                onPressed: () async {
                  DateTime? t = await showDialog<DateTime>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      DateTime p = DateTime.now();
                      return Dialog(
                        child: box(
                          deco: deco,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: CupertinoDatePicker(
                                  initialDateTime: initialValue,
                                  mode: mode,
                                  dateOrder: DatePickerDateOrder.dmy,
                                  onDateTimeChanged: (value) {
                                    p = value;
                                  },
                                ),
                              ),
                              TextButton(
                                onPressed: (() {
                                  Navigator.pop(context, p);
                                }),
                                child: const Text('Ok'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                  if (t != null) datetime = t;
                  field.didChange(datetime);
                },
                child: const Text('Date Time'),
              ),
            ],
          );
        },
      );
    });
  }
}
