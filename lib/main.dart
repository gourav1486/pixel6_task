import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/address_controller_cubit/address_controller_cubit.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/get_customers_bloc/get_customer_bloc_bloc.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/get_postal_code_bloc/get_postal_details_bloc.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/on_tap_listner/on_tap_listner_cubit.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/verify_pan_bloc/verify_pan_bloc.dart';
import 'package:pixel6_assignment_task/view/screens/customer_list_screen.dart';
void main(){
  runApp(CustomerApp());
}
class CustomerApp extends StatelessWidget {
  const CustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider<OnTapListnerCubit>(
        create: (context) => OnTapListnerCubit(),
      ),
      BlocProvider<AddressControllerCubit>(
        create: (context) => AddressControllerCubit(),
      ),
      BlocProvider<GetPostalDetailsBloc>(
        create: (context) => GetPostalDetailsBloc(),
      ),
      BlocProvider<VerifyPanBloc>(
        create: (context) => VerifyPanBloc(),
      ),
       BlocProvider<GetCustomerBlocBloc>(
        create: (context) => GetCustomerBlocBloc(),
      ),
      ],
      child: MaterialApp(
        home: CustomerListScreen(),
      ),
    );
  }
}