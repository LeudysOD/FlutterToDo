import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Detail{
  int? id;
  int? taskHeaderId;
  String? detailTitle;
  String description;
  String? initDate;
  String? initHour;
  int completed;

Detail({this.id,required this.description,required this.taskHeaderId,required this.initDate,required this.initHour, required this.completed, this.detailTitle});

factory Detail.fromJson(Map<String, dynamic> json){
    return Detail(
    id: json["id"],
    taskHeaderId: json["taskHeaderId"],
    detailTitle: json["detailTitle"],
    description:json["description"],
    initDate: json["initDate"],
    initHour: json["initHour"],
    completed: json["completed"],
    );
  }
Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "taskHeaderId" : taskHeaderId,
      "description":description,
      'initDate': initDate,
      "initHour":initHour,
      'completed':completed
    };
    
    }
}