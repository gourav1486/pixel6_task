import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel6_assignment_task/business_logic/blocs/get_postal_code_bloc/get_postal_details_bloc.dart';
import 'package:pixel6_assignment_task/models/address_controller_model.dart';
import 'package:pixel6_assignment_task/view/widgets/text_form_field_widgets.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget(
      {super.key,
      required this.address,
      required this.index,
      this.readOnly,
      required this.onDelete});
  final Function(int) onDelete;
  final AddressControllerModel address;
  final int index;
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        backgroundColor: Colors.white.withOpacity(0.2),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        initiallyExpanded: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.white)),
        title: Text(
          "Address ${index + 1}",
          style: TextStyle(color: Colors.white),
        ),
        children: [
          BlocBuilder<GetPostalDetailsBloc, GetPostalDetailsState>(
            builder: (context, state) {
              // if (state is PostalDetailsFetched) {
              //   address.city.text = state.data['city'][0]['name'];
              //   address.state.text = state.data['state'][0]['name'];
              // }
              return Column(
                children: [
                  TextFormFieldWidget(
                    controller: address.addressLine1,
                    hintText: 'Enter Address Line 1',
                    label: 'Address Line 1',
                   enabled: !readOnly!, 
                    validator: (value) {
                      print(value);
                      if (value == null || value!.isEmpty) {
                        return 'Please enter address line 1';
                      }
                      return null;
                    },
                  ),
                  TextFormFieldWidget(
                    enabled: (readOnly != null&& !readOnly!),
                    controller: address.addressLine2,
                    hintText: 'Enter Address Line 2',
                    label: 'Address Line 2',
                  ),
                  TextFormFieldWidget(
                    controller: address.postCode,
                     enabled: (readOnly != null&& !readOnly!),
                    hintText: 'Enter Postcode',
                    label: 'Postcode',
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    onChange: (val) {
                      BlocProvider.of<GetPostalDetailsBloc>(context).add(
                          GetPostalCode(
                              code: address.postCode.text, address: address));
                    },
                    validator: (value) {
                      if (value == null || value!.isEmpty) {
                        return 'Please enter post code';
                      }
                      return null;
                    },
                  ),
                  TextFormFieldWidget(
                      controller: address.state,
                      enabled: false,
                      hintText: 'Enter State',
                      label: 'State'),
                  TextFormFieldWidget(
                    enabled: false,
                      controller: address.city,
                      hintText: 'Enter City',
                      label: 'City'),
                  if (index != 0 && readOnly == true)
                    TextButton(
                        onPressed: () {
                          onDelete(index);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Remove',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            )
                          ],
                        ))
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
