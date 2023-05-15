import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/attendance/attendance_screen.dart';
import 'package:prathibha_web/dashboard/dashboard_screen.dart';
import 'package:prathibha_web/finance/finance_screen.dart';
import 'package:prathibha_web/switcher/widget/add_event_button.dart';
import 'package:prathibha_web/switcher/widget/left_tab_view.dart';
import 'package:prathibha_web/switcher/widget/show_calendar.dart';
import 'package:prathibha_web/switcher/widget/show_events.dart';

import 'bloc/add_event/add_event_bloc.dart';
import 'bloc/left_tab_view/left_tab_view_bloc.dart';
import 'bloc/left_tab_view/left_tab_view_state.dart';

import 'bloc/calendar_day/calendar_day_bloc.dart';

// ignore: depend_on_referenced_packages

class SwitcherScreen extends StatefulWidget {
  const SwitcherScreen({super.key});

  @override
  State<SwitcherScreen> createState() => _SwitcherScreenState();
}

class _SwitcherScreenState extends State<SwitcherScreen> {
  final tabViewBloc = LeftTabViewBloc();
  final calendarDayBloc = CalendarDayBloc();
  final addEventBloc = AddEventBloc();

  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double ratioWidth = 1440 / MediaQuery.of(context).size.width;
    double ratioHeight = 855 / MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          LeftTabView(
            tabViewBloc: tabViewBloc,
            ratioWidth: ratioWidth,
          ),
          Expanded(
            child: BlocBuilder<LeftTabViewBloc, LeftTabViewState>(
              bloc: tabViewBloc,
              builder: (context, state) {
                if (state is DashBoardState) {
                  return const DashboardScreen();
                }
                if (state is AttendanceState) {
                  return const AttendanceScreen();
                }
                if (state is FinanceState) {
                  return const FinanceScreen();
                }
                return const DashboardScreen();
              },
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: 300 / ratioWidth,
              padding: const EdgeInsets.only(
                top: 50,
                left: 5,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      HeroIcon(
                        HeroIcons.pencilSquare,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Maietry Prajapati",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    "Main Adminstrator",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ShowCalendar(
                    calendarDayBloc: calendarDayBloc,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AddEventButton(
                    calendarDayBloc: calendarDayBloc,
                    dateController: dateController,
                    addEventBloc: addEventBloc,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (context, index) {
                      return const ShowEvents(eventName: "Event Name");
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
