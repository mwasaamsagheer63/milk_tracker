import 'package:get/get.dart';
import 'package:milk_tracker/database/objectbox.dart';
import 'package:milk_tracker/view_models/dash_board_view_model.dart';
import 'package:milk_tracker/view_models/settings_view_model.dart';

import '../view_models/history_view_model.dart';
import '../view_models/home_page_view_model.dart';

class SettingsBinding extends Bindings{
late ObjectBox objectBox;

SettingsBinding({required this.objectBox});

  @override
  void dependencies(){
Get.put(SettingsViewModel(objectBox: objectBox));
  }
}