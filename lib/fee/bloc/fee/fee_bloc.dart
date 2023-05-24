import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/fee/api/fee_api.dart';
import 'fee_event.dart';
import 'fee_state.dart';

class FeeBloc extends Bloc<FeeEvent, FeeState> {
  final FeeApiProvider feeApiProvider = FeeApiProvider();
  FeeBloc() : super(FeeLoading()) {
    on<FetchFee>((event, emit) async {
      emit(FeeLoading());
      try {
        final feeModel = await feeApiProvider.fetchFeeDetails(
          event.branchId,
          event.standard,
          event.division,
          event.month,
          event.status,
          event.q,
        );
        if (feeModel.errorMsg != null) {
          emit(FeeError(errorMsg: feeModel.errorMsg!));
        } else {
          emit(FeeLoaded(feeModel: feeModel));
        }
      } catch (e) {
        emit(FeeError(errorMsg: e.toString()));
      }
    });

    on<MarkAsPaidAndUnpaid>((event, emit) async {
      if (state is FeeLoaded) {
        final feeModel = (state as FeeLoaded).feeModel;
        feeModel.feeList![event.index].isMarkingFee = true;
        emit(FeeLoaded(feeModel: feeModel));

        final response = await feeApiProvider.markUnpaidAndPaid(
          event.branchId,
          event.feeId,
          event.status,
        );

        if (response) {
          if (event.status == "paid") {
            if (event.isUnpaidChecked) {
              feeModel.feeList!.removeAt(event.index);
              feeModel.unpaidCount = feeModel.unpaidCount! - 1;
              feeModel.totalCount = feeModel.totalCount! - 1;
            } else {
              feeModel.feeList![event.index].feeStatus = "Paid";
              feeModel.unpaidCount = feeModel.unpaidCount! - 1;
            }
          } else {
            if (event.isPaidChecked) {
              feeModel.feeList!.removeAt(event.index);

              feeModel.totalCount = feeModel.totalCount! - 1;
            } else {
              feeModel.feeList![event.index].feeStatus = "Unpaid";
              feeModel.unpaidCount = feeModel.unpaidCount! + 1;
            }
          }
        } else {
          // ignore: use_build_context_synchronously
          final scaffoldMessenger = ScaffoldMessenger.of(event.context);
          scaffoldMessenger.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              width: 700,
              content: Row(
                children: [
                  const HeroIcon(
                    HeroIcons.exclamationCircle,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Failed to mark ${event.status} for ${feeModel.feeList![event.index].studentName}.',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (feeModel.feeList!.isNotEmpty) {
          feeModel.feeList![event.index].isMarkingFee = false;
        }

        emit(FeeLoaded(feeModel: feeModel));
      }
    });
  }
}
