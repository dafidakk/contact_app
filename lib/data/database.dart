import 'package:contact_app/model/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ContactDataBase {
  List contacts = [];
  //reference our box
  final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    var _contact = Contact(
        name: 'name',
        lastName: 'lastName',
        emailAddress: 'emailAddress',
        phoneNumber: 'phoneNumber');
    contacts.add(_contact);
  }

  //load the data from database
  void loadData() {
    contacts = _myBox.get("CONTACTLIST");
  }

  // update the database
  void updateDatabase() {
    _myBox.put("CONTACTLIST", contacts);
  }

  void deleteFromDatabase() {}
}
