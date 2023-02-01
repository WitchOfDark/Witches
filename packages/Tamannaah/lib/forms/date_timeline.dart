import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../ui/decoration.dart';

const Color defaultDateColor = Colors.black;
const Color defaultDayColor = Colors.black;
const Color defaultMonthColor = Colors.black;
const Color defaultSelectionColor = Color(0x30000000);
const Color defaultDeactivatedColor = Color(0xFF666666);

const TextStyle defaultMonthTextStyle = TextStyle(color: defaultMonthColor, fontSize: 11, fontWeight: FontWeight.w500);

const TextStyle defaultDateTextStyle = TextStyle(color: defaultDateColor, fontSize: 24, fontWeight: FontWeight.w500);

const TextStyle defaultDayTextStyle = TextStyle(color: defaultDayColor, fontSize: 11, fontWeight: FontWeight.w500);

typedef DateSelectionCallback = void Function(DateTime selectedDate);
typedef DateChangeListener = void Function(DateTime selectedDate);

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;

  const DateWidget({
    super.key,
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        margin: e4,
        decoration: BoxDecoration(
          borderRadius: brR_a_10,
          color: selectionColor,
        ),
        child: Padding(
          padding: e8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(DateFormat("MMM", locale).format(date).toUpperCase(), // Month
                  style: monthTextStyle),
              Text(date.day.toString(), // Date
                  style: dateTextStyle),
              Text(DateFormat("E", locale).format(date).toUpperCase(), // WeekDay
                  style: dayTextStyle)
            ],
          ),
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (onDateSelected != null) {
          // Call the onDateSelected Function
          onDateSelected!(date);
        }
      },
    );
  }
}

class DateTimelinePicker extends StatefulWidget {
  final DateTime startDate;
  final double width;
  final double height;
  final DateTimelinePickerController? controller;
  final Color selectedTextColor;
  final Color selectionColor;
  final Color deactivatedColor;
  final TextStyle monthTextStyle;
  final TextStyle dayTextStyle;
  final TextStyle dateTextStyle;

  /// Current Selected Date
  final DateTime? /*?*/ initialSelectedDate;

  /// Contains the list of inactive dates.
  /// All the dates defined in this List will be deactivated
  final List<DateTime>? inactiveDates;

  /// Contains the list of active dates.
  /// Only the dates in this list will be activated.
  final List<DateTime>? activeDates;

  /// Callback function for when a different date is selected
  final DateChangeListener? onDateChange;

  /// Max limit up to which the dates are shown.
  /// Days are counted from the startDate
  final int daysCount;

  /// Locale for the calendar default: en_us
  final String locale;

  const DateTimelinePicker(
    this.startDate, {
    super.key,
    this.width = 60,
    this.height = 80,
    this.controller,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.selectionColor = defaultSelectionColor,
    this.deactivatedColor = defaultDeactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 500,
    this.onDateChange,
    this.locale = "en_US",
  }) : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  State<StatefulWidget> createState() => DateTimelinePickerState();
}

class DateTimelinePickerState extends State<DateTimelinePicker> {
  DateTime? _currentDate;

  final ScrollController _controller = ScrollController();

  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;

  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedMonthStyle;
  late final TextStyle deactivatedDayStyle;

  @override
  void initState() {
    // Init the calendar locale
    initializeDateFormatting(widget.locale, null);
    // Set initial Values
    _currentDate = widget.initialSelectedDate;

    if (widget.controller != null) {
      widget.controller!.setDatePickerState(this);
    }

    selectedDateStyle = widget.dateTextStyle.copyWith(color: widget.selectedTextColor);
    selectedMonthStyle = widget.monthTextStyle.copyWith(color: widget.selectedTextColor);
    selectedDayStyle = widget.dayTextStyle.copyWith(color: widget.selectedTextColor);

    deactivatedDateStyle = widget.dateTextStyle.copyWith(color: widget.deactivatedColor);
    deactivatedMonthStyle = widget.monthTextStyle.copyWith(color: widget.deactivatedColor);
    deactivatedDayStyle = widget.dayTextStyle.copyWith(color: widget.deactivatedColor);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.daysCount,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemBuilder: (context, index) {
          // get the date object based on the index position
          // if widget.startDate is null then use the initialDateValue
          DateTime date;
          DateTime ldate = widget.startDate.add(Duration(days: index));
          date = DateTime(ldate.year, ldate.month, ldate.day);

          bool isDeactivated = false;

          // check if this date needs to be deactivated for only DeactivatedDates
          if (widget.inactiveDates != null) {
//            print("Inside Inactive dates.");
            for (DateTime inactiveDate in widget.inactiveDates!) {
              if (_compareDate(date, inactiveDate)) {
                isDeactivated = true;
                break;
              }
            }
          }

          // check if this date needs to be deactivated for only ActivatedDates
          if (widget.activeDates != null) {
            isDeactivated = true;
            for (DateTime activateDate in widget.activeDates!) {
              // Compare the date if it is in the
              if (_compareDate(date, activateDate)) {
                isDeactivated = false;
                break;
              }
            }
          }

          // Check if this date is the one that is currently selected
          bool isSelected = _currentDate != null ? _compareDate(date, _currentDate!) : false;

          // Return the Date Widget
          return DateWidget(
            date: date,
            monthTextStyle: isDeactivated
                ? deactivatedMonthStyle
                : isSelected
                    ? selectedMonthStyle
                    : widget.monthTextStyle,
            dateTextStyle: isDeactivated
                ? deactivatedDateStyle
                : isSelected
                    ? selectedDateStyle
                    : widget.dateTextStyle,
            dayTextStyle: isDeactivated
                ? deactivatedDayStyle
                : isSelected
                    ? selectedDayStyle
                    : widget.dayTextStyle,
            width: widget.width,
            locale: widget.locale,
            selectionColor: isSelected ? widget.selectionColor : Colors.transparent,
            onDateSelected: (selectedDate) {
              // Don't notify listener if date is deactivated
              if (isDeactivated) return;

              // A date is selected
              if (widget.onDateChange != null) {
                widget.onDateChange!(selectedDate);
              }
              setState(() {
                _currentDate = selectedDate;
              });
            },
          );
        },
      ),
    );
  }

  /// Helper function to compare two dates
  /// Returns True if both dates are the same
  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;
  }
}

class DateTimelinePickerController {
  DateTimelinePickerState? _datePickerState;

  void setDatePickerState(DateTimelinePickerState state) {
    _datePickerState = state;
  }

  void jumpToSelection() {
    assert(_datePickerState != null, 'DatePickerController is not attached to any DatePicker View.');

    // jump to the current Date
    _datePickerState!._controller.jumpTo(_calculateDateOffset(_datePickerState!._currentDate!));
  }

  /// This function will animate the Timeline to the currently selected Date
  void animateToSelection({duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null, 'DatePickerController is not attached to any DatePicker View.');

    // animate to the current date
    _datePickerState!._controller
        .animateTo(_calculateDateOffset(_datePickerState!._currentDate!), duration: duration, curve: curve);
  }

  /// This function will animate to any date that is passed as an argument
  /// In case a date is out of range nothing will happen
  void animateToDate(DateTime date, {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null, 'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date), duration: duration, curve: curve);
  }

  /// This function will animate to any date that is passed as an argument
  /// this will also set that date as the current selected date
  void setDateAndAnimate(DateTime date, {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null, 'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date), duration: duration, curve: curve);

    if (date.compareTo(_datePickerState!.widget.startDate) >= 0 &&
        date.compareTo(_datePickerState!.widget.startDate.add(Duration(days: _datePickerState!.widget.daysCount))) <=
            0) {
      // date is in the range
      _datePickerState!._currentDate = date;
    }
  }

  /// Calculate the number of pixels that needs to be scrolled to go to the
  /// date provided in the argument
  double _calculateDateOffset(DateTime date) {
    final startDate = DateTime(_datePickerState!.widget.startDate.year, _datePickerState!.widget.startDate.month,
        _datePickerState!.widget.startDate.day);

    int offset = date.difference(startDate).inDays;
    return (offset * _datePickerState!.widget.width) + (offset * 6);
  }
}
