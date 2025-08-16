import 'package:Dooit/features/core/storage.dart';
import 'package:flutter/cupertino.dart';

class TodoItem extends BaseModel {
  final bool completed;
  final String id;
  final TextEditingController todoController;

  TodoItem({
    required this.todoController,
    required this.id,
    this.completed = false,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
    completed: json["completed"],
    id: json["id"],
    todoController: TextEditingController(text: json["text"]),
  );

  TodoItem copyWith({
    bool? completed,
    String? id,
    TextEditingController? todoController,
  }) {
    return TodoItem(
      completed: completed ?? this.completed,
      id: id ?? this.id,
      todoController: todoController ?? this.todoController,
    );
  }

  @override
  Map toJson() {
    return {
      'completed': completed,
      'id': id,
      'text': todoController.text.trim(),
    };
  }
}

class ListDetails extends BaseModel {
  final String title;
  final List<TodoItem> todoItems;
  final String label;
  final bool isPinned;
  final int dateTime;

  // final String cardColor;

  ListDetails({
    required this.title,
    required this.todoItems,
    required this.label,
    required this.isPinned,
    required this.dateTime,
    // required this.cardColor,
  });

  ListDetails copyWith({
    String? title,
    List<TodoItem>? todoItems,
    String? label,
    bool? isPinned,
    int? dateTime,
  }) => ListDetails(
    title: title ?? this.title,
    todoItems: todoItems ?? this.todoItems,
    label: label ?? this.label,
    isPinned: isPinned ?? this.isPinned,
    dateTime: dateTime ?? this.dateTime,
  );

  factory ListDetails.fromJson(Map<String, dynamic> json) => ListDetails(
    title: json["title"],
    todoItems: List<TodoItem>.from(
      json["todoItems"].map((x) => TodoItem.fromJson(x)),
    ),
    label: json["label"],
    isPinned: json["isPinned"],
    dateTime: json["dateTime"],
    // cardColor: json["cardColor"],
  );

  @override
  Map toJson() {
    return {
      'title': title,
      'todoItems': todoItems,
      'label': label,
      'isPinned': isPinned,
      'dateTime': dateTime,
      // 'cardColor': cardColor.toString(),
    };
  }
}
