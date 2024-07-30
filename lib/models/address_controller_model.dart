import 'package:flutter/material.dart';

class AddressControllerModel {
  final TextEditingController addressLine1;
  final TextEditingController addressLine2;
  final TextEditingController postCode;
  final TextEditingController state;
  final TextEditingController city;
  AddressControllerModel(
      {required this.addressLine1,
      required this.addressLine2,
      required this.postCode,
      required this.state,
      required this.city});
}
