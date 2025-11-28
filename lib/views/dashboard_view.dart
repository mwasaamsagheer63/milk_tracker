import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milk_tracker/database/objectbox.dart';
import 'package:milk_tracker/view_models/dash_board_view_model.dart';
import 'package:milk_tracker/widget_components/dashboard_card_component.dart';

import '../widget_components/dialog_box.dart';

class DashBoardView extends GetView<DashBoardViewModel> {
  final DashBoardCard dashBoardCard = DashBoardCard();
  final DialogBoxComponent dialogBoxComponent = DialogBoxComponent();
final ObjectBox objectBox;

  DashBoardView({super.key, required this.objectBox});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(23, 23, 41, 0.8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: controller.settingsViewModel.dataForTesting,
                  child: Text(
                    "Today's Progress",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 8),

                Row(
                  spacing: 5,
                  children: [
                    InkWell(
                        onTap: (){
                          dialogBoxComponent.entryDialog(context,"Morning Entry",objectBox,controller, morning: true);
                        },
                        child: dashBoardCard.card("Morning",objectBox.getMilkByDate(controller.date())!.morningMilk, day: true)),
                    InkWell(
                        onTap: (){
                          dialogBoxComponent.entryDialog(context,"Evening Entry", objectBox,controller, evening: true);
                        },
                        child: dashBoardCard.card("Evening",objectBox.getMilkByDate(controller.date())!.eveningMilk)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  spacing: 5,
                  children: [
                    dashBoardCard.card(
                      "TODAY'S TOTAL",
                      objectBox.getMilkByDate(controller.date())!.morningMilk+
                          objectBox.getMilkByDate(controller.date())!.eveningMilk,
                      total: true,
                      totalMilk: true,
                    ),
                    dashBoardCard.card(
                      "TODAY'S Cost",
                      objectBox.getMilkByDate(controller.date()).pricePerLiter*(objectBox.getMilkByDate(controller.date())!.morningMilk+
                          objectBox.getMilkByDate(controller.date()).eveningMilk),
                      total: true,
                      totalCost: true,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                dashBoardCard.goalProgress(controller),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
