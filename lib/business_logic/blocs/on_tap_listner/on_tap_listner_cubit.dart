import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_tap_listner_state.dart';

class OnTapListnerCubit extends Cubit<OnTapListnerState> {
  OnTapListnerCubit() : super(OnTapListnerInitial());
  changeState(bool enable) {
    emit(OnTapListnerInitial());
    emit(OnTapListnerSet(enable: enable));
  }
}
