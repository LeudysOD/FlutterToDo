import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/providers/task_provider.dart';
import 'package:to_do_app/repository/task_repository.dart';
import 'package:to_do_app/screens/home/widgets/list_tile.dart';
import 'package:to_do_app/screens/home/widgets/tasks.dart';

import '../../../constants/colors.dart';
import '../../../models/task_config.dart';

class TaskForm extends StatefulWidget {
    const TaskForm({super.key});
  @override
  State<TaskForm> createState() => _MyTaskFormState();
  
}

class _MyTaskFormState extends State<TaskForm> {
  String _value = 'personal';
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: const Center(
      child: Text('New Task',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal
      ),
      )),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
            ListTile(
              onTap: () {
              setState(() {
              _value = 'personal';
            });
            },
        title: Row(
          children: const  [
            Icon(Icons.person_rounded,
            color: kYellowDark,
            ),
            SizedBox(width: 8),
            Text('Personal'),
          ],
        ),
        leading: Radio(
          value: 'personal',
          groupValue: _value,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
      ),
      ListTile(
        onTap:(){
          setState(() {
              _value = 'work';
            });
        } ,
        title: Row(
          children: const [
            Icon(Icons.work_rounded,
            color: kRedDark,
            ),
            SizedBox(width: 8),
            Text('Work'),
          ],
        ),
        leading: Radio(
          value: 'work',
          groupValue: _value,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
      ),
      ListTile(
        onTap:(){
          setState(() {
              _value = 'bussiness';
            });
        } ,
        title: Row(
          children:  const [
            Icon(Icons.business_rounded,
            color: kOrangeDark,
            ),
            SizedBox(width: 8),
             Text('Bussiness'),
          ],
        ),
        leading: Radio(
          value: 'bussiness',
          groupValue: _value,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
      ),
      ListTile(
        onTap:(){
          setState(() {
              _value = 'healt';
            });
        } ,
        title: Row(
          children: const  [
            Icon(Icons.favorite_rounded,
            color: kGreenDark,
            ),
            SizedBox(width: 8),
            Text('Health')
          ],
        ),
        leading: Radio(
          value: 'healt',
          groupValue: _value,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
      ),
      ListTile(
        onTap:(){
          setState(() {
              _value = 'sport';
            });
        } ,
        title: Row(
          children: const  [
            Icon(Icons.sports_basketball_rounded,
            color: kBlueDark,
            ),
            SizedBox(width: 8),
            Text('Sport')
          ],
        ),
        leading: Radio(
          value: 'sport',
          groupValue: _value,
          activeColor: Colors.blue,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
      ),
          ],


        ),
        actions: 
        [

          OutlinedButton(
            style: OutlinedButton.styleFrom(backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)
            )
            ),
            child: const Text('Cancel',
            style: TextStyle(
              color: Colors.redAccent
            ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
           OutlinedButton(
            style: OutlinedButton.styleFrom(backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18)
            )
            ),
            
            child: const Text('Save',
            style: TextStyle(
              color: Colors.blueAccent
            ),
            ),
            onPressed: (){
              final newTask = Task(title: _value);
             createTask(newTask);

            },
          ),
        ],
    );

    }

    void createTask(Task task){
      TaskRespository.createItem(task);
      Provider.of<TaskProvider>(context,listen: false).refreshList();
      Navigator.of(context).pop();
    }
    
  }
