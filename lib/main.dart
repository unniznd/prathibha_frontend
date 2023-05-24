import 'package:flutter/material.dart';
import 'package:prathibha_web/common/login_loading.dart';
import 'package:prathibha_web/login/bloc/login_event.dart';
import 'package:prathibha_web/login/bloc/login_state.dart';
import 'package:prathibha_web/login/login_screen.dart';
import 'package:prathibha_web/switcher/switcher_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prathibha_web/switcher/bloc/calendar_day/calendar_day_bloc.dart';
import 'package:prathibha_web/switcher/bloc/left_tab_view/left_tab_view_bloc.dart';
import 'package:prathibha_web/switcher/bloc/add_event/add_event_bloc.dart';
import 'package:prathibha_web/switcher/bloc/drop_down_switch/drop_down_switch_bloc.dart';
import 'package:prathibha_web/fee/bloc/unpaid/unpaid_bloc.dart';
import 'package:prathibha_web/fee/bloc/paid/paid_bloc.dart';
import 'package:prathibha_web/fee/bloc/class/class_bloc.dart';
import 'package:prathibha_web/fee/bloc/division/division_bloc.dart';
import 'package:prathibha_web/fee/bloc/month/month_bloc.dart';
import 'package:prathibha_web/attendance/bloc/class/class_bloc.dart';
import 'package:prathibha_web/attendance/bloc/division/division_bloc.dart';
import 'package:prathibha_web/attendance/bloc/absent/absent_bloc.dart';
import 'package:prathibha_web/attendance/bloc/present/present_bloc.dart';
import 'package:prathibha_web/login/bloc/login_bloc.dart';
import 'package:prathibha_web/student/bloc/class/class_bloc.dart';
import 'package:prathibha_web/student/bloc/division/division_bloc.dart';
import 'package:prathibha_web/student/bloc/class_divison/class_division_bloc.dart';
import 'package:prathibha_web/student/bloc/student/student_bloc.dart';
import 'package:prathibha_web/attendance/bloc/date/date_bloc.dart';
import 'package:prathibha_web/attendance/bloc/attendance/attendance_bloc.dart';
import 'package:prathibha_web/attendance/bloc/class_divison/class_division_bloc.dart';
import 'package:prathibha_web/fee/bloc/fee/fee_bloc.dart';

void main(List<String> args) {
  runApp(const PrathibhaWebApplication());
}

class PrathibhaWebApplication extends StatefulWidget {
  const PrathibhaWebApplication({super.key});

  @override
  State<PrathibhaWebApplication> createState() =>
      _PrathibhaWebApplicationState();
}

class _PrathibhaWebApplicationState extends State<PrathibhaWebApplication> {
  @override
  void initState() {
    loginBloc.add(LoginTokenCheck());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Prathibha",
      theme: ThemeData(
        fontFamily: "Poppins",
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: const Color.fromRGBO(68, 97, 242, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Set border radius
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white,
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => CalendarDayBloc())),
          BlocProvider(create: ((context) => LeftTabViewBloc())),
          BlocProvider(create: ((context) => AddEventBloc())),
          BlocProvider(create: ((context) => DropDownSwitchBloc())),
          BlocProvider(create: ((context) => UnpaidBloc())),
          BlocProvider(create: ((context) => PaidBloc())),
          BlocProvider(create: ((context) => FeeClassBloc())),
          BlocProvider(create: ((context) => FeeDivisionBloc())),
          BlocProvider(create: ((context) => FeeMonthBloc())),
          BlocProvider(create: ((context) => AttendanceClassBloc())),
          BlocProvider(create: ((context) => AttendanceDivisionBloc())),
          BlocProvider(create: ((context) => AbsentBloc())),
          BlocProvider(create: ((context) => PresentBloc())),
          BlocProvider(create: ((context) => LoginBloc())),
          BlocProvider(create: ((context) => StudentClassBloc())),
          BlocProvider(create: ((context) => StudentDivisionBloc())),
          BlocProvider(create: ((context) => StudentClassDivisionBloc())),
          BlocProvider(create: ((context) => StudentBloc())),
          BlocProvider(create: ((context) => DateBloc())),
          BlocProvider(create: ((context) => AttendanceBloc())),
          BlocProvider(create: ((context) => AttendanceClassDivisionBloc())),
          BlocProvider(create: ((context) => FeeBloc())),
        ],
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: loginBloc,
          builder: (context, state) {
            if (state is LoginTokenChecking) {
              return const LoginLoadingScreen();
            } else if (state is LoginSuccess) {
              return SwitcherScreen(
                loginModel: state.loginModel,
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
