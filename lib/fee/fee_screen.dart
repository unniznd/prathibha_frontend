import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/fee/bloc/class/class_bloc.dart';
import 'package:prathibha_web/fee/bloc/class/class_event.dart';
import 'package:prathibha_web/fee/bloc/class/class_state.dart';
import 'package:prathibha_web/fee/bloc/class_divison/class_division_bloc.dart';
import 'package:prathibha_web/fee/bloc/class_divison/class_division_event.dart';
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
import 'package:prathibha_web/fee/widget/fee_amount_dialog.dart';
import 'package:prathibha_web/fee/widget/fee_table_row.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/class_divison/class_divison_state.dart';

class FeeScreen extends StatefulWidget {
  const FeeScreen({super.key, required this.branchId});

  final int branchId;

  @override
  State<FeeScreen> createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  final UnpaidBloc unpaidBloc = UnpaidBloc();
  final PaidBloc paidBloc = PaidBloc();
  final FeeClassBloc classBloc = FeeClassBloc();
  final FeeDivisionBloc divisionBloc = FeeDivisionBloc();
  final FeeMonthBloc monthBloc = FeeMonthBloc();
  final FeeBloc feeBloc = FeeBloc();
  final FeeClassDivisionBloc feeClassDivisionBloc = FeeClassDivisionBloc();

  final TextEditingController searchController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String? selectedMonth;
  String? selectedStandard;
  String? selectedDivision;
  bool isUnpaidChecked = false;
  bool isPaidChecked = false;

  @override
  Widget build(BuildContext context) {
    monthBloc.add(
      ChangeMonth(
        monthName: null,
      ),
    );
    feeClassDivisionBloc.add(ClassDivisionFetch(widget.branchId));
    unpaidBloc.add(UpdateUnpaid(isActive: false));
    paidBloc.add(UpdatePaid(isActive: false));
    classBloc.add(ChangeClass(className: null));
    divisionBloc.add(ChangeDivision(divisionName: null));
    searchController.text = "";
    feeBloc.add(
      FetchFee(
        branchId: widget.branchId,
        standard: "",
        division: "",
        month: "",
        status: "",
        q: "",
      ),
    );

    List<String> divisionList = [];

    return BlocBuilder<FeeClassDivisionBloc, ClassDivisionState>(
      bloc: feeClassDivisionBloc,
      builder: (context, classDivisionState) {
        if (classDivisionState is ClassDivisionLoaded) {
          List<String>? installment =
              classDivisionState.classDivisionModel.installments;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Fee Details",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Tooltip(
                    message: 'Reload the table',
                    child: GestureDetector(
                      onTap: () {
                        feeBloc.add(
                          FetchFee(
                            branchId: widget.branchId,
                            standard: selectedStandard ?? "",
                            division: selectedDivision ?? "",
                            month: selectedMonth ?? "",
                            status: isUnpaidChecked
                                ? "unpaid"
                                : isPaidChecked
                                    ? "paid"
                                    : "",
                            q: searchController.text,
                          ),
                        );
                      },
                      child: const HeroIcon(
                        HeroIcons.arrowPath,
                        size: 28,
                      ),
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
                  controller: searchController,
                  onChanged: (value) {
                    feeBloc.add(
                      FetchFee(
                        branchId: widget.branchId,
                        standard: selectedStandard ?? "",
                        division: selectedDivision ?? "",
                        month: selectedMonth ?? "",
                        status: isUnpaidChecked
                            ? "unpaid"
                            : isPaidChecked
                                ? "paid"
                                : "",
                        q: value,
                      ),
                    );
                  },
                  decoration: const InputDecoration(
                    hintText: "Search by Admission Number, Student Name",
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
                        isUnpaidChecked = state.isActive;
                        return Checkbox(
                          value: state.isActive,
                          onChanged: (newState) {
                            if (newState == true) {
                              paidBloc.add(UpdatePaid(isActive: false));
                              isPaidChecked = false;
                            }
                            unpaidBloc.add(UpdateUnpaid(isActive: newState!));

                            feeBloc.add(
                              FetchFee(
                                branchId: widget.branchId,
                                standard: selectedStandard ?? "",
                                division: selectedDivision ?? "",
                                month: selectedMonth ?? "",
                                status: newState
                                    ? "unpaid"
                                    : isPaidChecked
                                        ? "paid"
                                        : "",
                                q: searchController.text,
                              ),
                            );
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                        isPaidChecked = state.isActive;
                        return Checkbox(
                          value: state.isActive,
                          onChanged: (newState) {
                            if (newState == true) {
                              unpaidBloc.add(UpdateUnpaid(isActive: false));
                              isUnpaidChecked = false;
                            }
                            paidBloc.add(UpdatePaid(isActive: !state.isActive));

                            feeBloc.add(
                              FetchFee(
                                branchId: widget.branchId,
                                standard: selectedStandard ?? "",
                                division: selectedDivision ?? "",
                                month: selectedMonth ?? "",
                                status: isUnpaidChecked
                                    ? "unpaid"
                                    : newState!
                                        ? "paid"
                                        : "",
                                q: searchController.text,
                              ),
                            );
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                        color: const Color.fromRGBO(234, 240, 247,
                            1) // Customize the border radius if needed
                        ),
                    child: BlocBuilder<FeeClassBloc, ClassState>(
                      bloc: classBloc,
                      builder: (context, state) {
                        selectedStandard = state.className;
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: state.className,
                            hint: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Class"),
                            ),
                            onChanged: (String? newValue) {
                              classBloc.add(ChangeClass(className: newValue));
                              divisionList = classDivisionState
                                  .classDivisionModel.divisions![newValue]!;
                              divisionBloc
                                  .add(ChangeDivision(divisionName: null));

                              feeBloc.add(
                                FetchFee(
                                  branchId: widget.branchId,
                                  standard: newValue ?? "",
                                  division: selectedDivision ?? "",
                                  month: selectedMonth ?? "",
                                  status: isUnpaidChecked
                                      ? "unpaid"
                                      : isPaidChecked
                                          ? "paid"
                                          : "",
                                  q: searchController.text,
                                ),
                              );
                            },
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: HeroIcon(HeroIcons.chevronDown),
                            ),
                            items: classDivisionState
                                .classDivisionModel.classes!
                                .map((String value) {
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
                        color: const Color.fromRGBO(234, 240, 247,
                            1) // Customize the border radius if needed
                        ),
                    child: BlocBuilder<FeeDivisionBloc, DivisionState>(
                      bloc: divisionBloc,
                      builder: (context, state) {
                        selectedDivision = state.divisionName;
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
                              feeBloc.add(
                                FetchFee(
                                  branchId: widget.branchId,
                                  standard: selectedStandard ?? "",
                                  division: newValue ?? "",
                                  month: selectedMonth ?? "",
                                  status: isUnpaidChecked
                                      ? "unpaid"
                                      : isPaidChecked
                                          ? "paid"
                                          : "",
                                  q: searchController.text,
                                ),
                              );
                            },
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: HeroIcon(HeroIcons.chevronDown),
                            ),
                            items: divisionList.map((String value) {
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
                    width: 145,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(234, 240, 247, 1),
                        ), // Customize the border color and other properties
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        color: const Color.fromRGBO(234, 240, 247,
                            1) // Customize the border radius if needed
                        ),
                    child: BlocBuilder<FeeMonthBloc, MonthState>(
                      bloc: monthBloc,
                      builder: (context, state) {
                        selectedMonth = state.monthName;
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: state.monthName,
                            hint: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Installment"),
                            ),
                            onChanged: (String? newValue) {
                              monthBloc.add(ChangeMonth(monthName: newValue));
                              feeBloc.add(
                                FetchFee(
                                  branchId: widget.branchId,
                                  standard: selectedStandard ?? "",
                                  division: selectedDivision ?? "",
                                  month: newValue ?? "",
                                  status: isUnpaidChecked
                                      ? "unpaid"
                                      : isPaidChecked
                                          ? "paid"
                                          : "",
                                  q: searchController.text,
                                ),
                              );
                            },
                            icon: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: HeroIcon(HeroIcons.chevronDown),
                            ),
                            items: installment!.map((String value) {
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
                      monthBloc.add(ChangeMonth(
                        monthName: null,
                      ));
                      searchController.text = "";
                      feeBloc.add(
                        FetchFee(
                          branchId: widget.branchId,
                          standard: "",
                          division: "",
                          month: "",
                          status: "",
                          q: "",
                        ),
                      );
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
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Column(
                      children: [
                        FeeTableRow(
                          rowData: const [
                            'Admission Number',
                            'Student Name',
                            'Class Division',
                            'Amount Left',
                            'Total Amount',
                            'Status',
                            'Installment',
                            'Date of Last Payment',
                          ],
                          isHeader: true,
                          amount: 0,
                          markAsPaid: null,
                        ),
                        BlocBuilder<FeeBloc, FeeState>(
                          bloc: feeBloc,
                          builder: (context, state) {
                            if (state is FeeLoaded) {
                              if (state.feeModel.feeList!.isEmpty) {
                                return const Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    // no report to view
                                    HeroIcon(
                                      HeroIcons.userGroup,
                                      size: 100,
                                      color: Color.fromRGBO(233, 233, 233, 1),
                                    ),
                                    Center(
                                      child: Text(
                                        "No student found",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(194, 194, 194, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return ListView.separated(
                                itemCount: state.feeModel.totalCount!,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return FeeTableRow(
                                    rowData: [
                                      state.feeModel.feeList![index]
                                          .admissionNumber,
                                      state
                                          .feeModel.feeList![index].studentName,
                                      "${state.feeModel.feeList![index].standard} ${state.feeModel.feeList![index].division}",
                                      state.feeModel.feeList![index].amountLeft,
                                      state
                                          .feeModel.feeList![index].totalAmount,
                                      state.feeModel.feeList![index].feeStatus,
                                      state
                                          .feeModel.feeList![index].installment,
                                      state.feeModel.feeList![index]
                                                  .amountLeft !=
                                              state.feeModel.feeList![index]
                                                  .totalAmount
                                          ? state
                                              .feeModel.feeList![index].feeDate
                                          : "-----",
                                    ],
                                    amount: int.parse(state
                                        .feeModel.feeList![index].amountLeft),
                                    markAsPaid: () {
                                      feeAmountDialog(
                                        context: context,
                                        feeBloc: feeBloc,
                                        amountController: amountController,
                                        feeAmount: state.feeModel
                                            .feeList![index].amountLeft,
                                        branchId: widget.branchId,
                                        feeId: state
                                            .feeModel.feeList![index].feeId,
                                        index: index,
                                        isPaidChecked: isPaidChecked,
                                        isUnpaidChecked: isUnpaidChecked,
                                      );
                                    },
                                    isMarkingFee: state
                                        .feeModel.feeList![index].isMarkingFee,
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
                                  markAsPaid: null,
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
        } else if (classDivisionState is ClassDivisionError) {
          return Center(
            child: Text(classDivisionState.error),
          );
        }
        return Center(
          child: Image.asset(
            "assets/images/loading.gif",
            width: 100,
          ),
        );
      },
    );
  }
}
