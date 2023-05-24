import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/fee/bloc/class/class_bloc.dart';
import 'package:prathibha_web/fee/bloc/class/class_event.dart';
import 'package:prathibha_web/fee/bloc/class/class_state.dart';
import 'package:prathibha_web/fee/bloc/division/division_bloc.dart';
import 'package:prathibha_web/fee/bloc/division/division_event.dart';
import 'package:prathibha_web/fee/bloc/division/division_state.dart';
import 'package:prathibha_web/fee/bloc/fee/fee_bloc.dart';
import 'package:prathibha_web/fee/bloc/fee/fee_event.dart';
import 'package:prathibha_web/fee/bloc/fee/fee_state.dart';
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
import 'package:shimmer/shimmer.dart';

class FeeScreen extends StatefulWidget {
  const FeeScreen({super.key, required this.branchId});

  final int branchId;

  @override
  State<FeeScreen> createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  String? selectedMonth;

  final UnpaidBloc unpaidBloc = UnpaidBloc();
  final PaidBloc paidBloc = PaidBloc();
  final FeeClassBloc classBloc = FeeClassBloc();
  final FeeDivisionBloc divisionBloc = FeeDivisionBloc();
  final FeeMonthBloc monthBloc = FeeMonthBloc();
  final FeeBloc feeBloc = FeeBloc();

  @override
  Widget build(BuildContext context) {
    feeBloc.add(FetchFee(branchId: widget.branchId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
              child: BlocBuilder<FeeClassBloc, ClassState>(
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
              child: BlocBuilder<FeeDivisionBloc, DivisionState>(
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
              child: BlocBuilder<FeeMonthBloc, MonthState>(
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
            BlocBuilder<FeeBloc, FeeState>(
              bloc: feeBloc,
              builder: (context, state) {
                if (state is FeeLoaded) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "${state.feeModel.unpaidCount!} of ${state.feeModel.totalCount!} Unpaid Students",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  );
                } else if (state is FeeError) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "0 of 0 Unpaid Students",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: SizedBox(
                          width: 50,
                          height: 16.0, // Adjust the height as needed
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Text(
                        " Unpaid Students",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              },
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
                    rowData: const [
                      'Student Name',
                      'Class Division',
                      'Amount',
                      'Status',
                      'Date of Payment',
                    ],
                    isHeader: true,
                    amount: 0,
                  ),
                  BlocBuilder<FeeBloc, FeeState>(
                    bloc: feeBloc,
                    builder: (context, state) {
                      if (state is FeeLoaded) {
                        return ListView.separated(
                          itemCount: state.feeModel.totalCount!,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return FeeTableRow(
                              rowData: [
                                state.feeModel.feeList![index].studentName,
                                "${state.feeModel.feeList![index].standard} ${state.feeModel.feeList![index].division}",
                                state.feeModel.feeList![index].amount,
                                state.feeModel.feeList![index].feeStatus,
                                state.feeModel.feeList![index].feeStatus ==
                                        "Paid"
                                    ? state.feeModel.feeList![index].feeDate
                                    : "-----",
                              ],
                              amount: int.parse(
                                  state.feeModel.feeList![index].amount),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        );
                      } else if (state is FeeError) {
                        return Center(
                          child: Text(state.errorMsg),
                        );
                      }
                      return ListView.separated(
                        itemCount: 15,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return FeeTableRow(
                            rowData: const [
                              "1",
                              "2",
                              "3",
                              "4",
                              "5",
                            ],
                            isShimmer: true,
                            amount: 0,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      );
                    },
                  )
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
