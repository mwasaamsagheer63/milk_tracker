import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milk_tracker/database/objectbox.dart';
import 'package:milk_tracker/function_components/screen_selection_component.dart';
import 'package:milk_tracker/widget_components/app_bar_component.dart';
import 'package:milk_tracker/widget_components/navigation_bar.dart';
import '../view_models/home_page_view_model.dart';
import '../widget_components/bottom_item_component.dart';

class HomePageView extends GetView<HomePageViewModel> {
  final AppBarComponent appBarComponent = AppBarComponent();
  final ScreenSelection screenSelection = ScreenSelection();
  final BottomNavigation bottomNavigation = BottomNavigation();
  ObjectBox objectBox;
  HomePageView({super.key,required this.objectBox});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(140),
            child:Obx(() => appBarComponent.appBarComponent(context,objectBox,history: controller.download.value))),
        body: Obx(() => screenSelection.showScreen(controller,objectBox)),
        bottomNavigationBar: Obx(() {
              return bottomNavigation.bottomNavigationBar(controller);
            }));




  }
}
