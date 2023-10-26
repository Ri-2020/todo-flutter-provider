import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/task.dart';
import 'package:todo/utils/utils.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];

  // List<Task> inCompleteTasks = [];

  // void getIncompleteTasks() {
  //   Logger().i(
  //       "Incomplete Tasks: ${tasks.where((element) => !element.isDone).toList().length}");
  //   inCompleteTasks = tasks.where((element) => !element.isDone).toList();
  // }

  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Logger().i(
        "Load Task Fuction running containes key: ${prefs.containsKey(UtilStirngs.taskKey)}");
    try {
      if (prefs.containsKey(UtilStirngs.taskKey)) {
        String? strList = prefs.getString(UtilStirngs.taskKey) ?? "[]";
        Logger().i("STRLIS in load tasks: $strList");
        List<dynamic> strl = jsonDecode(strList);

        tasks = strl.map(
          (e) {
            return Task.fromJson(jsonDecode(e));
          },
        ).toList();
        // getIncompleteTasks();
        notifyListeners();
      }
    } catch (e) {
      Logger().e("Some Eror occured while loading tasks: $e");
    }
  }

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> strList = tasks
        .map(
          (item) => jsonEncode(
            item.toJson(),
          ),
        )
        .toList();
    prefs.setString(UtilStirngs.taskKey, jsonEncode(strList));
    // getIncompleteTasks();
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
    Logger().i("Toggle task done");
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
