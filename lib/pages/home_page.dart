import 'package:contact_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
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

  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  //reference the hive box

  final _myBox = Hive.box('mybox');
  ContactDataBase db = ContactDataBase();

  @override
  void initState() {
    if (_myBox.get("CONTACTLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // save contact to database
  void saveNewContact() {
    setState(() {
      var _contact = Contact(
          name: firstNameController.text,
          lastName: lastNameController.text,
          emailAddress: emailController.text,
          phoneNumber: phoneNumberController.text);

      db.contacts.add(_contact);
      db.updateDatabase();
      Navigator.of(context).pop();
    });
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
  }

  // create contact
  void createNewContact() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          firstNameController: firstNameController,
          lastNameController: lastNameController,
          emailController: emailController,
          phoneNumberController: phoneNumberController,
          onSave: () {
            if (firstNameController.text.isEmpty ||
                lastNameController.text.isEmpty ||
                emailController.text.isEmpty ||
                phoneNumberController.text.isEmpty) {
              HapticFeedback.vibrate();
              showSnack("Please fill all out the fields");
            } else {
              saveNewContact();
            }
          },
          onCancel: () {
            firstNameController.clear();
            lastNameController.clear();
            emailController.clear();
            phoneNumberController.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void showSnack(String title) {
    final snackbar = SnackBar(
        content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
      ),
    ));
    scaffoldMessengerKey.currentState?.showSnackBar(snackbar);
  }

  // delete contact
  void deleteContact(index) {
    setState(() {
      db.contacts.removeAt(index);
      db.updateDatabase();
    });
  }

  showwidget() {
    if (db.contacts.isEmpty) {
      return ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          body: Center(
            child: Text(
              "No Contacts",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    } else {
      return ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          body: ListView.builder(
              itemCount: db.contacts.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey)),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              deleteContact(index);
                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                            autoClose: true,
                            spacing: 5,
                          )
                        ],
                      ),
                      child: ListTile(
                        title: Text(db.contacts[index].name),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactDetailPage(
                                name: db.contacts[index].name,
                                lastName: db.contacts[index].lastName,
                                emailAddress: db.contacts[index].emailAddress,
                                phoneNumber: db.contacts[index].phoneNumber,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              })),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
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
