import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/config/themes/apptheme.dart';
import 'package:todo/features/todolist/data/repositories/taskmodelrepo.dart';
import 'package:todo/features/todolist/domain/repositories/taskmodel_repo.dart';



import '../../data/models/taskmodel.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final taskRepository = TaskModelRepoImpl(sharedPreferences);

  runApp(TaskListApp(taskRepository: taskRepository));
}

class TaskListApp extends StatelessWidget {
  final TaskModelRepoImpl taskRepository;

  TaskListApp({required this.taskRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: TaskListScreen(repository: taskRepository),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  final TaskModelRepo repository;

  TaskListScreen({required this.repository});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<TaskModel> tasks = [];
  TextEditingController _newTaskController = TextEditingController();
  bool isCompleted=false;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final loadedTasks = await widget.repository.getTasks();
    setState(() {
      tasks = loadedTasks;
    });
  }

  Future<void> _addNewTask(String title , bool isCompleted) async {
    if (title.isNotEmpty) {
      final newTask = TaskModel(id: tasks.length + 1, title: title, isCompleted: isCompleted);
      await widget.repository.addTask(newTask);
      _newTaskController.clear();
      _loadTasks();
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(title: Text('Task List')),
        body:Column(
          children:[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children:[
                  Row(
                    children:[
                      Text('Have you completed this Task?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Checkbox(
                        value:isCompleted,
                        onChanged: (newValue) {
                          setState(() {
                            isCompleted=!isCompleted;

                            // tasks[index].isCompleted =true;
                            // widget.repository.updateTask(tasks[index]);
                          });
                        },
                      ),
                    ],),
                  TextField(
                    controller: _newTaskController,
                    decoration: InputDecoration(
                      labelText: 'New Task',
                      suffixIcon: IconButton(
                        onPressed: () {

                          _addNewTask(_newTaskController.text,isCompleted);
                          _newTaskController.clear();
                          _loadTasks();
                          setState(() {
                            isCompleted=false;
                          });
                        },
                        icon: Icon(Icons.add),

                      ),
                    ),
                  ),
                ],),
            ),
            Expanded(child:
            ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Checkbox(
                    value: tasks[index].isCompleted,
                    onChanged: (newValue) {
                      setState(() {
                       
                           tasks[index].isCompleted=!tasks[index].isCompleted!;
                        widget.repository.updateTask(tasks[index]);
                      });
                    },
                  ),
                );
              },
            ),
            ),
          ],),
      ),
    );
  }
}
