import 'dart:convert';

import 'package:http/http.dart' as http;

class PostCodeApi {
  Future<Map<String, dynamic>> getAddressFromApi(String code) async {
    var res = await http.post(
        Uri.parse('https://lab.pixel6.co/api/get-postcode-details.php'),
        body: jsonEncode({"postcode": code}));

    if (res.statusCode == 200) {
      return {"status": true, "data": jsonDecode(res.body)};
    } else {
      return {
        'status': false,
      };
    }
  }
}
