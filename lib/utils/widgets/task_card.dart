import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/task_provider.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final int index;
  const TaskCard({
    super.key,
    required this.index,
    required this.task,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final player = AudioPlayer();

  String _getDateTimeInFormat(DateTime date) {
    if (date.hour < 12) {
      return "${date.day}/${date.month}/${date.year} • ${date.hour}:${date.minute} AM";
    } else {
      return "${date.day}/${date.month}/${date.year} • ${date.hour % 13 + 1}:${date.minute} PM";
    }
  }

  Color _getColor() {
    return widget.task.isDone
        ? Colors.grey
        : widget.task.priority == TaskPriority.low
            ? Colors.green
            : widget.task.priority == TaskPriority.medium
                ? Colors.amber
                : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, useTaskProvider, child) => Container(
        padding: const EdgeInsets.all(10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.05,
                height: MediaQuery.of(context).size.width * 0.05,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: _getColor(),
                  border: Border.all(
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: _getColor().withOpacity(.2),
                    width: 5,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.black12, width: .5),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 4,
                        blurRadius: 40,
                        color: Colors.grey.shade200,
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7 - 20,
                          child: Text(
                            widget.task.title.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black87,
                              decoration: widget.task.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(
                      widget.task.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        // color: Colors.black54,
                        color: Colors.blueGrey,
                        decoration: widget.task.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _getDateTimeInFormat(widget.task.createdAt),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        decoration: widget.task.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    const Divider(),
                    Container(
                      height: 30,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              useTaskProvider.toggleTaskDone(widget.index);
                            },
                            child: Icon(
                              widget.task.isDone ? Icons.refresh : Icons.check,
                              color: Colors.amber,
                              size: 25,
                            ),
                          ),
                          const VerticalDivider(),
                          GestureDetector(
                            onTap: () {
                              useTaskProvider.removeTask(widget.index);
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
