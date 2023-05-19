import 'package:flutter_bloc/flutter_bloc.dart';

import 'unpaid_event.dart';
import 'unpaid_state.dart';

class UnpaidBloc extends Bloc<UnpaidEvent, UnpaidState> {
  UnpaidBloc() : super(UnpaidState(false)) {
    on<UpdateUnpaid>((event, emit) {
      emit(UnpaidState(event.isActive));
    });
  }
}
