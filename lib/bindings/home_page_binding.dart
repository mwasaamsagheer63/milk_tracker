import 'package:get/get.dart';
import 'package:milk_tracker/database/objectbox.dart';

import '../view_models/home_page_view_model.dart';

class HomePageBinding extends Bindings{
  final ObjectBox objectBox;
  HomePageBinding({required this.objectBox});
  @override
  void dependencies(){
    Get.put(HomePageViewModel(objectBox:objectBox));
  }
}