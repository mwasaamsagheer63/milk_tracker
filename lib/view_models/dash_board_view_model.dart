import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milk_tracker/database/objectbox.dart';
import 'package:milk_tracker/view_models/settings_view_model.dart';

import '../models/milk.dart';
import 'history_view_model.dart';

class DashBoardViewModel extends GetxController{
  SettingsViewModel settingsViewModel = Get.find();
  void onInit(){
    super.onInit();
    settingsViewModel.loadGoal();
    print("loadGoal is called in dashboardViewModel");
  }


void storeData(ObjectBox objectBox,String morningQuantity,String eveningQuantity,{bool morning = false, bool evening = false}){
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MMM-yyyy').format(now);
  Milk? storedMilk = objectBox.getMilkByDate(formattedDate);
  Milk milk = storedMilk;
  milk.date = formattedDate;
  milk.pricePerLiter = settingsViewModel.savedPrice.value;
  try{
    if(morning){
      milk.morningMilk = int.tryParse(morningQuantity)??0;
    }
    if(evening){
      milk.eveningMilk = int.tryParse(eveningQuantity)??0;
    }
    objectBox.addData(milk);
    Get.snackbar("Success", "Data is stored");
    settingsViewModel.loadGoal();
    if (Get.isRegistered<HistoryViewModel>()) {
      Get.find<HistoryViewModel>().loadData();
    }
  }
  catch (e){
    throw Exception("Error : ${e.toString()}");
  }
}
String date(){
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MMM-yyyy').format(now);
  return formattedDate;
}





}