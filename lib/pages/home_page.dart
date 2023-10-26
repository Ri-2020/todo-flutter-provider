import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/task.dart';
import 'package:todo/pages/add_task_modal_sheet.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/utils/widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  void _showAddTaskBottomModalSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: const BoxConstraints(
        maxHeight: 550,
      ),
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTaskModalBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddTaskBottomModalSheet();
          },
          backgroundColor: Colors.amber,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        appBar: AppBar(
          title: const Text(
            "You Todos",
          ),
          backgroundColor: Colors.amber,
          elevation: 0,
          foregroundColor: Colors.black87,
        ),
        body: SizedBox(
          width: double.infinity,
          child: taskProvider.tasks.isEmpty
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 30,
                    ),
                    margin: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 0),
                            spreadRadius: -3,
                            blurRadius: 10,
                            color: Color.fromARGB(255, 205, 205, 205),
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.task_alt_rounded,
                          size: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Task list is empty",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showAddTaskBottomModalSheet();
                          },
                          child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Add Task",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     SharedPreferences.getInstance().then((prefs) {
                    //       prefs.clear();
                    //     });
                    //   },
                    //   child: Container(
                    //     padding:
                    //         const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    //     decoration: const BoxDecoration(
                    //       border: Border(
                    //         bottom: BorderSide(
                    //           width: 1,
                    //           color: Colors.grey,
                    //         ),
                    //       ),
                    //     ),
                    //     child: const Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           "Completed Tasks",
                    //           style: TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         ),
                    //         Icon(Icons.keyboard_arrow_right_sharp)
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => TaskCard(
                          index: taskProvider.tasks.length - index - 1,
                          task: taskProvider
                              .tasks[taskProvider.tasks.length - index - 1],
                        ),
                        // separatorBuilder: (context, index) => const Divider(),
                        itemCount: taskProvider.tasks.length,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
