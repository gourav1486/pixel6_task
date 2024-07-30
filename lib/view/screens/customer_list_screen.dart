import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/get_customers_bloc/get_customer_bloc_bloc.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/on_tap_listner/on_tap_listner_cubit.dart';
import 'package:pixel6_assignment_task/view/screens/edit_add_customer_screen.dart';
import 'package:pixel6_assignment_task/view/widgets/customer_card_widget.dart';

import '../widgets/buttons.dart';

class CustomerListScreen extends StatefulWidget {
  CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool showRectangularButton = true;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetCustomerBlocBloc>(context).add(GetCustomer());
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (!showRectangularButton) {
          BlocProvider.of<OnTapListnerCubit>(context)
              .changeState(showRectangularButton);
          showRectangularButton = true;
        } else {
          BlocProvider.of<OnTapListnerCubit>(context)
              .changeState(showRectangularButton);
          showRectangularButton = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Customers List",
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(child: Image.asset('assets/images/Pixel6_logo.png')),
          BlocBuilder<GetCustomerBlocBloc, GetCustomerBlocState>(
            builder: (context, customerState) {
              return customerState is CustomersFetched
                  ? ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: customerState.customers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomerCardWidget(
                            customer: customerState.customers[index],
                          ),
                        );
                      })
                  : customerState is CustomerFetchingError
                      ? const Center(
                          child: Text(
                          "Some Error Ocurred",
                          style: TextStyle(color: Colors.white),
                        ))
                      : const Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
      floatingActionButton: BlocBuilder<OnTapListnerCubit, OnTapListnerState>(
        builder: (context, state) {
          return state is OnTapListnerSet
              ? !state.enable
                  ? RectangularFloatingActionButton(
                      label: "Add Customer",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddOrEditCustomerScreen(
                                  label: 'Add Customer',
                                  readOnly: false,
                                )));
                      },
                    )
                  : FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddOrEditCustomerScreen(
                                  label: 'Add Customer',
                                  readOnly: false,
                                )));
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.red,
                      ),
                    )
              : RectangularFloatingActionButton(
                  label: "Add Customer",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddOrEditCustomerScreen(
                              label: 'Add Customer',
                              readOnly: false,
                            )));
                  },
                );
        },
      ),
      floatingActionButtonLocation: _getFloatingActionButtonLocation(context),
    );
  }

  FloatingActionButtonLocation _getFloatingActionButtonLocation(
      BuildContext context) {
    final state = context.watch<OnTapListnerCubit>().state;
    if (state is OnTapListnerSet) {
      return state.enable
          ? FloatingActionButtonLocation.endDocked
          : FloatingActionButtonLocation.centerFloat;
    }
    return FloatingActionButtonLocation.endFloat; // Default location
  }
}
