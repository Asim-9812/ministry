


import 'package:flutter/cupertino.dart';
import 'package:ministry/src/features/old_documents/presentation/document_page.dart';

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
  PersonalList(name: 'Documents', img: 'assets/images/personal_services/bp.png',
    route: PatientDocumentPage()
  ),
  PersonalList(name: 'Prescription', img: 'assets/images/personal_services/prescribe.png'

  ),
  PersonalList(name: 'Lab', img: 'assets/images/personal_services/lab.png',

  ),
  PersonalList(name: 'Discharge', img: 'assets/images/personal_services/discharge.png'

  ),
  PersonalList(name: 'X-Ray', img: 'assets/images/personal_services/xray.png'

  ),
  PersonalList(name: 'USG', img: 'assets/images/personal_services/usg.png'

  ),
  PersonalList(name: 'CT Scan', img: 'assets/images/personal_services/ct.png'

  ),
  PersonalList(name: 'MRI', img: 'assets/images/personal_services/mri.png'

  ),
];