import 'package:flutter/material.dart';
import 'my_button.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class DialogBox extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.firstNameController,
      required this.lastNameController,
      required this.emailController,
      required this.phoneNumberController,
      required this.onCancel,
      required this.onSave});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('New Contact'),
      ),
      // ignore: sized_box_for_whitespace
      content: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextFormField(
              controller: widget.firstNameController,
              decoration: const InputDecoration(hintText: "First Name"),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your First Name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: widget.lastNameController,
              decoration: const InputDecoration(hintText: "Last Name"),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Last Name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: widget.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email Adress',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: widget.phoneNumberController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),

            //buttons -> Save + Cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //cancel button
                MyButton(text: "Cancel", onPressed: widget.onCancel),

                const SizedBox(
                  width: 25,
                ),
                //save button
                MyButton(text: "Add", onPressed: widget.onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}
