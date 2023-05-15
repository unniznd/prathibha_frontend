import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../bloc/add_event/add_event_bloc.dart';
import '../bloc/add_event/add_event_state.dart';

void addEvent({
  required BuildContext context,
  required var dateController,
  required var onDatePickerTap,
  required var addEventBloc,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return SizedBox(
            height: 250,
            width: 500,
            child: Column(
              children: [
                // add events
                const Text(
                  "Add Event",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Event Name",
                      filled: true,
                      fillColor: Color.fromRGBO(234, 240, 247, 1),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<AddEventBloc, AddEventState>(
                  bloc: addEventBloc,
                  builder: (context, state) {
                    if (state is AddEventDateChanged) {
                      dateController.text = DateFormat('MMMM d, y').format(
                        state.date,
                      );
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: GestureDetector(
                          onTap: onDatePickerTap,
                          child: TextFormField(
                            controller: dateController,
                            enabled: false,
                            decoration: const InputDecoration(
                              hintText: "Event Date",
                              filled: true,
                              fillColor: Color.fromRGBO(234, 240, 247, 1),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(8),
                                child: HeroIcon(HeroIcons.calendar),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: GestureDetector(
                        onTap: onDatePickerTap,
                        child: TextFormField(
                          controller: dateController,
                          enabled: false,
                          decoration: const InputDecoration(
                              hintText: "Event Date",
                              filled: true,
                              fillColor: Color.fromRGBO(234, 240, 247, 1),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(8),
                                child: HeroIcon(HeroIcons.calendar),
                              )),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Add Event"),
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
