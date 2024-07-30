import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel6_assignment_task/business_logic/api_repo/verify_pan_api.dart';

part 'verify_pan_event.dart';
part 'verify_pan_state.dart';

class VerifyPanBloc extends Bloc<VerifyPanEvent, VerifyPanState> {
  VerifyPanBloc() : super(VerifyPanInitial()) {
    final verifyPanApi = PanVerifyAPi();
    on<VerifyPan>((event, emit) async {
      var data = await verifyPanApi.verifyPan(event.panNumber);
      if (data['status']) {
        emit(PanVerifiedSuccess());
      } else {
        emit(VerifyPanFail());
      }
      // TODO: implement event handler
    });
  }
}
