import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milk_tracker/view_models/home_page_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/objectbox.dart';
import '../models/milk.dart';

class SettingsViewModel extends GetxController{
  final HomePageViewModel homePageViewModel= Get.find();

  final TextEditingController goal = TextEditingController();

  late ObjectBox objectBox;
  RxInt savedPrice = 0.obs;
  RxInt savedGoal = 0.obs;
   List<Milk> allData = [];
   RxInt  goalInPercentage = 0.obs;
   RxDouble  goalInDecimal = 0.0.obs;


   SettingsViewModel({required this.objectBox});


@override
  void onInit(){
  super.onInit();
  loadData();
  loadGoal();
}

Future<void> achivedGoal()async{
  Milk milk = objectBox.getMilkByDate(DateFormat("dd-MMM-yyyy").format(DateTime.now()));
  goalInDecimal.value=(milk.morningMilk+milk.eveningMilk)/savedGoal.value;
  goalInPercentage.value = (goalInDecimal.value*100).toInt();
}
Future<void> loadData()async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  savedPrice.value = preferences.getInt("price")??0;

}

Future<void> saveData(num price)async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("price", price as int);
    loadData();
updatePrice();
homePageViewModel.totalPrice();
    refresh();

  }

  Future<void> updatePrice() async {
    List<Milk> data = await objectBox.getAllRecordAtOnce();

    DateTime now = DateTime.now();
    String currentMonthYear = DateFormat('MMM-yyyy').format(now);

    for (var instance in data) {
     List<String> parts = instance.date!.split('-');
      String recordMonthYear = "${parts[1]}-${parts[2]}";

      if (recordMonthYear == currentMonthYear) {
        instance.pricePerLiter = savedPrice.value;
        objectBox.addData(instance);
      }
    }
  }

  Future<void> saveGoal(String goal) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setInt("goal", int.tryParse(goal)??0);
  loadGoal();
}

Future<void> loadGoal ()async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  savedGoal.value = sharedPreferences.getInt("goal")??0;
  goal.text = savedGoal.value.toString();
  print(savedGoal.value);
  print("loadGoal is called in setting view model");
  achivedGoal();

}
  Future<void> dataForTesting() async{
    for(int i = 1; i <= 31; i++){
      Milk milk = Milk.create(20, 30,DateFormat('dd-MMM-yyyy').format(DateTime(2025,7,i)) , 120);
      await objectBox.addData(milk);
      print("i values : $i");
    }
    for(int i = 1; i <= 31; i++){
      Milk milk = Milk.create(40, 50,DateFormat('dd-MMM-yyyy').format(DateTime(2025,8,i)) , 125);
      await objectBox.addData(milk);
    }
    for(int i = 1; i <= 20; i++){
      Milk milk = Milk.create(40, 50,DateFormat('dd-MMM-yyyy').format(DateTime(2025,9,i)) , 130);
      await objectBox.addData(milk);
    }
    print("Data is stored successfully");
  }



}