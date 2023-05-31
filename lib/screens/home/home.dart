
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/providers/task_provider.dart';
import 'package:to_do_app/repository/detail_repository.dart';
import 'package:to_do_app/screens/home/widgets/task_form.dart';
import 'package:to_do_app/screens/home/widgets/tasks.dart';
import '../../repository/task_repository.dart';

class HomePage extends StatefulWidget  {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {
  @override
  Widget build(BuildContext context) {
  TaskProvider watch = context.watch<TaskProvider>();

    return Scaffold(
     appBar: _buildAppBar(),
      body:SafeArea(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
          Padding(
              padding:EdgeInsets.all(30),
              child: Text('My Tasks',
              style: TextStyle(
                fontSize: 24.4,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
              Expanded(child: Tasks())
          ],
        )
                 
   ),
    bottomNavigationBar:
     _buildBottomNavigationBar(),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: DragTarget<Task>(
      onAccept: (data) {
        deleteTask(context,data);
      },
      builder: (_, __, ___) {
        return FloatingActionButton(
        elevation: 1,
        backgroundColor:  watch.deleting ?Colors.red:Colors.blue,
        
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
        ) ,
        onPressed: (){
          _buildForm(context);
        },
        child: watch.deleting ?  SlideInUp( 
          duration: const Duration(
            milliseconds: 200
          ),
        child: const Icon(Icons.delete
        ))
          :SlideInDown(
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.add))
          
      );
      },
       
    ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
       backgroundColor: const Color.fromARGB(255, 14, 131, 228),
      elevation: 0,
      title: Row(children: [
        Container(
          width: 45,
          margin: const EdgeInsets.only(left: 15),
          child: ClipRRect(
            child: Image.asset('assets/images/hacker.png'),
          ),
        ),
        const SizedBox(width: 10),
       const Text("Hi, Leudys!",
       style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
       ),
       )
      ]),
      actions: const [
        Icon(
          Icons.more_vert,
          color: Colors.white,
          size: 40,
        )
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration:  BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10
          )
        ]
      ),
      child:  BottomNavigationBar(
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home'
             ),
             BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
             label: 'Person'
             )
        ]
        ));
  }

 Future<void> _buildForm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return  const TaskForm();
      }
    );
  }

    void deleteTask(BuildContext context, Task task){
      TaskRespository.deleteItem(task.id!);
      DetailRepository.deleteByTaskId(task.id!);
      Provider.of<TaskProvider>(context,listen: false).refreshList();
    }
}