import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milk_tracker/database/objectbox.dart';
import 'package:milk_tracker/view_models/settings_view_model.dart';

import '../models/milk.dart';
import '../models/monthly_record.dart';

class HomePageViewModel extends GetxController{
  RxInt currentIndex = 0.obs;
  RxBool download = false.obs;
  final ObjectBox objectBox;
  List<Milk> allDataOfMonth = [];
  List<Milk> allData = [];
  RxDouble totalAmount = 0.0.obs;
  RxDouble totalMilk = 0.0.obs;
  RxList<MonthlySummary> monthlySummaries = <MonthlySummary>[].obs;
  HomePageViewModel({required this.objectBox});
  void showDownloadIcon(){
    download.value = true;
  }
  @override
  void onInit(){
    super.onInit();
    totalPrice();
  }

  Future<void> totalPrice() async {
    try {
      totalAmount.value = 0.0;
      totalMilk.value = 0.0;
      allData = [];
      allDataOfMonth = [];

      DateTime currentDate = DateTime.now();
      int currentMonth = currentDate.month;
      int currentYear = currentDate.year;
      await objectBox.getAllRecord().listen((data) {
        allData.assignAll(data);
        calculateMonthlySummaries(); double tempAmount = 0.0;
        double tempMilk = 0.0;
        allDataOfMonth.clear();

        for (var data in allData) {
          List<String> dateComponents = data.date!.split('-');
          String monthName = dateComponents[1];
          int dataYear = int.tryParse(dateComponents[2]) ?? 0;
          if (currentMonth == getMonthNumber(monthName) && currentYear == dataYear) {
            allDataOfMonth.add(data);

            tempMilk += (data.morningMilk + data.eveningMilk);
            tempAmount += (data.pricePerLiter * (data.morningMilk + data.eveningMilk));
          }
        }

        totalAmount.value = tempAmount;
        totalMilk.value = tempMilk;
      });

    } catch (e) {
      print("error");
      throw Exception("Error 32:${e.toString()}");
    }
  }
  int getMonthNumber(String month){
    int number = 0;
    month == "Jan" ? number = 1:
    month == "Feb" ? number = 2:
    month == "Mar" ? number = 3:
    month == "Apr" ? number = 4:
    month == "May" ? number = 5:
    month == "Jun" ? number = 6:
    month == "Jul" ? number = 7:
    month == "Aug" ? number = 8:
    month == "Sep" ? number = 9:
    month == "Oct" ? number = 10:
    month == "Nov" ? number = 11:
    month == "Dec" ? number = 12:
    0;
    return number;
  }
  void calculateMonthlySummaries() {
    Map<String, MonthlySummary> summaryMap = {};

    for (var record in allData) {
      List<String> parts = record.date!.split('-');
      if (parts.length > 2) {
        String monthYearKey = "${parts[1]}-${parts[2]}";

        if (!summaryMap.containsKey(monthYearKey)) {
          summaryMap[monthYearKey] = MonthlySummary(monthYearKey, 0, 0);
        }

        int dailyTotalMilk = record.morningMilk + record.eveningMilk;
        int dailyCost = dailyTotalMilk * record.pricePerLiter;

        summaryMap[monthYearKey]!.totalMilk += dailyTotalMilk;
        summaryMap[monthYearKey]!.totalCost += dailyCost;
      }
    }

    monthlySummaries.assignAll(summaryMap.values.toList());
  }
  Future<void> updateMonthPrice(String monthYear, int newPrice) async {
    List<Milk> allRecords = await objectBox.getAllRecordAtOnce();

    for (var record in allRecords) {
      List<String> parts = record.date!.split('-');
      String recordMonthYear = "${parts[1]}-${parts[2]}";
      if (recordMonthYear == monthYear) {
        record.pricePerLiter = newPrice;
        objectBox.addData(record);
      }
    }

    totalPrice();
    Get.back();
    Get.snackbar("Success", "$monthYear price updated to $newPrice");
  }
}