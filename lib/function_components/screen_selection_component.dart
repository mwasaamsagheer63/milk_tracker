import 'package:flutter/cupertino.dart';
import 'package:milk_tracker/bindings/dash_board_binding.dart';
import 'package:milk_tracker/bindings/history_binding.dart';
import 'package:milk_tracker/bindings/settings_binding.dart';
import 'package:milk_tracker/view_models/history_view_model.dart';
import 'package:milk_tracker/view_models/home_page_view_model.dart';

import '../database/objectbox.dart';
import '../views/dashboard_view.dart';
import '../views/history_view.dart';
import '../views/settings_view.dart';

class ScreenSelection{
  Widget showScreen(HomePageViewModel controller,ObjectBox objectBox){
    if(controller.currentIndex.value == 0){
DashBoardBinding(objectBox:objectBox).dependencies();
WidgetsBinding.instance.addPostFrameCallback((_) {
  controller.download.value = false;
});
      return DashBoardView(objectBox: objectBox,);
    }

    else if(controller.currentIndex.value == 1){
      HistoryBinding(objectBox:objectBox).dependencies();
      HistoryViewModel historyViewModel = HistoryViewModel(objectBox: objectBox);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        historyViewModel.loadData();
        controller.download.value = true;
      });
      return HistoryView(objectBox: objectBox,);
    }
    else if(controller.currentIndex.value == 2){
     SettingsBinding(objectBox:objectBox).dependencies();
     WidgetsBinding.instance.addPostFrameCallback((_){
       controller.download.value = false;
     });
     return SettingsView(objectBox:objectBox);

    }
    else {
      DashBoardBinding(objectBox: objectBox).dependencies();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.download.value = false;
      });
      return DashBoardView(objectBox: objectBox,);
    }

  }
}