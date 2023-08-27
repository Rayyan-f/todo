import 'package:todo/features/todolist/data/models/taskmodel.dart';
import 'package:todo/features/todolist/domain/repositories/taskmodel_repo.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

 class TaskModelRepoImpl implements TaskModelRepo{
   final SharedPreferences sharedPreferences;

   TaskModelRepoImpl(this.sharedPreferences);

   @override
   Future<List<TaskModel>> getTasks() async {
     final tasks = sharedPreferences.getStringList('tasks') ?? [];
     return tasks.map((taskJson) => TaskModel.fromJson(json.decode(taskJson))).toList();
   }

   @override
   Future<void> addTask(TaskModel task) async {
     final tasks = await getTasks();
     tasks.add(task);
     await saveTasks(tasks);
   }

   @override
   Future<void> updateTask(TaskModel task) async {
     final tasks = await getTasks();
     final index = tasks.indexWhere((t) => t.id == task.id);
     if (index != -1) {
       tasks[index] = task;
       await saveTasks(tasks);
     }
   }

   Future<void> saveTasks(List<TaskModel> tasks) async {
     final tasksJson = tasks.map((task) => json.encode(task.toJson())).toList();
     await sharedPreferences.setStringList('tasks', tasksJson);
   }


  // Future<List<TaskModel>> getTasks();
  // Future<void> addTask(TaskModel task);
  // Future<void> updateTask(TaskModel task);
}
