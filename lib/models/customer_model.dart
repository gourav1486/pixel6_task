class AddressModel {
  final String addressLine1;
  final String addressLine2;
  final String postCode;
  final String state;
  final String city;
  AddressModel(
      {required this.addressLine1,
      required this.addressLine2,
      required this.city,
      required this.postCode,
      required this.state});
  factory AddressModel.fromMap(map) {
    return AddressModel(
        addressLine1: map['address_1'],
        addressLine2: map['address_2'],
        city: map['city'],
        postCode: map['post_code'],
        state: map['state']);
  }
}

class CustomerModel {
  final String customerName;
  final String mobileNumber;
  final String panNumber;
  final String email;
  final List<dynamic> addresses;
  CustomerModel(
      {required this.addresses,
      required this.customerName,
      required this.mobileNumber,
      required this.email,
      required this.panNumber});
  factory CustomerModel.fromMap(Map<String, dynamic> customer, addresses) {
    return CustomerModel(
        addresses: addresses.map((e) => AddressModel.fromMap(e)).toList(),
        customerName: customer['name'],
        mobileNumber: customer['mobile'].toString(),
        email: customer['email'],
        panNumber: customer['pan_number']);
  }
}
