import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../bloc/calendar_day/calendar_day_bloc.dart';
import '../bloc/calendar_day/calendar_day_event.dart';
import '../bloc/calendar_day/calendar_day_state.dart';

final kToday = DateTime.now();

final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

// ignore: must_be_immutable
class ShowCalendar extends StatelessWidget {
  ShowCalendar({super.key, required this.calendarDayBloc});

  final dynamic calendarDayBloc;

  final CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarDayBloc, CalendarDayState>(
      bloc: calendarDayBloc,
      builder: (context, state) {
        return TableCalendar(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          selectedDayPredicate: (day) {
            return isSameDay(state.selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(state.selectedDay, selectedDay)) {
              calendarDayBloc.add(
                SelectedDayEvent(selectedDay, focusedDay),
              );
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        );
      },
    );
  }
}
