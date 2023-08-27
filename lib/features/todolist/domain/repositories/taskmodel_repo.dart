
import 'package:todo/features/todolist/data/models/taskmodel.dart';

abstract class TaskModelRepo{
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
}
