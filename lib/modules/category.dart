import 'package:flutter/material.dart';
class CategoryWidget extends StatelessWidget {
  final int index;
  CategoryWidget({Key key, this.index}) : super(key: key);
  List <Map<String,Object>> categories= [
    {
      'categoryName':'الجبن',
      'categoryImage':'assets/images/cheese.jpg',
    },
    {
      'categoryName':'الشيكولاته',
      'categoryImage':'assets/images/choclate.jpg',
    },
    {
      'categoryName':'المجمدات',
      'categoryImage':'assets/images/mogmdat.jpg',
    },
    {
      'categoryName':'المودزريلا',
      'categoryImage':'assets/images/modzrilla.jpg',
    },
    {
      'categoryName':'الصوصات',
      'categoryImage':'assets/images/sos.jpg',
    },
    {
      'categoryName':'المثلجات',
      'categoryImage':'assets/images/moslgat.jpg',
    },
    {
      'categoryName':'التوابل',
      'categoryImage':'assets/images/twabl.jpg',
    },
    {
      'categoryName':'العيش السوري',
      'categoryImage':'assets/images/bread.jpg',
    },
    {
      'categoryName':'حللاوه المولد',
      'categoryImage':'assets/images/hlawa.jpg',
    },
    {
      'categoryName':'المكسرات',
      'categoryImage':'assets/images/mksrat.gif',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xff37475A).withOpacity(0.2),
            blurRadius: 20.0,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child:   Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: AssetImage(categories[index]['categoryImage']),
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          Container(
              height: 30,
              width: 150,
              color: Colors.black.withOpacity(0.8),
              child: Text(
                categories[index]['categoryName'],
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
