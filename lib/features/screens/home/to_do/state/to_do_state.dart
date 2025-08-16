part of 'to_do_cubit.dart';

class ToDoState extends Equatable {
  final List<TodoItem> todoItems;
  final List<ListDetails> todoList;
  final String query;

  List<ListDetails> get pinnedList =>
      todoList.where((todo) => todo.isPinned == true).toList();

  List<ListDetails> get filteredList => todoList.where((todo) {
    final searchQuery = query.toLowerCase().trim();

    final titleMatch = todo.title.toLowerCase().trim().contains(searchQuery);

    final todoItemsMatch = todo.todoItems.any(
      (item) =>
          item.todoController.text.toLowerCase().trim().contains(searchQuery),
    );

    final labelMatch = todo.label.toLowerCase().trim().contains(searchQuery);

    return titleMatch || todoItemsMatch || labelMatch;
  }).toList();

  const ToDoState({
    required this.todoItems,
    required this.todoList,
    required this.query,
  });

  ToDoState copyWith({
    List<TodoItem>? todoItems,
    List<ListDetails>? todoList,
    String? query,
  }) => ToDoState(
    todoItems: todoItems ?? this.todoItems,
    todoList: todoList ?? this.todoList,
    query: query ?? this.query,
  );

  @override
  List<Object?> get props => [todoItems, todoList, query];
}
