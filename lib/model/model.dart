import 'package:hive/hive.dart';

part 'model.g.dart';

// after decorating run command below
// flutter packages pub run build_runner build

@HiveType(typeId: 0)
class Contact extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String lastName;

  @HiveField(2)
  String emailAddress;

  @HiveField(3)
  String phoneNumber;

  Contact(
      {required this.name,
      required this.lastName,
      required this.emailAddress,
      required this.phoneNumber});
}
