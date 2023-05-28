import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prathibha_web/settings/bloc/class_divison/class_division_bloc.dart';
import 'package:prathibha_web/settings/bloc/class_divison/class_division_event.dart';
import 'package:prathibha_web/settings/bloc/class_divison/class_divison_state.dart';
import 'package:prathibha_web/settings/bloc/generate_fee/generate_fee_bloc.dart';
import 'package:prathibha_web/settings/bloc/generate_fee/generate_fee_event.dart';

void generateFee({
  required BuildContext context,
  required var branchId,
}) {
  final SettingsClassDivisionBloc settingsClassDivisionBloc =
      SettingsClassDivisionBloc();
  final GenerateFeeBloc generateFeeBloc = GenerateFeeBloc();
  settingsClassDivisionBloc.add(ClassDivisionFetch(branchId));
  String nextInstallment = '0';
  final TextEditingController installmentController = TextEditingController();
  List<TextEditingController> amountControllers = [];
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 500,
          height: 400,
          child: Column(
            children: [
              // add events
              const Text(
                "Amount Paying",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<SettingsClassDivisionBloc, ClassDivisionState>(
                bloc: settingsClassDivisionBloc,
                builder: (context, state) {
                  if (state is ClassDivisionLoaded) {
                    for (var element
                        in state.classDivisionModel.installments!) {
                      if (int.parse(nextInstallment) < int.parse(element)) {
                        nextInstallment = element;
                      }
                    }
                    nextInstallment =
                        (int.parse(nextInstallment) + 1).toString();
                    installmentController.text = nextInstallment;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: installmentController,
                        enabled: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter amount";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Installment",
                          filled: true,
                          fillColor: Color.fromRGBO(234, 240, 247, 1),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: formKey,
                child:
                    BlocBuilder<SettingsClassDivisionBloc, ClassDivisionState>(
                  bloc: settingsClassDivisionBloc,
                  builder: (context, state) {
                    if (state is ClassDivisionLoaded) {
                      amountControllers.clear();
                      for (int index = 0;
                          index < state.classDivisionModel.classes!.length;
                          index++) {
                        // Create a new controller for each item
                        amountControllers.add(TextEditingController());
                      }
                      return ListView.separated(
                        itemCount: state.classDivisionModel.classes!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: amountControllers[index],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter amount";
                                }
                                try {
                                  int.parse(value);
                                } catch (e) {
                                  return "Please enter numbers only";
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                labelText:
                                    "${state.classDivisionModel.classes![index]}th Amount",
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(234, 240, 247, 1),
                                border: InputBorder.none,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      );
                    } else if (state is ClassDivisionError) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return const CircularProgressIndicator(
                      color: Colors.blue,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<SettingsClassDivisionBloc, ClassDivisionState>(
              bloc: settingsClassDivisionBloc,
              builder: (context, classDivisionState) {
                if (classDivisionState is ClassDivisionLoaded) {
                  return SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Map standardFee = {};
                          for (int index = 0;
                              index <
                                  classDivisionState
                                      .classDivisionModel.classes!.length;
                              index++) {
                            standardFee[classDivisionState
                                    .classDivisionModel.classes![index]] =
                                amountControllers[index].text;
                            generateFeeBloc.add(
                              GenerateFeeEvent(
                                branchId: branchId,
                                installment: installmentController.text,
                                standardFee: standardFee,
                                context: context,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        }

                        // Navigator.pop(context);
                      },
                      child: const Text("Generate Fee"),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ],
    ),
  );
}
