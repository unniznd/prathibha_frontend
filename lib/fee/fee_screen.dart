import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/fee/bloc/class/class_bloc.dart';
import 'package:prathibha_web/fee/bloc/class/class_event.dart';
import 'package:prathibha_web/fee/bloc/class/class_state.dart';
import 'package:prathibha_web/fee/bloc/division/division_bloc.dart';
import 'package:prathibha_web/fee/bloc/division/division_event.dart';
import 'package:prathibha_web/fee/bloc/division/division_state.dart';
import 'package:prathibha_web/fee/bloc/month/month_bloc.dart';
import 'package:prathibha_web/fee/bloc/month/month_event.dart';
import 'package:prathibha_web/fee/bloc/month/month_state.dart';
import 'package:prathibha_web/fee/bloc/paid/paid_bloc.dart';
import 'package:prathibha_web/fee/bloc/paid/paid_event.dart';
import 'package:prathibha_web/fee/bloc/paid/paid_state.dart';
import 'package:prathibha_web/fee/bloc/unpaid/unpaid_bloc.dart';
import 'package:prathibha_web/fee/bloc/unpaid/unpaid_event.dart';
import 'package:prathibha_web/fee/bloc/unpaid/unpaid_state.dart';
import 'package:prathibha_web/fee/widget/fee_table_row.dart';

class FeeScreen extends StatefulWidget {
  const FeeScreen({super.key});

  @override
  State<FeeScreen> createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  String? selectedMonth;

  final UnpaidBloc unpaidBloc = UnpaidBloc();
  final PaidBloc paidBloc = PaidBloc();
  final ClassBloc classBloc = ClassBloc();
  final DivisionBloc divisionBloc = DivisionBloc();
  final MonthBloc monthBloc = MonthBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Fee Details",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Tooltip(
              message: 'Reload the table',
              child: HeroIcon(
                HeroIcons.arrowPath,
                size: 28,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: "Search by Student Name, Class, Section, Roll No.",
              filled: true,
              fillColor: Color.fromRGBO(234, 240, 247, 1),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Transform.scale(
              scale: 1.2,
              child: BlocBuilder<UnpaidBloc, UnpaidState>(
                bloc: unpaidBloc,
                builder: (context, state) {
                  return Checkbox(
                    value: state.isActive,
                    onChanged: (newState) {
                      if (newState == true) {
                        paidBloc.add(UpdatePaid(isActive: false));
                      }
                      unpaidBloc.add(UpdateUnpaid(isActive: newState!));
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: const Color.fromRGBO(68, 97, 242, 1),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Unpaid",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Transform.scale(
              scale: 1.2,
              child: BlocBuilder<PaidBloc, PaidState>(
                bloc: paidBloc,
                builder: (context, state) {
                  return Checkbox(
                    value: state.isActive,
                    onChanged: (newState) {
                      if (newState == true) {
                        unpaidBloc.add(UpdateUnpaid(isActive: false));
                      }
                      paidBloc.add(UpdatePaid(isActive: !state.isActive));
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: const Color.fromRGBO(68, 97, 242, 1),
                  );
                },
              ),
            ),
            const Text(
              "Paid",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(234, 240, 247, 1),
                  ), // Customize the border color and other properties
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: const Color.fromRGBO(
                      234, 240, 247, 1) // Customize the border radius if needed
                  ),
              child: BlocBuilder<ClassBloc, ClassState>(
                bloc: classBloc,
                builder: (context, state) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.className,
                      hint: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Class"),
                      ),
                      onChanged: (String? newValue) {
                        classBloc.add(ChangeClass(className: newValue));
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: HeroIcon(HeroIcons.chevronDown),
                      ),
                      items: <String>[
                        '10',
                        '9',
                        '8',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(234, 240, 247, 1),
                  ), // Customize the border color and other properties
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: const Color.fromRGBO(
                      234, 240, 247, 1) // Customize the border radius if needed
                  ),
              child: BlocBuilder<DivisionBloc, DivisionState>(
                bloc: divisionBloc,
                builder: (context, state) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.divisionName,
                      hint: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Division"),
                      ),
                      onChanged: (String? newValue) {
                        divisionBloc
                            .add(ChangeDivision(divisionName: newValue));
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: HeroIcon(HeroIcons.chevronDown),
                      ),
                      items: <String>[
                        'A',
                        'B',
                        'C',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(234, 240, 247, 1),
                  ), // Customize the border color and other properties
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: const Color.fromRGBO(
                      234, 240, 247, 1) // Customize the border radius if needed
                  ),
              child: BlocBuilder<MonthBloc, MonthState>(
                bloc: monthBloc,
                builder: (context, state) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.monthName,
                      hint: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("Month"),
                      ),
                      onChanged: (String? newValue) {
                        monthBloc.add(ChangeMonth(monthName: newValue));
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: HeroIcon(HeroIcons.chevronDown),
                      ),
                      items: <String>[
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug',
                        'Sep',
                        'Oct',
                        'Nov',
                        'Dec',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "1 of 4 Unpaid Students",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                unpaidBloc.add(UpdateUnpaid(isActive: false));
                paidBloc.add(UpdatePaid(isActive: false));
                classBloc.add(ChangeClass(className: null));
                divisionBloc.add(ChangeDivision(divisionName: null));
                monthBloc.add(ChangeMonth(monthName: null));
              },
              child: const Text("Clear Filters"),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.9,
              child: Column(
                children: [
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Student Name',
                      'Branch Name',
                      'Class Division',
                      'Status',
                      'Date of Payment',
                    ],
                    isHeader: true,
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Branch 1',
                      '10 B',
                      'Unpaid',
                      '--------',
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Branch 1',
                      '10 B',
                      'Paid',
                      'May 11, 2023',
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Branch 1',
                      '10 B',
                      'Paid',
                      'May 11, 2023',
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Branch 1',
                      '10 B',
                      'Paid',
                      'May 11, 2023',
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
