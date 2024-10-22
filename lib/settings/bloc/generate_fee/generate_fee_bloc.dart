import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'generate_fee_event.dart';
import 'generate_fee_state.dart';
import 'package:prathibha_web/settings/api/settings_api.dart';

class GenerateFeeBloc extends Bloc<GenerateFeeEvent, GenerateFeeState> {
  final SettingsApiProvider settingsApiProvider = SettingsApiProvider();
  GenerateFeeBloc() : super(GenerateFeeInitial()) {
    on<GenerateFeeEvent>((event, emit) async {
      emit(GenerateFeeLoading());
      final scaffoldMessenger = ScaffoldMessenger.of(event.context);
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue,
          content: Row(
            children: [
              HeroIcon(
                HeroIcons.exclamationCircle,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Generating Fee',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
      try {
        final res = await settingsApiProvider.generateFee(
          event.branchId,
          event.standardFee,
          event.installment,
        );
        if (res) {
          await Future.delayed(const Duration(seconds: 2));
          // ignore: use_build_context_synchronously

          scaffoldMessenger.showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              content: Row(
                children: [
                  HeroIcon(
                    HeroIcons.exclamationCircle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Generated Fee',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
          emit(GenerateFeeSuccess());
        } else {
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Row(
                children: [
                  HeroIcon(
                    HeroIcons.exclamationCircle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Failed to generate fee',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
          emit(GenerateFeeFailure(message: "Error Failed to generate feee"));
        }
      } catch (e) {
        emit(GenerateFeeFailure(message: "Error Failed to generate feee"));
      }
    });
  }
}
