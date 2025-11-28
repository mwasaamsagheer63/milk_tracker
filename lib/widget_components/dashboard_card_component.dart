import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:milk_tracker/views/dashboard_view.dart';
import 'package:milk_tracker/widget_components/dialog_box.dart';

import '../view_models/dash_board_view_model.dart';

class DashBoardCard {
  Widget card(
    String dayText,
    num amount,
      {
    bool totalCost = false,
    bool day = false,
    bool total = false,
    bool totalMilk = false,
  }) {
    return Card(
      color: total
          ? Color.fromRGBO(52, 53, 52, 0.9490196078431372)
          : Color.fromRGBO(10, 197, 4, 0.9490196078431372),
      child: SizedBox(
        width: 160,
        child: Column(
          spacing: total ? 9 : 4,
          children: [
            const SizedBox(height: 6),
            total
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Color.fromRGBO(185, 186, 185, 0.5),
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
            Icon(
              totalCost
                  ? Icons.monetization_on
                  : totalMilk
                  ? Icons.hourglass_full
                  : day
                  ? Icons.sunny
                  : Icons.shield_moon_outlined,
              color: Colors.white,
              size: total ? 32 : 35,
            ),
            Text(
              dayText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              totalCost ? "RS $amount" : "${amount}L",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget goalProgress(DashBoardViewModel controller) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(52, 53, 52, 0.9490196078431372),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          spacing: 6,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Daily Goal Progress",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${controller.settingsViewModel.goalInPercentage.toString()} %",
                  style: TextStyle(
                    color: Color.fromRGBO(10, 197, 4, 0.9490196078431372),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            LinearProgressIndicator(
              value: controller.settingsViewModel.goalInDecimal.value,
              minHeight: 10,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15),
                right: Radius.circular(15),
              ),
              color: Color.fromRGBO(10, 197, 4, 0.9490196078431372),
              backgroundColor: Color.fromRGBO(112, 113, 112, 0.6),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text("${controller.settingsViewModel.savedGoal} L", style: TextStyle(color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}
