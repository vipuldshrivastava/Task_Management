import 'package:flutter/material.dart';
import 'package:flutter_task_management/db/dbHelper.dart';
import 'package:get/get.dart';

import '../model/task.dart';

class TaskController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task})async{
    return await DBHelper.insert(task);
  }

  void getTasks() async{
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task){
    var val = DBHelper.delete(task);
    print(val);
    getTasks();
  }

  void markTaskCompleted(int id)async {
    await DBHelper.update(id);
    getTasks();
  }

}