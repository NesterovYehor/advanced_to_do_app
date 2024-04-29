import 'package:advanced_to_do_app/db/db_healper.dart';
import 'package:advanced_to_do_app/models/tesk_model.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async{
    return await DBHealper.insert(task);
  }

  void getTasks() async{
    List<Map<String, dynamic>> tasks = await DBHealper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task){
    DBHealper.delete(task);
    getTasks();
  }
  void markTaskCompleted(int id) async{
    await DBHealper.update(id);
    getTasks();
  }
}