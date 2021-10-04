import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 80),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/cart3.png'),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Text(
          'سله المشتريات فارغه ',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: 33,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'يبدو انك لم تقم باضافه اي مشتريات حتي الان',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
        ),),
        SizedBox(
          height: 40,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.06,
          child: RaisedButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.red),
            ),
            color: Colors.redAccent,
            child: Text(
              'تسوق الان',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
