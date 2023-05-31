
class Task{
  final int? id;
  final String title;

  /* List<Detail>? detail; */
  Task({ required this.title,
  this.id
  });

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
    id: json["id"],
    title: json["title"],
    );
  }
  Map<String,dynamic> toMap(){ // used when inserting data to the database
    return <String,dynamic>{
      "id" : id,
      "title" : title,
    };
    
    }
}