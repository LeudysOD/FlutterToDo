import 'package:flutter/cupertino.dart';
import 'package:to_do_app/models/detail.dart';
import 'package:to_do_app/repository/detail_repository.dart';

class DetailProvider extends ChangeNotifier{

List<Detail> detailList= [];

void refreshList() async{
  detailList = await DetailRepository.getAllDetails();
 notifyListeners();
}

}