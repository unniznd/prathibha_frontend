import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prathibha_web/fee/api/fee_api.dart';
import 'fee_event.dart';
import 'fee_state.dart';

class FeeBloc extends Bloc<FeeEvent, FeeState> {
  FeeBloc() : super(FeeLoading()) {
    on<FetchFee>((event, emit) async {
      emit(FeeLoading());
      try {
        final feeModel = await FeeApiProvider().fetchFeeDetails(
          event.branchId,
          event.standard,
          event.division,
          event.month,
          event.status,
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
  }
}
