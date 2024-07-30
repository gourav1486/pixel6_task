part of 'get_postal_details_bloc.dart';

sealed class GetPostalDetailsEvent extends Equatable {
  const GetPostalDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetPostalCode extends GetPostalDetailsEvent {
  final String code;
  final AddressControllerModel address;
  const GetPostalCode({required this.code,required this.address});
  @override
  List<Object> get props => [code];
}
