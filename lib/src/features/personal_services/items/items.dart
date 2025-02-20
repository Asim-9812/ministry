


import 'package:flutter/cupertino.dart';

class PersonalList{
  String name;
  String img;
  Widget? route;
  
  PersonalList({
    required this.name,
    required this.img,
    this.route
});
  
}

List<PersonalList> personalList =[
  PersonalList(name: 'My Documents', img: 'assets/images/personal_services/document.png',
  ),
  PersonalList(name: 'My Reports', img: 'assets/images/personal_services/report.png'
  ),
];