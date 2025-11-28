import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:milk_tracker/database/objectbox.dart';
import 'package:milk_tracker/widget_components/buttons.dart';
import 'package:milk_tracker/widget_components/pricing_card.dart';
import 'package:milk_tracker/widget_components/text_field_component.dart';

import '../view_models/history_view_model.dart';
import '../view_models/settings_view_model.dart';

class SettingsView extends GetView<SettingsViewModel> {
 final ObjectBox objectBox;
 final SettingsCard settingsCard = SettingsCard();


 final Buttons buttons = Buttons();


 SettingsView({super.key, required this.objectBox});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(23, 23, 41, 0.8),
          ),
          child: Column(
            children: [
              const Gap(10),
              settingsCard.pricingCard(context,controller),
             const Gap(10),
             settingsCard.goalCard(context,controller),
              const Gap(10),
    Card(
    elevation: 2,
    color: Color.fromRGBO(38, 39, 38, 0.4490196078431372),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
children: [
          Row(
            children: [
              const Gap(10),

              Text( "It will Clear All Data",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
            ],
          ),
  const Gap(10),
  buttons.button("Delete All",clear:true ,(){
    showDialog(context: context, builder: (BuildContext context){
     return Dialog(
       backgroundColor:Color.fromRGBO(66, 67, 66, 0.8790196078431372,) ,
child: Padding(padding: const EdgeInsets.all(12.0),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    spacing: 15,
    children: [
            Icon(Icons.warning,color: Colors.yellow,),
            const Gap(0),
            Text("Are you Sure ?",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            Text("You want to delete All Data ...",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          buttons.button("Cancel",cancel: true, (){Get.back();}),
          buttons.button("Delete", delete:true,(){
            controller.objectBox.milk.removeAll();
            controller.homePageViewModel.totalPrice();
            controller.homePageViewModel.allDataOfMonth =[];
            if (Get.isRegistered<HistoryViewModel>()) {
              Get.find<HistoryViewModel>().loadData();
            } else {
              Get.snackbar("Error", "History Controller not found");
            }
            Get.back();
          })
        ],
      )
    ],
  ),
     ),
     );
    });
                    }),
        ],
      ),
    ))


            ],
          ),
        ),
      ));
  }
}
