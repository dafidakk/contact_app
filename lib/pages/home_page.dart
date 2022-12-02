import 'package:contact_app/model/model.dart';
import 'package:flutter/material.dart';
import '../utils/contact_dialog.dart';
import 'contact_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  final String title = "Contacts";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  List<Contact> contactList = [];

  // var _contact = Contact(name: name, lastName: lastName, emailAddress: emailAddress, phoneNumber: phoneNumber)

  void saveNewContact() {
    setState(() {
      contactList.add(
        Contact(
            name: firstNameController.text,
            lastName: lastNameController.text,
            emailAddress: emailController.text,
            phoneNumber: phoneNumberController.text),
      );
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      phoneNumberController.clear();
      Navigator.of(context).pop();
    });
  }

  void createNewContact() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          firstNameController: firstNameController,
          lastNameController: lastNameController,
          emailController: emailController,
          phoneNumberController: phoneNumberController,
          onSave: saveNewContact,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  showwidget() {
    if (contactList.isEmpty) {
      return Text(
        "No Contacts",
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    } else {
      //return Card();
      return Scaffold(
        body: ListView.builder(
            itemCount: contactList.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)),
                  child: ListTile(
                    title: Text(contactList[index].name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailPage(
                            name: contactList[index].name,
                            lastName: contactList[index].lastName,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            })),
        // child: Text(contactList.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            // https://www.fluttercampus.com/guide/131/how-to-use-conditional-statement-if-else-on-widget-in-flutter/
            child: showwidget(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewContact,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
