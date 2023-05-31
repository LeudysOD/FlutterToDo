import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/detail_provider.dart';
import 'package:to_do_app/providers/task_provider.dart';
import 'package:to_do_app/repository/detail_repository.dart';
import '../../../models/detail.dart';
import '../../../models/task.dart';

class DetailForm extends StatefulWidget {
  final Task task;
  const DetailForm({super.key,required this.task});

  @override
  State<DetailForm> createState() => _DetailFormState();
}


  class _DetailFormState extends State<DetailForm> {
  final initDateController = TextEditingController();
  final initHourController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (
     AlertDialog(
      contentPadding: EdgeInsets.all(10),
      insetPadding:  EdgeInsets.zero ,
      title: const Center(
        child:Text('New Task ToDo',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500
        ),
        )),
        titlePadding: const EdgeInsets.all(25),
      content: SizedBox(
        width: MediaQuery.of(context).size.width-100,
        child: Form(
          child: SingleChildScrollView(
            child:Column(
          children: [
              TextField(
                controller: initDateController,
                decoration: const InputDecoration(
                  filled: true,
    
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  hintText: "Task title",
                  labelText: 'Start date',
                ),
              readOnly: true,
              onTap: () async {
                  DateTime? startPickedDate = await showDatePicker(context: context,
                   initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                     lastDate: DateTime(2101));

                    if(startPickedDate != null ){
                        String formattedDate = DateFormat('yyyy-MM-dd').format(startPickedDate); 
                        initDateController.text = formattedDate;

                    }
                  }
             ),
            const SizedBox(height: 15),

              TextField(
                controller: initHourController,
                readOnly: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  labelText: 'Finish date',
                 floatingLabelBehavior: FloatingLabelBehavior.auto,
                 suffixIcon: Icon(Icons.calendar_month_rounded,color: Colors.blue,)
                ),
              onTap: () async {
                  DateTime? finsihPickedDate = await showDatePicker(context: context,
                   initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                     lastDate: DateTime(2101));
                     
                  
                     if(finsihPickedDate != null ){
      
                        String formattedDate = DateFormat('yyyy-MM-dd').format(finsihPickedDate);
                        setState(() {
                           initHourController.text = formattedDate; 
                        });
              }
                }
  ),
             const SizedBox(height: 15),

               TextField(
                controller: descriptionController,
                scrollPadding: const EdgeInsets.all(10),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: (BorderRadius.all(Radius.circular(10)))
                  ),
                 labelText: 'Description',
                 floatingLabelBehavior: FloatingLabelBehavior.auto,
                 suffixIcon: Icon(Icons.description_rounded,color: Colors.blue,)
                ),maxLines: 2,
                autocorrect: true,
                maxLength: 25,
              )
                ],
          ),  
          )

        ),
      ) ,
      actions: [
        TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.white,
            ),
            child: const Text('Cancel',
            style: TextStyle(
              color: Colors.redAccent
            ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
           TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.white,
            ),
            child: const Text('Save',
            style: TextStyle(
              color: Colors.blueAccent
            ),
            ),
            onPressed: () {
            var newDetail = Detail(
            taskHeaderId: widget.task.id,
            description: descriptionController.text, 
            initDate: initDateController.text ,
            initHour: initHourController.text,
            completed: 0
            );
     
            print(newDetail);
            createDetail(newDetail);
            }
          ),
      ],
    ));
    
  }

  void createDetail(Detail detail) {
    DetailRepository.createDetail(detail);
    Provider.of<DetailProvider>(context,listen: false).refreshList();
    Provider.of<TaskProvider>(context,listen:false).refreshList();
    Navigator.of(context).pop();
  }

}

