import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> db() async {
    Database db =
        await openDatabase('customer_database.db', onCreate: ((db, version) {
      db.execute('''
CREATE TABLE customers(
customer_id TEXT PRIMARY KEY,
name TEXT,
pan_number TEXT,
email TEXT,
mobile INTEGER
)
''');
      db.execute('''
CREATE TABLE addresses(
address_id INTEGER AUTOINCREMENT NOT NULL,
customer_id TEXT,
name TEXT,
pan_number TEXT,
email TEXT,
mobile INTEGER,
FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE ON UPDATE NO ACTION
)
''');
    }));
    return db;
  }
  
}
