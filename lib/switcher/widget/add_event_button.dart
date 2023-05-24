import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:prathibha_web/switcher/bloc/add_event/add_event_bloc.dart';

import '../bloc/add_event/add_event_event.dart';
import '../bloc/calendar_day/calendar_day_bloc.dart';
import '../bloc/calendar_day/calendar_day_state.dart';
import 'add_event_dialog.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({
    super.key,
    required this.calendarDayBloc,
    required this.dateController,
    required this.addEventBloc,
  });

  final TextEditingController dateController;
  final CalendarDayBloc calendarDayBloc;
  final AddEventBloc addEventBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Events",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        BlocBuilder<CalendarDayBloc, CalendarDayState>(
          bloc: calendarDayBloc,
          builder: (context, state) {
            dateController.text = DateFormat('MMMM d, y').format(
              state.selectedDay,
            );
            return GestureDetector(
              onTap: () {
                if (state.selectedDay
                    .add(const Duration(days: 1))
                    .isBefore(DateTime.now())) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      width: 700,
                      content: Row(
                        children: [
                          HeroIcon(
                            HeroIcons.exclamationCircle,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Can\'t add event for dates before today. Select Valid Date in Calendar',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  return;
                }
                addEvent(
                  context: context,
                  dateController: dateController,
                  addEventBloc: addEventBloc,
                  onDatePickerTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: state.selectedDay,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      addEventBloc.add(ChangeEventDate(pickedDate));
                    }
                  },
                );
              },
              child: const HeroIcon(
                HeroIcons.plus,
              ),
            );
          },
        ),
      ],
    );
  }
}
