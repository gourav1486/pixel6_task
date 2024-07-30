part of 'address_controller_cubit.dart';

sealed class AddressControllerState extends Equatable {
  const AddressControllerState();

  @override
  List<Object> get props => [];
}

final class AddressControllerInitial extends AddressControllerState {}

final class AddressAppended extends AddressControllerState {
 final List<AddressControllerModel> addresses;
 const AddressAppended({required this.addresses});
   @override
  List<Object> get props => [addresses];
}
