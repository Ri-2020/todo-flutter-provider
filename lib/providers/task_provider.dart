import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/task.dart';
import 'package:todo/utils/utils.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];

  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      if (prefs.containsKey(UtilStirngs.taskKey)) {
        String? strList = prefs.getString(UtilStirngs.taskKey) ?? "[]";

        List<dynamic> strl = jsonDecode(strList);

        tasks = strl.map(
          (e) {
            return Task.fromJson(jsonDecode(e));
          },
        ).toList();
        notifyListeners();
      }
    } catch (e) {
      Logger().e("Some Eror occured while loading tasks: $e");
    }
  }

  Future<void> saveTasks() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> strList = tasks
          .map(
            (item) => jsonEncode(
              item.toJson(),
            ),
          )
          .toList();
      prefs.setString(UtilStirngs.taskKey, jsonEncode(strList));
    } catch (e) {
      Logger().e("Error while saving tasks: $e");
    }
  }

  Future<void> addTask(Task task) async {
    tasks.add(task);
    await saveTasks();
    notifyListeners();
  }

  void removeTask(int index) async {
    tasks.removeAt(index);
    await saveTasks();
    notifyListeners();
  }

  void toggleTaskDone(int index) async {
    tasks[index].isDone = !tasks[index].isDone;
    Task thisTask = tasks[index];
    tasks.removeAt(index);
    if (thisTask.isDone) {
      tasks.insert(
        tasks.length - tasks.where((e) => !e.isDone).toList().length,
        thisTask,
      );
    } else {
      tasks.add(thisTask);
    }
    await saveTasks();
    notifyListeners();
  }
}
