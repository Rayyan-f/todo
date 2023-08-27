import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:todo/features/todolist/data/repositories/taskmodelrepo.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'config/themes/apptheme.dart';

import 'package:todo/features/todolist/domain/repositories/taskmodel_repo.dart';

import 'features/todolist/presentation/pages/screen_task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final taskRepository = TaskModelRepoImpl(sharedPreferences);

  runApp(TaskListApp(taskRepository: taskRepository));
}

class TaskListApp extends StatelessWidget {
  final TaskModelRepo taskRepository;

  TaskListApp({required this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: TaskListScreen(repository: taskRepository),
    );
  }
}
