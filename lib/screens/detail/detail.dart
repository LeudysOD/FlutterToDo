import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/detail_provider.dart';
import 'package:to_do_app/screens/detail/widgets/detail_form.dart';
import 'package:to_do_app/screens/detail/widgets/task_timeline.dart';
import 'package:to_do_app/screens/detail/widgets/task_title.dart';
import '../../models/detail.dart';
import '../../models/task.dart';
import '../../models/task_config.dart';
import '../../repository/detail_repository.dart';

class DetailPage extends StatefulWidget {
final Task task;
const DetailPage({super.key,required this.task });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final configuration = TaskConfig.setTaskConfig().configuration;


@override
void initState(){
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    Provider.of<DetailProvider>(context,listen: false).refreshList();
    return  SafeArea(
      child:Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<DetailProvider>(
        builder: ((context, value, child) {
          final detailResult =  value.detailList.where((element) => element.taskHeaderId==widget.task.id);

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(context),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TaskTitle()
                ],
              ),
            ),
            detailResult.isEmpty  ?
            SliverFillRemaining(
            child:Container(
            color: Colors.white,
            child: Column(            
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              GestureDetector(
                onTap: () {
              _buildDetailForm(context);
              },
                child:
            Image.asset('assets/images/task-list.png',
            width: 100,
            )),
               const SizedBox(height: 20),
               Text('Add a new task',
                style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                ),
                ),
                ]
              ),
              )
            )
            :
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_ , index) =>  
                TaskTimeline(
                  detailResult.toList()[index].toMap(),
                widget.task.title
                ),
                childCount: detailResult.length
                )
              ),
          ],
        );
          }),
      ),
     floatingActionButton:FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        _buildDetailForm(context);
      },
     )
    )
    );
  }

  _buildAppBar(BuildContext context) {
     final selectedConfig = configuration!.firstWhere((element) => element['key']== widget.task.title);
    return SliverAppBar(
      expandedHeight: 100,
      backgroundColor:const Color.fromARGB(255, 14, 131, 228),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
        iconSize: 20,
      ),
      actions: const [
        Icon(
          Icons.more_vert,
          color: Colors.white,
          size: 40,
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${selectedConfig["title"]} tasks',
            style: const TextStyle(
              fontWeight: FontWeight.bold
            )
            ),
          ],
        ),
      ),
    );

  }

  Future<void> _buildDetailForm(BuildContext context) {

    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return DetailForm(
          task: widget.task);
      }
    );
  }
}