


import '../../domain/model/medicine_reminder_model.dart';

final medicineUnitList = medicineUnitJsonList.map((e)=>MedicineUnit.fromJson(e)).toList();


final medicineUnitJsonList = [
  {
    "unitId": 1,
    "units": "N/A",
    "flag": null
  },
  {
    "unitId": 2,
    "units": "%V/V ",
    "flag": null
  },
  {
    "unitId": 3,
    "units": "%W/V",
    "flag": null
  },
  {
    "unitId": 4,
    "units": "/DOSE EID50",
    "flag": null
  },
  {
    "unitId": 5,
    "units": "ANTIGEN",
    "flag": null
  },
  {
    "unitId": 6,
    "units": "AU",
    "flag": null
  },
  {
    "unitId": 7,
    "units": "CCID50",
    "flag": null
  },
  {
    "unitId": 8,
    "units": "CELLS",
    "flag": null
  },
  {
    "unitId": 9,
    "units": "CFU",
    "flag": null
  },
  {
    "unitId": 10,
    "units": "CC",
    "flag": null
  },
  {
    "unitId": 11,
    "units": "DU",
    "flag": null
  },
  {
    "unitId": 12,
    "units": "EID50",
    "flag": null
  },
  {
    "unitId": 13,
    "units": "E-UNIT",
    "flag": null
  },
  {
    "unitId": 14,
    "units": "G/100ML",
    "flag": null
  },
  {
    "unitId": 15,
    "units": "GAL",
    "flag": null
  },
  {
    "unitId": 16,
    "units": "GL",
    "flag": null
  },
  {
    "unitId": 17,
    "units": "GM/100ML",
    "flag": null
  },
  {
    "unitId": 18,
    "units": "GM/5ML",
    "flag": null
  },
  {
    "unitId": 19,
    "units": "GM/L",
    "flag": null
  },
  {
    "unitId": 20,
    "units": "GM/VIAL",
    "flag": null
  },
  {
    "unitId": 21,
    "units": "GMl",
    "flag": null
  },
  {
    "unitId": 22,
    "units": "GM",
    "flag": null
  },
  {
    "unitId": 23,
    "units": "GM/15ML",
    "flag": null
  },
  {
    "unitId": 24,
    "units": "GM/ML",
    "flag": null
  },
  {
    "unitId": 25,
    "units": "I/ML",
    "flag": null
  },
  {
    "unitId": 26,
    "units": "INJECTION",
    "flag": null
  },
  {
    "unitId": 27,
    "units": "IU",
    "flag": null
  },
  {
    "unitId": 28,
    "units": "IU/0.5ML",
    "flag": null
  },
  {
    "unitId": 29,
    "units": "IU/0.75ML",
    "flag": null
  },
  {
    "unitId": 30,
    "units": "IU/5ML",
    "flag": null
  },
  {
    "unitId": 31,
    "units": "IU/ML",
    "flag": null
  },
  {
    "unitId": 32,
    "units": "IU/VIAL",
    "flag": null
  },
  {
    "unitId": 33,
    "units": "K.U./VIAL",
    "flag": null
  },
  {
    "unitId": 34,
    "units": "KG",
    "flag": null
  },
  {
    "unitId": 35,
    "units": "LF",
    "flag": null
  },
  {
    "unitId": 36,
    "units": "L",
    "flag": null
  },
  {
    "unitId": 37,
    "units": "LIVE",
    "flag": null
  },
  {
    "unitId": 38,
    "units": "M",
    "flag": null
  },
  {
    "unitId": 39,
    "units": "MARYLA",
    "flag": null
  },
  {
    "unitId": 40,
    "units": "MCG/0.3ML",
    "flag": null
  },
  {
    "unitId": 41,
    "units": "MCG/0.5ML",
    "flag": null
  },
  {
    "unitId": 42,
    "units": "MCG/GM",
    "flag": null
  },
  {
    "unitId": 43,
    "units": "MCG/ML",
    "flag": null
  },
  {
    "unitId": 44,
    "units": "MG/0.4ML",
    "flag": null
  },
  {
    "unitId": 45,
    "units": "MG/0.5ML",
    "flag": null
  },
  {
    "unitId": 46,
    "units": "MG/0.6ML",
    "flag": null
  },
  {
    "unitId": 47,
    "units": "MG/1.5ML",
    "flag": null
  },
  {
    "unitId": 48,
    "units": "MG/100ML",
    "flag": null
  },
  {
    "unitId": 49,
    "units": "MG/10ML",
    "flag": null
  },
  {
    "unitId": 50,
    "units": "MG/15ML",
    "flag": null
  },
  {
    "unitId": 51,
    "units": "MG/16.7ML",
    "flag": null
  },
  {
    "unitId": 52,
    "units": "MG/20ML",
    "flag": null
  },
  {
    "unitId": 53,
    "units": "MG/25ML",
    "flag": null
  },
  {
    "unitId": 54,
    "units": "MG/2ML",
    "flag": null
  },
  {
    "unitId": 55,
    "units": "MG/45ML",
    "flag": null
  },
  {
    "unitId": 56,
    "units": "MG/4ML",
    "flag": null
  },
  {
    "unitId": 57,
    "units": "MG/50ML",
    "flag": null
  },
  {
    "unitId": 58,
    "units": "MG/5ML",
    "flag": null
  },
  {
    "unitId": 59,
    "units": "MG/GM",
    "flag": null
  },
  {
    "unitId": 60,
    "units": "MG/L",
    "flag": null
  },
  {
    "unitId": 61,
    "units": "MG/VIAL",
    "flag": null
  },
  {
    "unitId": 62,
    "units": "MGCL",
    "flag": null
  },
  {
    "unitId": 63,
    "units": "MGl",
    "flag": null
  },
  {
    "unitId": 64,
    "units": "MCG",
    "flag": null
  },
  {
    "unitId": 65,
    "units": "MG",
    "flag": null
  },
  {
    "unitId": 66,
    "units": "MG/10ML ",
    "flag": null
  },
  {
    "unitId": 67,
    "units": "MG/ML",
    "flag": null
  },
  {
    "unitId": 68,
    "units": "ML",
    "flag": null
  },
  {
    "unitId": 69,
    "units": "MMOL/ML",
    "flag": null
  },
  {
    "unitId": 70,
    "units": "MMOL",
    "flag": null
  },
  {
    "unitId": 71,
    "units": "MILLION",
    "flag": null
  },
  {
    "unitId": 72,
    "units": "MIU",
    "flag": null
  },
  {
    "unitId": 73,
    "units": "MML",
    "flag": null
  },
  {
    "unitId": 74,
    "units": "MOL",
    "flag": null
  },
  {
    "unitId": 75,
    "units": "MU",
    "flag": null
  },
  {
    "unitId": 76,
    "units": "NLT IU",
    "flag": null
  },
  {
    "unitId": 77,
    "units": "GT IU",
    "flag": null
  },
  {
    "unitId": 78,
    "units": "OUN",
    "flag": null
  },
  {
    "unitId": 79,
    "units": "%",
    "flag": null
  },
  {
    "unitId": 80,
    "units": "%V/V",
    "flag": null
  },
  {
    "unitId": 81,
    "units": "%W/W",
    "flag": null
  },
  {
    "unitId": 82,
    "units": "PFU",
    "flag": null
  },
  {
    "unitId": 83,
    "units": "PFU ",
    "flag": null
  },
  {
    "unitId": 84,
    "units": "PT",
    "flag": null
  },
  {
    "unitId": 85,
    "units": "LBS",
    "flag": null
  },
  {
    "unitId": 86,
    "units": "RID50",
    "flag": null
  },
  {
    "unitId": 87,
    "units": "STRAIN",
    "flag": null
  },
  {
    "unitId": 88,
    "units": "STRENGTH",
    "flag": null
  },
  {
    "unitId": 89,
    "units": "TTSP",
    "flag": null
  },
  {
    "unitId": 90,
    "units": "TCID50",
    "flag": null
  },
  {
    "unitId": 91,
    "units": "TSP",
    "flag": null
  },
  {
    "unitId": 92,
    "units": "TERR",
    "flag": null
  },
  {
    "unitId": 93,
    "units": "U/ML",
    "flag": null
  },
  {
    "unitId": 94,
    "units": "UG",
    "flag": null
  },
  {
    "unitId": 95,
    "units": "U",
    "flag": null
  },
  {
    "unitId": 96,
    "units": "UNITS/VIAL",
    "flag": null
  },
  {
    "unitId": 97,
    "units": "uUNITS",
    "flag": null
  },
  {
    "unitId": 98,
    "units": "VACCINE",
    "flag": null
  },
  {
    "unitId": 99,
    "units": "VIRUS",
    "flag": null
  },
  {
    "unitId": 100,
    "units": "VV",
    "flag": null
  },
  {
    "unitId": 101,
    "units": "W/W",
    "flag": null
  },
  {
    "unitId": 102,
    "units": "WV",
    "flag": null
  },
  {
    "unitId": 103,
    "units": "WW",
    "flag": null
  },
  {
    "unitId": 19,
    "units": "N/A",
    "flag": null
  }
];