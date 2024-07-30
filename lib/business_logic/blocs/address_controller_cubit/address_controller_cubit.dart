import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel6_assignment_task/models/address_controller_model.dart';

part 'address_controller_state.dart';

class AddressControllerCubit extends Cubit<AddressControllerState> {
  AddressControllerCubit() : super(AddressControllerInitial());
  void appendAddress(List<AddressControllerModel> addresses) {
    emit(AddressControllerInitial());
    emit(AddressAppended(addresses: addresses));
  }
}
