import '../../domain/entities/taskmodel.dart';

class TaskModel extends TaskModelEntity {

 TaskModel({
     int? id,
     String? title,
     bool? isCompleted,
  }): super(
    id: id,
    title: title,
    isCompleted: isCompleted
  );


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }


}
