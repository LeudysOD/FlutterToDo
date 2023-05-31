import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';

class TaskConfig{

List<Map<String,dynamic>>? configuration;
TaskConfig({this.configuration});

static TaskConfig setTaskConfig(){
  return TaskConfig(
    configuration: [
      {
      'key': 'personal',
      'title':'Personal',
      'iconData': Icons.person_rounded,
      'bgColor':kYellowLight,
      'iconColor':kYellowDark,
      'btnColor': kYellow,
    
      },
      {
      'key': 'work',
      'title': 'Work',
      'iconData':Icons.cases_rounded,
      'bgColor': kRedLight,
      'iconColor': kRedDark,
      'btnColor': kRed,
      },
      {
      'key': 'healt',
      'title': 'Healt',
      'iconData':Icons.favorite_rounded,
      'bgColor': kGreenLight,
      'iconColor': kGreenDark,
      'btnColor': kGreen,
      },
      {
      'key': 'bussiness',
      'title': 'Bussiness',
      'iconData': Icons.business_rounded,
      'bgColor':kOrangeLight,
      'iconColor':kOrangeDark,
      'btnColor': kOrange
      },
      {
      'key': 'sport',
      'title': 'Sport',
      'iconData': Icons.sports_basketball_rounded,
      'bgColor':kBlueLight,
      'iconColor':kBlueDark,
      'btnColor':kBlue
      }
    ]
  );
}
}

