import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/task_config.dart';
import 'package:to_do_app/providers/task_provider.dart';
import 'package:to_do_app/screens/detail/detail.dart';
import 'package:to_do_app/screens/home/widgets/task_form.dart';

class Tasks extends StatefulWidget {
   const Tasks({super.key,});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
final configurations = TaskConfig.setTaskConfig().configuration;
  
@override
void initState(){
  super.initState();
}
  @override
  Widget build(BuildContext context) {
  Provider.of<TaskProvider>(context,listen: false).refreshList();
 
    return Consumer <TaskProvider>(
      builder: (context, value, child) {
      return  GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
        children: [
             _buildAddTask(context),
          ...value.taskList.map((task) => LongPressDraggable(
            delay: const Duration(milliseconds: 300),
            data: task,
            maxSimultaneousDrags: 1,
            onDragStarted: () {
            Provider.of<TaskProvider>(context,listen: false).changeDeleting(true);
          
            },
            onDraggableCanceled: (velocity, offset) {
           Provider.of<TaskProvider>(context,listen: false).changeDeleting(false);
        
            },
            onDragEnd: (details) {
            Provider.of<TaskProvider>(context,listen: false).changeDeleting(false);
            },
            feedback: SizedBox(
              width: 205,
              height: 205,
              child: Opacity(
                opacity: 0.6,
                child: _buildTask(context, task)),
            ),
            childWhenDragging: Opacity(opacity: 0.2,child: _buildTask(context, task)),
            child: _buildTask(context, task))),
      
        ],
        );
      },
      
    );
    
  }

 Widget _buildAddTask(BuildContext context) {
  return  Card(
    elevation: 1,
    margin: const EdgeInsets.all(10),
    child: InkWell(
        onTap: () {
       _buildForm(context);
        },
    child: DottedBorder(
    radius: const Radius.circular(10),
     borderType: BorderType.RRect,
     dashPattern: const [10,10],
     color: Colors.grey,
     child:  Center(
      child: Icon(Icons.add,
      size: 25,
      color: Colors.grey[600],
      )
     ),
    ) ,
    ),
  );
 }

  Widget _buildTask(BuildContext context, Task task) {
    final selectedConfig = configurations!.firstWhere((element) => element['key']== task.title);
     final watchDetail = context.watch<TaskProvider>().details.where((element) => element.taskHeaderId == task.id).toList();
     

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (context)=> DetailPage(task: task)));
      },
      child: Card(
        elevation: 1,
      color: selectedConfig['bgColor'],
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Icon(selectedConfig['iconData'],
            color: selectedConfig['iconColor'],
            size: 40,
            ),
          ),
          Column(
            children: [
              Text(selectedConfig['title'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  _buildTaskStatus(selectedConfig["iconColor"], Colors.white,  '${watchDetail.where((element) => element.completed ==1).length}'),
                    const SizedBox(width: 5),
                     _buildTaskStatus(Colors.white70, selectedConfig["iconColor"],  '${watchDetail.where((element) => element.completed ==0).length}'),
                  ],
                ),
              )

            ],
            
          )
        ],
      ),
      )  
    );

  }

  Widget _buildTaskStatus(Color bgColor, Color txtColor, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10)
      ),
      child: Text(text,
      style: TextStyle(
        color: txtColor,
        fontSize: 14
      ),
      ),

    ); 
  
  }
   Future<void> _buildForm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return  const TaskForm();
      }
    );
  }

  
  

}