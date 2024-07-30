import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_assignment_task/business_logic/api_repo/post_code_api.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/address_controller_cubit/address_controller_cubit.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/get_customers_bloc/get_customer_bloc_bloc.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/verify_pan_bloc/verify_pan_bloc.dart';
import 'package:pixel6_assignment_task/models/address_controller_model.dart';
import 'package:pixel6_assignment_task/models/customer_model.dart';
import 'package:pixel6_assignment_task/utils/local_storage_repo.dart';
import 'package:pixel6_assignment_task/view/widgets/buttons.dart';
import 'package:pixel6_assignment_task/view/widgets/custom_snacbar.dart';
import 'package:pixel6_assignment_task/view/widgets/text_form_field_widgets.dart';

import '../widgets/address_widget.dart';

class AddOrEditCustomerScreen extends StatefulWidget {
  final String label;
  final bool readOnly;
  final CustomerModel? customer;
  AddOrEditCustomerScreen(
      {super.key, required this.label, required this.readOnly, this.customer});

  @override
  State<AddOrEditCustomerScreen> createState() =>
      _AddOrEditCustomerScreenState();
}

class _AddOrEditCustomerScreenState extends State<AddOrEditCustomerScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final TextEditingController _panController = TextEditingController();
  var panState;
  List<AddressControllerModel> addresses = [
    AddressControllerModel(
        addressLine1: TextEditingController(),
        addressLine2: TextEditingController(),
        postCode: TextEditingController(),
        state: TextEditingController(),
        city: TextEditingController())
  ];
  @override
  void initState() {
    if (widget.customer != null) {
      addresses.clear();
      _panController.text =
          "********${widget.customer!.panNumber.substring(widget.customer!.panNumber.length - 2)}";

      _nameController.text = widget.customer!.customerName;
      _emailController.text = widget.customer!.email;
      _phoneController.text = widget.customer!.mobileNumber;
      BlocProvider.of<VerifyPanBloc>(context)
          .add(VerifyPan(panNumber: widget.customer!.panNumber));
      for (int i = 0; i < widget.customer!.addresses.length; i++) {
        addresses.add(AddressControllerModel(
            addressLine1: TextEditingController(
                text: widget.customer!.addresses[i].addressLine1),
            addressLine2: TextEditingController(
                text: widget.customer!.addresses[i].addressLine2),
            postCode: TextEditingController(
                text: widget.customer!.addresses[i].postCode),
            state: TextEditingController(
                text: widget.customer!.addresses[i].state),
            city: TextEditingController(
                text: widget.customer!.addresses[i].city)));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.label,
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(child: Image.asset('assets/images/Pixel6_logo.png')),
          SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  TextFormFieldWidget(
                    enabled: !widget.readOnly,
                    controller: _nameController,
                    label: "Full Name *",
                    hintText: "Customer Full Name *",
                    maxLength: 140,
                    validator: (value) {
                      if (value == null || value!.isEmpty) {
                        return "Please enter full name";
                      }
                      return null;
                    },
                  ),
                  TextFormFieldWidget(
                    controller: _phoneController,
                    enabled: !widget.readOnly,
                    label: "Mobile Number *",
                    prefix: '+91',
                    hintText: "Customer Mobile Number *",
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value!.isEmpty) {
                        return "Please enter mobile number";
                      } else if (int.parse(value) / 6000000000 < 1) {
                        return "Enter valid number";
                      }
                      return null;
                    },
                  ),
                  TextFormFieldWidget(
                    controller: _emailController,
                    enabled: !widget.readOnly,
                    label: "Email Address *",
                    maxLength: 255,
                    hintText: "Customer Email Address *",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value!.isEmpty) {
                        return "Please enter email address";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                  ),
                  TextFormFieldWidget(
                    controller: _panController,
                    enabled: (!widget.readOnly && widget.customer == null),
                    label: "PAN *",
                    hintText: "Customer PAN number",
                    maxLength: 10,
                    onChange: (value) {
                      BlocProvider.of<VerifyPanBloc>(context)
                          .add(VerifyPan(panNumber: _panController.text));
                    },
                    suffixIcon: BlocBuilder<VerifyPanBloc, VerifyPanState>(
                      builder: (context, state) {
                        panState = state;
                        return state is PanVerifiedSuccess
                            ? Icon(Icons.check, color: Colors.green)
                            : Icon(Icons.close, color: Colors.red);
                      },
                    ),
                    validator: (value) {
                      if (value == null || value!.isEmpty) {
                        return "Please enter PAN number";
                      } else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$')
                              .hasMatch(value) &&
                          widget.customer == null) {
                        return "Enter valid PAN";
                      }
                      return null;
                    },
                  ),
                  BlocBuilder<AddressControllerCubit, AddressControllerState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          for (int i = 0; i < addresses.length; i++)
                            AddressWidget(
                              address: addresses[i],
                              index: i,
                              readOnly: widget.readOnly,
                              onDelete: (index) {
                                if (addresses.length > 1) {
                                  addresses.removeAt(index);
                                  BlocProvider.of<AddressControllerCubit>(
                                          context)
                                      .appendAddress(addresses);
                                }
                              },
                            ),
                        ],
                      );
                    },
                  ),
                  if (widget.customer == null)
                    TextButton(
                        onPressed: () {
                          addresses.add(AddressControllerModel(
                              addressLine1: TextEditingController(),
                              addressLine2: TextEditingController(),
                              postCode: TextEditingController(),
                              state: TextEditingController(),
                              city: TextEditingController()));
                          BlocProvider.of<AddressControllerCubit>(context)
                              .appendAddress(addresses);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Add More Address',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.add_rounded,
                              color: Colors.red,
                            )
                          ],
                        )),
                  if (!widget.readOnly)
                    RectangularFloatingActionButton(
                        label: 'Submit Customer',
                        onTap: () async {
                          if (_key.currentState!.validate()) {
                            if (panState is PanVerifiedSuccess) {
                              var data = (widget.customer == null)
                                  ? await DatabaseHelper
                                      .insertCustomerIntoTable(
                                          _nameController.text,
                                          _phoneController.text,
                                          _emailController.text,
                                          _panController.text,
                                          addresses,
                                          context)
                                  : await DatabaseHelper.updateCustomer(
                                      _nameController.text,
                                      _phoneController.text,
                                      _emailController.text,
                                      widget.customer!.panNumber,
                                      addresses,
                                      context);
                              if (data) {
                                BlocProvider.of<GetCustomerBlocBloc>(context)
                                    .add(GetCustomer());
                                Navigator.of(context).pop();
                              } else {
                                showCustomSnackbar(
                                    context, 'Some error occured', Colors.red);
                              }
                            } else {
                              showCustomSnackbar(context,
                                  'Pan Verification failed', Colors.red);
                            }
                          }
                        })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
