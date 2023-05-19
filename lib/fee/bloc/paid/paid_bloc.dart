import 'package:flutter_bloc/flutter_bloc.dart';

import 'paid_event.dart';
import 'paid_state.dart';

class PaidBloc extends Bloc<PaidEvent, PaidState> {
  PaidBloc() : super(PaidState(false)) {
    on<UpdatePaid>((event, emit) {
      emit(PaidState(event.isActive));
    });
  }
}
