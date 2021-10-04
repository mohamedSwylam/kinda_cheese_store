import 'package:flutter/material.dart';

Widget userListTile(
    String title, String subTitle, IconData icon , BuildContext context) {
  return ListTile(
    title: Padding(
      padding: const EdgeInsets.only(left: 170.0),
      child: Text(title),
    ),
    subtitle: Padding(
      padding: const EdgeInsets.only(left: 120.0),
      child: Text(subTitle),
    ),
    trailing: Icon(icon),
  );
}

Widget userTitle({ String title}) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
    ),
  );
}
Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);