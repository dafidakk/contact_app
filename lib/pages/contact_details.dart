import 'package:flutter/material.dart';

class ContactDetailPage extends StatelessWidget {
  final String name;
  final String lastName;
  final String emailAddress;
  final String phoneNumber;

  const ContactDetailPage(
      {super.key,
      required this.name,
      required this.lastName,
      required this.emailAddress,
      required this.phoneNumber});

  // Detail sayfasında bir önceki sayfadan gelmesini istediğimiz bilgileri required olarak buraya ekliyoruz.
  // Önceki sayfada onTap metodunda ContactDetailPage fonksiyonunu verirken required olan propertyleri istiyor zaten oradan gitmek zorunda kalıyoruz

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name + " " + lastName),
        centerTitle: true,
      ),
      body: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 100,
                    backgroundImage: AssetImage(
                      "assets/images/profile.png",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(24),
                ),
                Text(
                  'Phone Number:  ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(phoneNumber),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(24),
                ),
                Text(
                  'Email Address:  ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(emailAddress)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
