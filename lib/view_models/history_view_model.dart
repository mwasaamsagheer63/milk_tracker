import 'dart:io';
import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milk_tracker/view_models/settings_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import '../database/objectbox.dart';
import '../models/milk.dart';
import '../objectbox.g.dart';

class HistoryViewModel extends GetxController {
  ObjectBox objectBox;
  HistoryViewModel({required this.objectBox});
  RxList<Milk> milkHistory = <Milk>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      List<Milk> realRecords = await objectBox.getAllRecordAtOnce();

      DateTime startDate;
      Map<String, Milk> recordMap = {};

      if (realRecords.isNotEmpty) {
        for (var record in realRecords) {
          recordMap[record.date!] = record;
        }

        realRecords.sort((a, b) {
          DateTime dateA = DateFormat('dd-MMM-yyyy').parse(a.date!);
          DateTime dateB = DateFormat('dd-MMM-yyyy').parse(b.date!);
          return dateA.compareTo(dateB);
        });

        startDate = DateFormat('dd-MMM-yyyy').parse(realRecords.first.date!);
      } else {
        DateTime now = DateTime.now();
        startDate = DateTime(now.year, now.month, 1);
      }

      DateTime endDate = DateTime.now();

      startDate = DateTime(startDate.year, startDate.month, startDate.day);
      endDate = DateTime(endDate.year, endDate.month, endDate.day);

      List<Milk> fullDisplayList = [];

      int currentPrice = 0;
      if (Get.isRegistered<SettingsViewModel>()) {
        currentPrice = Get.find<SettingsViewModel>().savedPrice.value;
      }

      for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
        DateTime loopDate = startDate.add(Duration(days: i));
        String dateString = DateFormat('dd-MMM-yyyy').format(loopDate);

        if (recordMap.containsKey(dateString)) {
          fullDisplayList.add(recordMap[dateString]!);
        } else {
          fullDisplayList.add(Milk.create(0, 0, dateString, currentPrice));
        }
      }

      fullDisplayList = fullDisplayList.toList();
      milkHistory.assignAll(fullDisplayList);

    } catch (e) {
      print("Error loading history: $e");
    }
  }

  Future<void> convertToCSV() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        Get.snackbar("Error", "Storage Permission is denied");
        return;
      }
    }

    List<Milk> records = milkHistory.toList();

    if(records.isEmpty){
      Get.snackbar("Alert", "No data to export");
      return;
    }

    List<List<dynamic>> rows = [];
    rows.add(["ID", "Date", "Morning_Qty", "Evening_Qty", "Total_Qty", "Total_Price"]);

    for (Milk entry in records) {
      rows.add([
        entry.id == 0 ? "Not Saved" : entry.id,
        entry.date,
        entry.morningMilk,
        entry.eveningMilk,
        entry.morningMilk + entry.eveningMilk,
        (entry.morningMilk + entry.eveningMilk) * entry.pricePerLiter
      ]);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    Directory directory = await getApplicationDocumentsDirectory();
    String fileName = "milk_record_${DateFormat("dd-MMM-yyyy").format(DateTime.now())}.csv";
    String filePath = "${directory.path}/$fileName";

    File file = File(filePath);
    await file.writeAsString(csvData);

    await Share.shareXFiles([XFile(filePath)], text: 'Milk Record for $fileName');
  }
}