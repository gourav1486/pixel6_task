import 'package:flutter/material.dart';
class RectangularFloatingActionButton extends StatelessWidget {
  const RectangularFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: 0.9 * MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            'Add Customer',
            style: TextStyle(
              color: Colors.red,
              fontSize: 24,
            ),
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
