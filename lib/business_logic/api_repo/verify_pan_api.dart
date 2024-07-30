import 'dart:convert';

import 'package:http/http.dart' as http;

class PanVerifyAPi {
  Future<Map<String, dynamic>> verifyPan(String code) async {
    var res = await http.post(
        Uri.parse('https://lab.pixel6.co/api/verify-pan.php'),
        body: jsonEncode({"panNumber": code}));

    if (res.statusCode == 200) {
      try {
        var data = jsonDecode(res.body);
        if (data['status'] == 'Success') {
          return {"status": true, "data": data};
        } else {
          return {
            'status': false,
          };
        }
      } catch (e) {
        return {
          'status': false,
        };
      }
    } else {
      return {
        'status': false,
      };
    }
  }
}
