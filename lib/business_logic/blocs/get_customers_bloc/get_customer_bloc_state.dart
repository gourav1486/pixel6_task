part of 'get_customer_bloc_bloc.dart';

sealed class GetCustomerBlocState extends Equatable {
  const GetCustomerBlocState();

  @override
  List<Object> get props => [];
}

final class GetCustomerBlocInitial extends GetCustomerBlocState {}

final class CustomersFetched extends GetCustomerBlocState {
  final List<CustomerModel> customers;
  const CustomersFetched({required this.customers});
  @override
  List<Object> get props => [customers];
}

final class CustomerFetchingError extends GetCustomerBlocState {
  final String e;
  const CustomerFetchingError({required this.e});
   @override
  List<Object> get props => [e];
}
