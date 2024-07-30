import 'package:flutter/material.dart';
import 'package:pixel6_assignment_task/models/address_controller_model.dart';
import 'package:pixel6_assignment_task/models/customer_model.dart';
import 'package:pixel6_assignment_task/view/widgets/custom_snacbar.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> db() async {
    Database db = await openDatabase('customer_database.db', version: 1,
        onCreate: ((db, version) async {
      await db.execute('''
CREATE TABLE customers(
name TEXT,
pan_number TEXT PRIMARY KEY,
email TEXT,
mobile INTEGER
)
''');
      await db.execute('''
CREATE TABLE addresses(
address_id INTEGER PRIMARY KEY AUTOINCREMENT,
address_1 TEXT,
address_2 TEXT,
post_code TEXT,
state TEXT,
city TEXT,
pan_number TEXT,
FOREIGN KEY(pan_number) REFERENCES customers(pan_number) ON DELETE CASCADE ON UPDATE NO ACTION
)
''');
    }));
    return db;
  }

  static Future<bool> insertCustomerIntoTable(
      String name,
      String mobile,
      String email,
      String pan,
      List<AddressControllerModel> addresses,
      context) async {
    final db = await DatabaseHelper.db();
    return await db.transaction((txn) async {
      var customers = await txn
          .query('customers', where: "pan_number =?", whereArgs: [pan]);
      if (customers.isEmpty) {
        var data = await txn.insert('customers', {
          'name': name,
          'pan_number': pan,
          'email': email,
          'mobile': mobile
        }).onError((error, stackTrace) async {
          return 0;
        });
        if (data != 0) {
          for (int i = 0; i < addresses.length; i++) {
            await txn.insert('addresses', {
              "address_1": addresses[i].addressLine1.text,
              "address_2": addresses[i].addressLine2.text,
              "post_code": addresses[i].postCode.text,
              "city": addresses[i].city.text,
              "pan_number": pan,
              "state": addresses[i].state.text
            });
          }
          return true;
        } else {
          return false;
        }
      } else {
        showCustomSnackbar(context, "Pan already exists", Colors.red);
        return false;
      }
      return true;
    });
  }

  static Future<bool> updateCustomer(String name, String mobile, String email,
      String pan, List<AddressControllerModel> addresses, context) async {
    final db = await DatabaseHelper.db();
    return await db.transaction((txn) async {
      await txn.update('customers', {
        'name': name,
        'email': email,
        'mobile': mobile
      }).onError((error, stackTrace) async {
        return 0;
      });
      await txn.delete('addresses', where: "pan_number =?", whereArgs: [pan]);
      for (int i = 0; i < addresses.length; i++) {
        await txn.insert('addresses', {
          "address_1": addresses[i].addressLine1.text,
          "address_2": addresses[i].addressLine2.text,
          "post_code": addresses[i].postCode.text,
          "city": addresses[i].city.text,
          "pan_number": pan,
          "state": addresses[i].state.text
        });
      }
      return true;
    });
  }

  Future<List<CustomerModel>> getCustomers() async {
    final db = await DatabaseHelper.db();
    List<CustomerModel> customerList = [];
    return await db.transaction((txn) async {
      List<Map<String, dynamic>> customers = await txn.query('customers');
      for (int i = 0; i < customers.length; i++) {
        var addresses = await txn.query('addresses',
            where: "pan_number=?", whereArgs: [customers[i]['pan_number']]);

        customerList.add(CustomerModel.fromMap(customers[i], addresses));
      }
      return customerList;
    });
  }

  static Future<bool> deleteCustomer(String panId) async {
    final db = await DatabaseHelper.db();
    return await db.transaction((txn) async {
      await txn.delete('customers', where: "pan_number =?", whereArgs: [panId]);
      await txn.delete('addresses', where: "pan_number =?", whereArgs: [panId]);
      return true;
    });
  }
}
