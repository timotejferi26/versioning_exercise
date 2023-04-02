import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:versioning_exercise/models/task_model.dart';

import '../services/local_storage_service.dart';

part 'task_list_provider.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  FutureOr<List<Task>> build() async {
    const AsyncLoading();
    return await _init();
  }

  StorageService storageService = StorageService();

  Future<List<Task>> _init() async {
    if (await storageService.containsKeyInSecureData("tasks")) {
      String? tasksJson = await storageService.readSecureData("tasks");
      final List<dynamic> parsedList = jsonDecode(tasksJson!);
      return parsedList.map((dynamic json) => Task.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> addTask(String name, String description) async {
    const AsyncLoading();
    List<Task> tasks = state.value!;
    tasks.add(Task.newTask(name, description));
    await storageService.writeSecureData(StorageItem("tasks", jsonEncode(tasks)));
    state = AsyncData(tasks);
  }

  Future<void> switchCompleted(String id) async {
    const AsyncLoading();
    List<Task> tasks = state.value!;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].id == id) {
        if (tasks[i].completed) {
          tasks[i] = tasks[i].copyWith(completed: false);
        } else {
          tasks[i] = tasks[i].copyWith(completed: true);
        }
      }
    }
    await storageService.writeSecureData(StorageItem("tasks", jsonEncode(tasks)));
    state = AsyncData(tasks);
  }
}