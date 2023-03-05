import 'package:tamannaah/darkknight/extensions/build_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import '../ui/mario/mario.dart';

import 'package:tamannaah/darkknight/utils.dart';

import '../ui/d_theme.dart';
import '../ui/decoration.dart';
import '../ui/primitive.dart';

import 'date_timeline.dart';
import 'orca_text.dart';

Widget v3DateTimeline({
  final DateTime? initialValue,
  required final String name,
  final Deco? deco,
  final Function(DateTime?)? onChanged,
}) {
  return FormBuilderField<DateTime>(
    name: name,
    initialValue: initialValue,
    builder: (field) {
      return DateTimelinePicker(
        DateTime.now(),
        height: deco?.H ?? 100,
        width: deco?.W ?? 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: deco?.B ?? Colors.indigo,
        selectedTextColor: deco?.F ?? Colors.white,
        onDateChange: (selectedDate) {
          field.didChange(selectedDate);
        },
      );
    },
    onChanged: onChanged,
  );
}

Widget v3DateTime({
  required final String name,
  required final String hint,
  final Deco? deco,
  final bool enabled = true,
  final DateTime? initialValue,
  final bool? onlyTime,
  final Widget? prefix,
  final Widget? label,
  final bool optional = false,
}) {
  Deco d = deco ?? dIos;
  return Soup(
    initValue: TextEditingController(),
    dispose: (controller) {
      controller.dispose();
    },
    builder: (controller, soupState) => FormBuilderDateTimePicker(
      name: name,
      initialValue: initialValue,
      decoration: d.iDeco(
        hintText: hint,
        prefix: prefix,
        label: label,
        suffix: IconButton(
          icon: const Icon(Icons.close),
          iconSize: d.fs,
          color: d.hS,
          onPressed: () {
            controller.clear();
          },
        ),
      ),
      enabled: enabled,
      style: d.ts(),
      validator: optional ? null : reqField,
      inputFormatters: [
        TextInputFormatter.withFunction((oldValue, newValue) {
          DateTime value = DateTime.parse(newValue.text);

          if (onlyTime == true) {
            return TextEditingValue(text: DateFormat.Hm().format(value));
          } else if (onlyTime == false) {
            return TextEditingValue(text: DateFormat.yMMMM().format(value));
          } else {
            return TextEditingValue(text: DateFormat.yMMMMEEEEd().format(value));
          }
          // return newValue;
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
    ),
  );
}

Widget v3DateRange({
  required final String name,
  required final String hint,
  final Deco? deco,
  final bool enabled = true,
  final Widget? prefix,
  final Widget? label,
  final bool optional = false,
  final DateTimeRange? initialValue,
  required final DateTime firstDate,
  required final DateTime lastDate,
}) {
  Deco d = deco ?? dIos;
  return Soup(
    initValue: TextEditingController(),
    dispose: (controller) {
      controller.dispose();
    },
    builder: (controller, soupState) => FormBuilderDateRangePicker(
      name: name,
      initialValue: initialValue,
      firstDate: firstDate,
      lastDate: lastDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      controller: controller,

      enabled: enabled,

      //
      decoration: d.iDeco(
        hintText: hint,
        prefix: prefix,
        label: label,
        suffix: IconButton(
          icon: const Icon(Icons.close),
          iconSize: d.fs,
          color: d.hS,
          onPressed: () {
            controller.clear();
          },
        ),
      ),
      style: d.ts(),
      validator: optional ? null : reqField,
    ),
  );
}

Widget v3DateTimeIos({
  required final String name,
  required final String hint,
  final Deco? deco,
  // final bool enabled = true,
  final DateTime? initialValue,
  final bool? onlyTime,
}) {
  Deco d = deco ?? dScaf0;
  return Builder(
    builder: (context) {
      return FormBuilderField<DateTime>(
        name: name,
        initialValue: initialValue,
        builder: (field) {
          return ListTile(
            title: tx(
              field.value != null
                  ? (onlyTime == null
                      ? DateFormat.yMMMMEEEEd().format(field.value!)
                      : (onlyTime == true
                          ? DateFormat.Hm().format(field.value!)
                          : DateFormat.yMMMd().format(field.value!)))
                  : hint,
              deco: d.disable(field.value == null),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              iconSize: d.fs,
              color: d.hS,
              onPressed: () {
                field.didChange(null);
              },
            ),
            onTap: () async {
              DateTime p = DateTime.now();
              DateTime? t = await marioSheet<DateTime>(
                context: context,
                deco: dScaf0.cp(H: 300, mar: e8, brR: brR_a_10),
                children: [
                  Text(hint).cp(dH2),
                  SizedBox(
                    height: 250,
                    child: CupertinoDatePicker(
                      initialDateTime: field.value ?? initialValue,
                      backgroundColor: dScaf0.B,
                      mode: (onlyTime == false)
                          ? CupertinoDatePickerMode.date
                          : (onlyTime == true ? CupertinoDatePickerMode.time : CupertinoDatePickerMode.dateAndTime),
                      dateOrder: DatePickerDateOrder.dmy,
                      onDateTimeChanged: (value) {
                        p = value;
                      },
                    ),
                  ),
                ],
                onWillPop: () async {
                  Navigator.pop(context, p);
                  return true;
                },
              );

              field.didChange(t);
            },
          );
        },
      );
    },
  );
}

Widget v3Clock<T>({
  required final String name,
  required final String hint,
  final Deco? deco,
  final T? initialValue,
  final String? headText,
  final bool? onlyTime,
  final bool enabled = true,
  final bool optional = false,
  final bool ios = false,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  Deco d = (deco ?? dScaf0).disable(!enabled);
  firstDate = firstDate ?? DateTime(DateTime.now().year - 1);
  lastDate = lastDate ?? DateTime.now();
  assert(T == DateTime || T == DateTimeRange || T == Duration);
  return header(
    title: tx(headText ?? '', deco: d),
    row: false,
    showHeader: headText != null,
    child: Builder(
      builder: (context) {
        return FormBuilderField<T>(
          name: name,
          initialValue: cast<T>(initialValue),
          validator: optional ? null : reqField,
          builder: (field) {
            return btn(
              deco: d,
              child: box(
                deco: d.cp(bW: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ico(Icons.timelapse, deco: d),
                    tx(
                      field.value != null
                          ? T == Duration
                              ? r1(cast<Duration>(field.value)!, onlyTime)
                              : ((T == DateTime
                                  ? onlyTime == null
                                      ? f1(cast<DateTime>(field.value)!)
                                      : onlyTime == true
                                          ? h1(cast<DateTime>(field.value)!)
                                          : d0(cast<DateTime>(field.value)!)
                                  : '(${d2(cast<DateTimeRange>(field.value)!.start)})   to   (${d2(cast<DateTimeRange>(field.value)!.end)})'))
                          : hint,
                      deco: d.disable(field.value == null).cp(fml: 1, fto: TextOverflow.ellipsis),
                    ),
                    if (field.value != null)
                      icoBtn(
                        Icons.close,
                        () {
                          field.didChange(null);
                        },
                        deco: d,
                      ),
                    if (field.value == null) empty,
                  ],
                ),
              ),
              fn: !enabled
                  ? () {}
                  : () async {
                      if (T == Duration) {
                        Duration t = const Duration();
                        await marioSheet<Duration>(
                          context: context,
                          deco: dScaf0.cp(H: 300, mar: e8, brR: brR_a_10),
                          children: [
                            Text(hint).cp(dH2),
                            SizedBox(
                              height: 250,
                              child: CupertinoTimerPicker(
                                mode: (onlyTime == false)
                                    ? CupertinoTimerPickerMode.ms
                                    : (onlyTime == true ? CupertinoTimerPickerMode.hms : CupertinoTimerPickerMode.hm),
                                initialTimerDuration: cast<Duration>(field.value ?? initialValue) ?? const Duration(),
                                onTimerDurationChanged: (Duration newDuration) {
                                  t = newDuration;
                                },
                              ),
                            ),
                          ],
                          onWillPop: () async {
                            if (t != const Duration()) {
                              field.didChange(cast<T>(t));
                            }
                            return true;
                          },
                        );
                      } else if (T == DateTime) {
                        DateTime p = DateTime.now();
                        DateTime? t;
                        if (Device.isIos || Device.isMac || ios) {
                          t = await marioSheet<DateTime>(
                            context: context,
                            deco: dScaf0.cp(H: 300, mar: e8, brR: brR_a_10),
                            children: [
                              Text(hint).cp(dH2),
                              SizedBox(
                                height: 250,
                                child: CupertinoDatePicker(
                                  initialDateTime: cast<DateTime>(field.value ?? initialValue),
                                  backgroundColor: dScaf0.B,
                                  use24hFormat: false,
                                  mode: (onlyTime == false)
                                      ? CupertinoDatePickerMode.date
                                      : (onlyTime == true
                                          ? CupertinoDatePickerMode.time
                                          : CupertinoDatePickerMode.dateAndTime),
                                  dateOrder: DatePickerDateOrder.dmy,
                                  onDateTimeChanged: (value) {
                                    p = value;
                                  },
                                  // minimumDate: firstDate,
                                  // maximumDate: lastDate,
                                ),
                              ),
                            ],
                            onWillPop: () async {
                              Navigator.pop(context, p);
                              return true;
                            },
                          );
                        } else {
                          DateTime? dd;
                          TimeOfDay? tt;
                          if (onlyTime == false || onlyTime == null) {
                            dd = await showDatePicker(
                              context: context,
                              initialDate: cast<DateTime>(field.value ?? initialValue) ?? DateTime.now(),
                              firstDate: firstDate!,
                              lastDate: lastDate!,

                              initialDatePickerMode: DatePickerMode.day,
                              initialEntryMode: DatePickerEntryMode.calendar,

                              // timePickerInitialEntryMode: TimePickerEntryMode.dialOnly,
                            );
                          }
                          if (onlyTime == true || onlyTime == null) {
                            if (context.mounted) {
                              tt = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                  cast<DateTime>(field.value ?? initialValue) ?? DateTime.now(),
                                ),
                                initialEntryMode: TimePickerEntryMode.dial,
                              );
                            }
                          }
                          t = (dd ?? DateTime.now()).add(Duration(hours: tt?.hour ?? 0, minutes: tt?.minute ?? 0));
                        }
                        if (t != DateTime.now()) {
                          field.didChange(cast<T>(t));
                        }
                      } else {
                        DateTimeRange? r = await showDateRangePicker(
                          context: context,
                          initialDateRange: cast<DateTimeRange>(field.value ?? initialValue),
                          firstDate: firstDate!,
                          lastDate: lastDate!,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        );
                        if (r != null) {
                          field.didChange(cast<T>(r));
                        }
                      }
                    },
            );
          },
        );
      },
    ),
  );
}

String f1(DateTime d) => DateFormat.yMd().add_jm().format(d);
String f2(DateTime d) => DateFormat().format(d);

String h1(DateTime d) => DateFormat.jm().format(d);
String h2(DateTime d) => DateFormat.Hm().format(d);

String d0(DateTime d) => DateFormat('EEE, MMM d, ' 'yy').format(d);
String d1(DateTime d) => DateFormat.yMMMMEEEEd().format(d);
String d2(DateTime d) => DateFormat.yMd().format(d);
String d3(DateTime d) => DateFormat.yMMMMd('en_US').format(d);

String r1(Duration d, bool? onlyTime) {
  DateTime dd = DateTime(0, 0, 0, 0, 0).add(d);

  return '${onlyTime != false ? "${dd.hour}H" : ""}  ${dd.minute}M  ${onlyTime == null ? "${dd.second}S" : ""}';
}
