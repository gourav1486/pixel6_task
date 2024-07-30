import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/on_tap_listner/on_tap_listner_cubit.dart';
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
      ],
      child: MaterialApp(
        home: CustomerListScreen(),
      ),
    );
  }
}