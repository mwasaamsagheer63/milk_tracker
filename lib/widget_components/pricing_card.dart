import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:milk_tracker/widget_components/text_field_component.dart';

import '../view_models/settings_view_model.dart';
import 'buttons.dart';

class SettingsCard{
  final TextFieldComponent textFieldComponent = TextFieldComponent();
  final Buttons buttons = Buttons();
  Widget pricingCard(BuildContext context,SettingsViewModel controller){
     TextEditingController pricePerLiter = TextEditingController(text:controller.savedPrice.toString() );
     TextEditingController price40Liter = TextEditingController(text: (controller.savedPrice.value*40).toString());
    return Obx(() => Card(
      elevation: 2,
      color: Color.fromRGBO(38, 39, 38, 0.4490196078431372),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          spacing: 1,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing:10,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(10, 197, 4, 0.9490196078431372)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.monetization_on_outlined,size:22,color: Colors.white,),
                  ),
                ),
                Text("Pricing Configuration",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
              ],
            ),
            const Gap(10),
            Text("Price per Liter (Rs)",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
            const Gap(3),
            textFieldComponent.textField(context, pricePerLiter,"0 Rs",onChanged: (){
              controller.saveData(num.tryParse(pricePerLiter.text)??0);
            }),
            const Gap(10),
            Text("Price of 40 Liters",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
            const Gap(3),
            textFieldComponent.textField(context, price40Liter,"0 Rs",onChanged: (){
              int price = int.tryParse(price40Liter.text)?? 0;
              controller.saveData((price/40).toInt());

            }),
            const Gap(20),
            Align(
              alignment: Alignment.center,
              child: Card(
                elevation: 6,
                color: Color.fromRGBO(194, 198, 194, 0.18098039215686275),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
                  child: Column(
                    spacing: 5,
                    children: [
                      Text("Rs ${controller.savedPrice} / L",style: TextStyle(color:Color.fromRGBO(10, 197, 4, 0.9490196078431372),fontSize: 20,fontWeight: FontWeight.bold),),
                      Text("Current Rate",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),)
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    ));
  }
  Widget goalCard(BuildContext context, SettingsViewModel controller){

    return Card(
      elevation: 2,
      color: Color.fromRGBO(38, 39, 38, 0.4490196078431372),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing:10,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(10, 197, 4, 0.9490196078431372)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.center_focus_strong_sharp,size:22,color: Colors.white,),
                  ),
                ),
                Text("Daily Goal",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
              ],
            ),
            const Gap(10),
            Text("Price per Liter (Rs)",style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),),
            const Gap(3),
            textFieldComponent.textField(context, controller.goal,"Set Goal in Liters",onChanged:(){} ),
            const Gap(10),
            buttons.button("Set Goal",goal: true, (){
              controller.saveGoal(controller.goal.text);
            })

          ],
        ),
      ),
    );
  }
}