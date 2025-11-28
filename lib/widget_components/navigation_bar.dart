import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milk_tracker/view_models/home_page_view_model.dart';

import 'bottom_item_component.dart';

class BottomNavigation{
  final BottomItem bottomItem = BottomItem();

  BottomNavigationBar bottomNavigationBar(HomePageViewModel controller){
    return BottomNavigationBar(
      currentIndex: controller.currentIndex.value,
      backgroundColor: Color.fromRGBO(11, 16, 46, 0.95),
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.white,
      selectedLabelStyle: TextStyle(fontSize: 10),
      unselectedLabelStyle: TextStyle(fontSize: 10),
      selectedItemColor: Color.fromRGBO(
          99, 183, 254, 0.9490196078431372),
      elevation: 3,
      onTap: (value) {
        controller.currentIndex.value = value;
        print(controller.currentIndex.value);
      },
      items: [
        bottomItem.item(home: true),
        bottomItem.item(history: true),
        bottomItem.item(settings: true),
      ],);
  }
}