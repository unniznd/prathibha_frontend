import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_event_event.dart';
import 'add_event_state.dart';

class AddEventBloc extends Bloc<AddEventEvent, AddEventState> {
  AddEventBloc() : super(AddEventInitial()) {
    on<ChangeEventDate>((event, emit) {
      emit(AddEventDateChanged(event.date));
    });
  }
}
