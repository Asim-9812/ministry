



class ReminderTagModel{

  int? typeId;
  String typeName;

  ReminderTagModel({
    this.typeId,
    required this.typeName
});

}

final reminderTagList = [
  ReminderTagModel(typeName: 'All', typeId: null),
  ReminderTagModel(typeName: 'Medicine', typeId: 1),
  ReminderTagModel(typeName: 'General', typeId: 2),
  ReminderTagModel(typeName: 'Notes', typeId: 3),
];