import 'package:flutter/material.dart';
import 'package:prathibha_web/fee/bloc/fee/fee_event.dart';

void feeAmountDialog({
  required BuildContext context,
  required var amountController,
  required var feeBloc,
  required var feeAmount,
  required var branchId,
  required var feeId,
  required var index,
  required var isPaidChecked,
  required var isUnpaidChecked,
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
          // form key
          final formKey = GlobalKey<FormState>();
          amountController.text = '';
          return SizedBox(
            height: 200,
            width: 500,
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
                Form(
                  key: formKey,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter amount";
                        }
                        if (int.parse(value) > int.parse(feeAmount)) {
                          return "Please enter amount less than or equal to $feeAmount";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Amount",
                        filled: true,
                        fillColor: Color.fromRGBO(234, 240, 247, 1),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            feeBloc.add(MarkAsPaidAndUnpaid(
                              branchId: branchId,
                              feeId: feeId,
                              index: index,
                              amountPaid: feeAmount,
                              context: context,
                              isPaidChecked: isPaidChecked,
                              isUnpaidChecked: isUnpaidChecked,
                            ));
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Pay Full Amount"),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            feeBloc.add(MarkAsPaidAndUnpaid(
                              branchId: branchId,
                              feeId: feeId,
                              index: index,
                              amountPaid: amountController.text,
                              context: context,
                              isPaidChecked: isPaidChecked,
                              isUnpaidChecked: isUnpaidChecked,
                            ));
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Pay Entered Amount"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
