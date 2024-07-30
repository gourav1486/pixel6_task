import 'package:flutter/material.dart';

class AddOrEditCustomerScreen extends StatelessWidget {
  final String label;
  final bool readOnly;
  AddOrEditCustomerScreen(
      {super.key, required this.label, required this.readOnly});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label,
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(child: Image.asset('assets/images/Pixel6_logo.png')),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controller,
                  validator: (value) {},
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                      labelText: "Label",
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Hint",
                      hintStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.white.withOpacity(0.2),
                      
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white))),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
