import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/model.dart';
import '../../../../core/storage.dart';
import '../../../../utils/components/app_route.dart';
import '../../../../utils/components/app_snackbar.dart';

part 'to_do_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  ToDoCubit() : super(ToDoState(todoItems: [], todoList: [], query: ''));

  void initializeList(List<ListDetails> todoList) {
    emit(state.copyWith(todoList: todoList));
  }

  void initializeItem() {
    if (state.todoItems.isEmpty) {
      addNewTodoItem();
    }
  }

  void initializeQuery(String query) {
    emit(state.copyWith(query: query));
  }

  void addNewTodoItem() {
    final todoItems = state.todoItems;
    final newTodo = TodoItem(
      todoController: TextEditingController(),
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    emit(state.copyWith(todoItems: [...todoItems, newTodo]));
  }

  void removeTodoItem(String id) {
    final todoItems = state.todoItems;

    if (todoItems.length > 1) {
      final toDeleteItem = todoItems.firstWhere((todo) => todo.id == id);
      toDeleteItem.todoController.dispose();
      todoItems.removeWhere((todo) => todo.id == toDeleteItem.id);
      final updatedTodo = List<TodoItem>.from(todoItems);
      emit(state.copyWith(todoItems: updatedTodo));
    }
  }

  void dispose() {
    final todoItems = state.todoItems;
    for (var items in todoItems) {
      items.todoController.dispose();
    }
    emit(state.copyWith(todoItems: []));
  }

  void toggleTodoCompletion(int taskId, String todoId) async {
    final updatedList = state.todoList.map((task) {
      if (task.dateTime == taskId) {
        final updatedTodos = task.todoItems.map((todo) {
          if (todo.id == todoId) {
            AppSnackBar.showMessage(
              navigatorKey.currentState!.context,
              !todo.completed
                  ? 'You\'ve completed ${todo.todoController.text}.'
                  : '${todo.todoController.text} is still active',
            );
            return todo.copyWith(completed: !todo.completed);
          }
          return todo;
        }).toList();

        return task.copyWith(todoItems: updatedTodos);
      }
      return task;
    }).toList();

    emit(state.copyWith(todoList: updatedList));
    _saveToLocalStorage(updatedList);
  }

  void deleteTodo(int taskId, String todoId) {
    final currentTasks = List<ListDetails>.from(state.filteredList);

    final taskIndex = currentTasks.indexWhere((t) => t.dateTime == taskId);

    if (taskIndex != -1) {
      final task = currentTasks[taskIndex];

      final updatedTodos = task.todoItems
          .where((todo) => todo.id != todoId)
          .toList();

      if (updatedTodos.isEmpty) {
        currentTasks.removeAt(taskIndex);
        navigatorKey.currentState!.context.pop();
        AppSnackBar.showMessage(
          navigatorKey.currentState!.context,
          'List has been emptied and closed.',
        );
      } else {
        currentTasks[taskIndex] = task.copyWith(todoItems: updatedTodos);
        AppSnackBar.showMessage(
          navigatorKey.currentState!.context,
          'Task removed from list successfully.',
        );
      }

      emit(state.copyWith(todoList: currentTasks));
      _saveToLocalStorage(currentTasks);
    }
  }

  Future<void> updateListLocally({
    int? id,
    required ListDetails listDetails,
  }) async {
    final savedList = LocalStorage.readObjectList(
      'to-do-list',
      (map) => ListDetails.fromJson(map),
    );

    List<ListDetails> updatedList;
    final existingIndex = savedList.indexWhere((item) => item.dateTime == id);

    if (existingIndex != -1) {
      updatedList = [...savedList];
      updatedList[existingIndex] = listDetails;
    } else {
      updatedList = [...savedList, listDetails];
    }

    await LocalStorage.writeObjectList('to-do-list', updatedList);

    final todoList = LocalStorage.readObjectList(
      'to-do-list',
      (map) => ListDetails.fromJson(map),
    );

    // final savedList = LocalStorage.readObjectList(
    //   'to-do-list',
    //   (map) => ListDetails.fromJson(map),
    // );
    //
    // final updatedList = savedList.map((item) {
    //   if (item.dateTime == id) {
    //     return item.copyWith(todoItems: state.todoItems);
    //   }
    //   return item;
    // }).toList();

    _saveToLocalStorage(todoList);
    initializeList(todoList);
  }
}

void _saveToLocalStorage(List<ListDetails> tasks) async {
  await LocalStorage.writeObjectList('to-do-list', tasks);
}
