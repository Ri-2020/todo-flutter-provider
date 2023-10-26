class Task {
  String title;
  String description;
  DateTime createdAt;
  TaskPriority priority;
  bool isDone;

  Task({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.priority,
    required this.isDone,
  });

  factory Task.fromJson(Map<String, dynamic> task) {
    return Task(
      title: task['title'] ?? "",
      description: task['description'] ?? "",
      createdAt: DateTime.parse(task['createdAt'] ?? DateTime.now().toString()),
      priority: task['priority'] == 'low'
          ? TaskPriority.low
          : task['priority'] == 'medium'
              ? TaskPriority.medium
              : TaskPriority.high,
      isDone: task['isDone'] == "true",
    );
  }
  Map<String, String> toJson() => {
        "title": title,
        "description": description,
        "createdAt": createdAt.toString(),
        "priority": priority == TaskPriority.low
            ? "low"
            : priority == TaskPriority.medium
                ? "medium"
                : "high",
        "isDone": isDone ? "true" : "false",
      };
}

enum TaskPriority {
  low,
  medium,
  high,
}
