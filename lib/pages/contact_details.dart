import 'package:flutter/material.dart';

class ContactDetailPage extends StatelessWidget {
  final String name;
  final String lastName;

  const ContactDetailPage(
      {super.key, required this.name, required this.lastName});

  @override
  Widget build(BuildContext context) {
    double width = 250;
    double height = 250;
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
                //                Padding(padding: EdgeInsetsDirectional.all(50)),
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
                Text('DETAILS1'),
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
                Text('DETAILS2'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
