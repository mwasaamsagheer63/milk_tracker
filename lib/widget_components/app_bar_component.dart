import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milk_tracker/database/objectbox.dart';
import 'package:milk_tracker/view_models/history_view_model.dart';
import 'package:milk_tracker/view_models/home_page_view_model.dart';

class AppBarComponent {
  PreferredSizeWidget appBarComponent(BuildContext context, ObjectBox objectBox, {bool history = false}) {
    final HomePageViewModel homePageViewModel = Get.find();
    return AppBar(
      backgroundColor: Color.fromARGB(200, 7, 7, 16),
      leadingWidth: MediaQuery.of(context).size.width,
      toolbarHeight: 140,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "MilkTracker Pro",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(199, 147, 147, 244)),
                ),
                Row(spacing: 3, children: [
                  history
                      ? InkWell(
                    onTap: () {
                      if (Get.isRegistered<HistoryViewModel>()) {
                        Get.find<HistoryViewModel>().convertToCSV();
                      } else {
                        Get.snackbar("Error", "History Controller not found");
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Color.fromRGBO(33, 23, 30, 0.96),
                      radius: 20,
                      child: Icon(
                        Icons.download,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  )
                      : SizedBox.shrink(),
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(200, 39, 96, 195),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  )
                ])
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(20, 20, 20, 0.18),
              ),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color.fromRGBO(20, 20, 20, 0.9),
                          content: SizedBox(
                            height: 300,
                            width: double.maxFinite,
                            child: Obx(() {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                homePageViewModel.monthlySummaries.length,
                                itemBuilder: (context, index) {
                                  final summary =
                                  homePageViewModel.monthlySummaries[index];

                                  return InkWell(
                                    onTap: () {
                                      TextEditingController customPriceController = TextEditingController();
                                      showDialog(context: context, builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Color.fromRGBO(66, 67, 66, 0.95),
                                          title: Text("Edit Price for ${summary.monthYear}",
                                              style: TextStyle(color: Colors.white, fontSize: 16)),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Enter new price per liter for this whole month:",
                                                  style: TextStyle(color: Colors.grey, fontSize: 12)),
                                              SizedBox(height: 10),
                                              TextField(
                                                controller: customPriceController,
                                                keyboardType: TextInputType.number,
                                                style: TextStyle(color: Colors.white),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.black26,
                                                    hintText: "e.g. 220",
                                                    hintStyle: TextStyle(color: Colors.white30),
                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () => Get.back(),
                                                child: Text("Cancel", style: TextStyle(color: Colors.red))
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  int? newPrice = int.tryParse(customPriceController.text);
                                                  if (newPrice != null && newPrice > 0) {
                                                    homePageViewModel.updateMonthPrice(summary.monthYear, newPrice);
                                                    Get.back();
                                                  }
                                                },
                                                child: Text("Update", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                                            ),
                                          ],
                                        );
                                      });
                                    },
                                    child: Card(
                                      color: Color.fromRGBO(33, 34, 33, 0.95),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  summary.monthYear,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${summary.totalMilk} L",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          10, 197, 4, 1),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  "Rs ${summary.totalCost}",
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(() => Column(
                        children: [
                          Text(
                            "${homePageViewModel.totalAmount.value} Rs",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "MONTHLY COST",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ],
                      )),
                      Obx(() => Column(
                        children: [
                          Text(
                            "${homePageViewModel.totalMilk.value}L",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "Total Milk",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                        ],
                      )),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(230, 142, 7, 0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 30, 5),
                          child: Row(
                            spacing: 5,
                            children: [
                              Icon(
                                Icons.cloud_queue,
                                color: Color.fromARGB(200, 244, 148, 4),
                                size: 14,
                              ),
                              Text(
                                  "${homePageViewModel.allDataOfMonth.length} days",
                                  style: TextStyle(
                                      color: Color.fromARGB(200, 244, 148, 4),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}