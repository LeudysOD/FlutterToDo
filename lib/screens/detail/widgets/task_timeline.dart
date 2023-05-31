import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:to_do_app/models/task_config.dart';
import 'package:to_do_app/providers/task_provider.dart';
import '../../../providers/detail_provider.dart';
import '../../../repository/detail_repository.dart';

class TaskTimeline extends StatelessWidget {
final Map<String,dynamic> detail;
final String title;
final configurations = TaskConfig.setTaskConfig().configuration;
   TaskTimeline(this.detail, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
final selectedConfig = configurations!.firstWhere((element) => element['key']== title);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      child: Row(
        children: [
          _buildTimeline(selectedConfig["iconColor"]),
        Expanded(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("8:00 am"),
                detail['description'].isNotEmpty ?
                _buildCard(selectedConfig["bgColor"],detail["description"],'${detail["creationDate"]} - ${detail["finishDate"]}',detail["id"],detail["completed"])
                : _buildCard(Colors.white, '', '',0,0)
              ],  
            ),
          ),
        ],    
      )
    );
  }
  
  Widget _buildTimeline(Color color) {
 return SizedBox(
  height: 80,
  width: 20,
  child: TimelineTile(
    alignment: TimelineAlign.manual,
    lineXY: 0,
    isFirst: true,
    indicatorStyle: IndicatorStyle(
      indicatorXY: 0,
      width: 15,
      indicator: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(width: 5 ,color: color)

        ),
      )
    ),
    afterLineStyle: LineStyle(
      thickness: 2,
      color: color
    ),
  ),
 );
  }
  
  _buildCard(Color bgColor,String title,String slot, int id, int completed) {
    
   
    return Slidable(
            endActionPane: ActionPane(motion: const ScrollMotion(),
            children: [
            completed==0 ? SlidableAction(borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.green,
            icon: Icons.done,
            onPressed: (context) {
              changeState(context ,id);
            }, 
          )
          : SlidableAction(borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.amber,
            icon: Icons.watch_later,
            foregroundColor:(Colors.white),
            onPressed: (context) {
              changeState(context ,id);
            }, 
          ),

          const SizedBox(width: 5),
           SlidableAction(borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (context) {
              deleteDetail(context, id);
            }, 
          ),
              ],
            ),
      child: Container(
          width: 250,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(
            Radius.circular(10)
            )
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
              children: [
              Text(title,
              style: const TextStyle(
              fontWeight: FontWeight.bold
              )),
              const SizedBox(width: 5),
              completed== 0 ? const Icon(Icons.watch_later, color:Colors.amberAccent) : const Icon(Icons.done)
              ],
              ),
              const SizedBox(height: 10),
              Text(slot,
              style: const TextStyle(
               color: Colors.grey
              ),
              )
            ],
          ),
      ),
      );
  }
   void deleteDetail(BuildContext context, int detailId){
      DetailRepository.deleteDetail(detailId);
      Provider.of<DetailProvider>(context,listen: false).refreshList();
      Provider.of<TaskProvider>(context,listen:false).refreshList();
    }

    void changeState (BuildContext context, int detailId) async{
    var detailToUpdate = await DetailRepository.getDetailById(detailId);
    detailToUpdate.completed ==0 ? detailToUpdate.completed = 1 : detailToUpdate.completed = 0;
    DetailRepository.updateDetail(detailId, detailToUpdate);
    Provider.of<DetailProvider>(context,listen: false).refreshList();
    Provider.of<TaskProvider>(context,listen:false).refreshList();
    }
}