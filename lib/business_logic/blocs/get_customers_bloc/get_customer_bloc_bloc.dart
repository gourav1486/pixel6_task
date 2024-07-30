import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel6_assignment_task/models/customer_model.dart';
import 'package:pixel6_assignment_task/utils/local_storage_repo.dart';

part 'get_customer_bloc_event.dart';
part 'get_customer_bloc_state.dart';

class GetCustomerBlocBloc
    extends Bloc<GetCustomerBlocEvent, GetCustomerBlocState> {
  GetCustomerBlocBloc() : super(GetCustomerBlocInitial()) {
    final databaseHelper = DatabaseHelper();
    on<GetCustomer>((event, emit) async {
      try {
        var data = await databaseHelper.getCustomers();
       
        emit(CustomersFetched(customers: data));
      } catch (e) {
        emit(CustomerFetchingError(e: e.toString()));
      }
      // TODO: implement event handler
    });
  }
}
