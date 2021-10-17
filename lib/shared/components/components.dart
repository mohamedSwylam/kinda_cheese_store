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
navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context,) => widget));
navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget userTitle({ String title}) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
    ),
  );
}
Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey,
);
Future<void> showDialogg(context,title,subtitle,Function function) async {
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding:
                const EdgeInsets.only(right: 6.0),
                child: Image.network(
                  'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                  height: 20,
                  width: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title),
              ),
            ],
          ),
          content: Text(subtitle),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text('الغاء')),
            TextButton(
                onPressed: () async {
                  function();
                  Navigator.pop(context);
                },
                child: Text(
                  'موافق',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        );
      });
}