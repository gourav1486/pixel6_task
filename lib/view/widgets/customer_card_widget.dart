import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_assignment_task/models/customer_model.dart';
import 'package:pixel6_assignment_task/utils/local_storage_repo.dart';
import 'package:pixel6_assignment_task/view/screens/edit_add_customer_screen.dart';

import '../../business_logic/blocs/get_customers_bloc/get_customer_bloc_bloc.dart';

class CustomerCardWidget extends StatelessWidget {
  final CustomerModel customer;
  const CustomerCardWidget({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddOrEditCustomerScreen(
                    label: customer.customerName,
                    readOnly: true,
                    customer: customer,
                  )));
        },
        child: SizedBox(
          width: 0.9 * MediaQuery.of(context).size.width,
          child: ListTile(
            trailing: SizedBox(
              width: 0.25 * MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddOrEditCustomerScreen(
                                label: "Edit Customer",
                                readOnly: false,
                                customer: customer,
                              )));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await DatabaseHelper.deleteCustomer(customer.panNumber);
                         BlocProvider.of<GetCustomerBlocBloc>(context).add(GetCustomer());
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            title: Text(
              customer.customerName,
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Mobile No : ${customer.mobileNumber}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Email : ${customer.email}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
