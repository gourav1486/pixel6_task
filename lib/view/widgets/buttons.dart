import 'package:flutter/material.dart';

class RectangularFloatingActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const RectangularFloatingActionButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60,
          width: 0.9 * MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
