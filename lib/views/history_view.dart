import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milk_tracker/database/objectbox.dart';
import 'package:milk_tracker/widget_components/dialog_box.dart';
import 'package:milk_tracker/widget_components/display_chip.dart';

import '../models/milk.dart';
import '../view_models/history_view_model.dart';
import '../widget_components/buttons.dart';

class HistoryView extends GetView<HistoryViewModel> {
  final ObjectBox objectBox;
  final DialogBoxComponent dialogBoxComponent = DialogBoxComponent();
  final DisplayChip displayChip = DisplayChip();
  final Buttons buttons = Buttons();

  // 1. Scroll Controller banaya
  final ScrollController scrollController = ScrollController();

  HistoryView({super.key, required this.objectBox});

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      // 2. Auto-Scroll Logic: Data aate hi neechay jump karega
      if (controller.milkHistory.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      }

      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromRGBO(23, 23, 41, 0.8),
        ),
        child: Column(
          children: [
            // 3. SizedBox hata kar Expanded lagaya taake full screen cover kare
            Expanded(
              child: ListView.builder(
                // 4. Controller yahan attach kiya
                controller: scrollController,
                itemCount: controller.milkHistory.length,
                itemBuilder: (context, index) {
                  Milk record = controller.milkHistory[index];
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: InkWell(
                      onTap: () {
                        dialogBoxComponent.editDialog(
                            context, record, objectBox);
                      },
                      child: Card(
                        color: Color.fromRGBO(37, 31, 34, 0.4039215686274509),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            spacing: 8,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    record.date!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: Chip(
                                      label: Text(
                                        record.morningMilk == 0 ||
                                            record.eveningMilk == 0
                                            ? "InComplete"
                                            : "Complete",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      backgroundColor: record.morningMilk == 0 ||
                                          record.eveningMilk == 0
                                          ? Colors.red
                                          : Color.fromRGBO(
                                          10, 197, 4, 0.9490196078431372),
                                      labelPadding:
                                      EdgeInsets.fromLTRB(2, 0, 2, 0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadiusGeometry.circular(60)),
                                      side: BorderSide(
                                          color: record.morningMilk == 0 ||
                                              record.eveningMilk == 0
                                              ? Color.fromRGBO(166, 23, 23, 1.0)
                                              : Color.fromRGBO(
                                              10, 197, 4, 0.9490196078431372)),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      displayChip.chip(
                                          record.morningMilk.toString(),
                                          "Morning"),
                                      displayChip.chip(
                                          record.eveningMilk.toString(),
                                          "Evening"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      displayChip.chip(
                                          "${record.morningMilk + record.eveningMilk}",
                                          "Total Milk"),
                                      displayChip.chip(
                                          "${record.pricePerLiter * (record.morningMilk + record.eveningMilk)}",
                                          "Cost"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}