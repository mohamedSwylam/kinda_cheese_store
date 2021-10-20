import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
Widget defaultButton(
    {@required Function function,
      @required String text,
      @required Color color}) =>
    Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
          topRight: Radius.circular(50),
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(text),
        height: 50,
        textColor: Colors.white,
      ),
    );
void showToast({@required String text, @required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      timeInSecForIosWeb: 5,
    );
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
Widget defaultFormField({
  @required TextInputType type,
  @required TextEditingController controller,
  String labelText,
  IconData prefix,
  IconData suffix,
  bool isPassword = false ,
  Function validate,
  Function onChange,
  Function onSubmit,
  BuildContext context,
  Function suffixPressed,
}) => TextFormField(
  controller: controller,
  validator: validate,
  obscureText: isPassword,
  textInputAction: TextInputAction.next,
  keyboardType: type,
  textAlign: TextAlign.end,
  decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
    suffixIcon: suffix != null
        ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    )
        : null,
      prefixIcon: Icon(prefix),
      labelText: labelText,
      fillColor: Theme.of(context).backgroundColor),
  onSaved: (value) {
  },
);
    /*TextFormField(

      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      obscureText: isPassword,
      validator: validate,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        prefixIcon: Icon(
          prefix,
          color: iconColor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
      ),
    );*/
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