import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

var uuid = const Uuid();

@freezed
class Task with _$Task {
  const factory Task({
    @Default('') String id,
    required String name,
    required String description,
    @Default(false) bool completed,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.newTask(String name, String description) => Task(
    id: const Uuid().v1(),
    name: name,
    description: description,
  );
}