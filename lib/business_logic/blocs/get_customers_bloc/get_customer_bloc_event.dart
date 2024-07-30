part of 'get_customer_bloc_bloc.dart';

sealed class GetCustomerBlocEvent extends Equatable {
  const GetCustomerBlocEvent();

  @override
  List<Object> get props => [];
}
class GetCustomer extends GetCustomerBlocEvent{

}