import 'package:flutter/cupertino.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/repository/detail_repository.dart';

import '../models/detail.dart';
import '../repository/task_repository.dart';

class TaskProvider extends ChangeNotifier{

List<Task> taskList= [];
 List<Detail> details = [];
bool _deleting = false;

bool get deleting => _deleting;
List<Task> get getTaskList {
    return taskList;
  }


 void refreshList() async{
  taskList = await TaskRespository.getAllTask();
  details = await DetailRepository.getAllDetails();
  notifyListeners();
}

Future<void> changeDeleting(bool value) async {
   _deleting = value;
   notifyListeners();
  }
   getStateFromDel(){
   return deleting;
  }

}