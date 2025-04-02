


import '../../domain/model/medicine_reminder_model.dart';

final medicineRouteList = medicineRouteJsonList.map((e)=>MedicineRoute.fromJson(e)).toList();


final medicineRouteJsonList = [
  {
    "id": 1,
    "route": "P/O"
  },
  {
    "id": 2,
    "route": "IV"
  },
  {
    "id": 3,
    "route": "Topical"
  },
  {
    "id": 4,
    "route": "IM"
  },
  {
    "id": 5,
    "route": "SC"
  },
  {
    "id": 6,
    "route": "PV"
  },
  {
    "id": 7,
    "route": "PR"
  },
  {
    "id": 8,
    "route": "Nasal"
  },
  {
    "id": 9,
    "route": "Ocular"
  },
  {
    "id": 10,
    "route": "Sublingual"
  },
  {
    "id": 11,
    "route": "Inhalation"
  },
  {
    "id": 12,
    "route": "Spray"
  },
  {
    "id": 13,
    "route": "Puffs"
  },
  {
    "id": 14,
    "route": "LA(locally applied)"
  },
  {
    "id": 15,
    "route": "Intra Arterial"
  },
  {
    "id": 16,
    "route": "Intra Nasal"
  },
  {
    "id": 17,
    "route": "Transdermal"
  },
  {
    "id": 18,
    "route": "OTIC"
  }
];