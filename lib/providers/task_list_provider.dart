import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:versioning_exercise/models/task_model.dart';

part 'task_list_provider.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  FutureOr<List<Task>> build() async {
    const AsyncLoading();
    return await _init();
  }

  Future<List<Task>> _init() async {
    List<Task> list = [];
    return list;
  }
}