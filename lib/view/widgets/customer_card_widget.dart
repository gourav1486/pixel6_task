import 'package:flutter/material.dart';
class CustomerCardWidget extends StatelessWidget {
  const CustomerCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 0.9 * MediaQuery.of(context).size.width,
        child: ListTile(
          title: Text(
            "Gourav Sawarkar",
            style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mobile No : 7798083214",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                "Email : gouravmsawarkar1@gmail",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
