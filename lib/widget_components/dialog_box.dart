import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milk_tracker/database/objectbox.dart';
import 'package:milk_tracker/models/milk.dart';
import 'package:milk_tracker/view_models/dash_board_view_model.dart';
import 'package:milk_tracker/view_models/home_page_view_model.dart';
import 'package:milk_tracker/view_models/settings_view_model.dart';

import 'buttons.dart';

class DialogBoxComponent{
final HomePageViewModel homePageViewModel = Get.find();
final SettingsViewModel settingsViewModel = Get.find();
  Buttons buttons = Buttons();
  Future entryDialog(BuildContext context,String dayTime,ObjectBox objectBox,DashBoardViewModel controller, {bool morning = false, bool evening = false}){
    TextEditingController morningQuantityController = TextEditingController();
    TextEditingController eveningQuantityController = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        morningQuantityController.text = objectBox.getMilkByDate(controller.date())!.morningMilk.toString()??"0";
        eveningQuantityController.text = objectBox.getMilkByDate(controller.date())!.eveningMilk.toString()??"0";
        return SingleChildScrollView(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor:Color.fromRGBO(66, 67, 66, 0.8790196078431372,) ,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30,),
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(
                      10,
                      197,
                      4,
                      0.9490196078431372,
                    ),
                    child: Icon(Icons.inventory_2_rounded, color: Colors.white),
                  ),
                  const SizedBox(height: 10,),

                  Text(
                    dayTime,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Quantity (Liters)",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    child: TextField(
                      controller:morning?morningQuantityController:evening?eveningQuantityController:null,
                      keyboardType: TextInputType.number,
                      style:  TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(
                          48,
                          49,
                          58,
                          0.9490196078431372,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(33, 34, 33, 0.9490196078431372),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: 250,
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Text(
                          "Rs ${controller.settingsViewModel.savedPrice}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(
                              10,
                              197,
                              4,
                              0.9490196078431372,
                            ),
                          ),
                        ),
                        Text(
                          "Cost",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        const SizedBox(height: 10,),

                      ],
                    ),
                  ),
                  buttons.button("Save Entry",(){
                    Get.back();
                    controller.storeData(objectBox,morningQuantityController.text,
                        eveningQuantityController.text,
                        morning: morning,evening: evening);
                    homePageViewModel.totalPrice();
                  },save : true),


                  buttons.button("Cancel",(){
                  Get.back();
                  },cancel : true),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Future editDialog(BuildContext context,Milk record,ObjectBox objectBox){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController morningController = TextEditingController(text: record.morningMilk.toString());
        TextEditingController eveningController = TextEditingController(text: record.eveningMilk.toString());
        TextEditingController priceController = TextEditingController(text: record.pricePerLiter.toString());
        return SingleChildScrollView(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor:Color.fromRGBO(66, 67, 66, 0.8790196078431372,) ,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30,),
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(
                      10,
                      197,
                      4,
                      0.9490196078431372,
                    ),
                    child: Icon(Icons.inventory_2_rounded, color: Colors.white),
                  ),
                  const SizedBox(height: 5,),
                  Text("You can Edit Data here",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Theme(
                    data: Theme.of(context).copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                            selectionHandleColor: Color.fromRGBO(
                              10,
                              197,
                              4,
                              0.9490196078431372,
                            )
                        )
                    ),
                    child: TextField(
                      controller: morningController,
                      keyboardType: TextInputType.number,
                      cursorColor: Color.fromRGBO(
                        10,
                        197,
                        4,
                        0.9490196078431372,
                      ),
                      cursorWidth: 3,
                      style:  TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Morning Qty",
                        labelStyle: TextStyle(color: Color.fromRGBO(
                          10,
                          197,
                          4,
                          0.9490196078431372,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(
                              10,
                              197,
                              4,
                              0.9490196078431372,
                            )),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(
                          48,
                          49,
                          58,
                          0.9490196078431372,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                            selectionHandleColor: Color.fromRGBO(
                              10,
                              197,
                              4,
                              0.9490196078431372,
                            )
                        )
                    ),
                    child: TextField(
                      controller: eveningController,
                      keyboardType: TextInputType.number,
                      cursorColor: Color.fromRGBO(
                        10,
                        197,
                        4,
                        0.9490196078431372,
                      ),
                      cursorWidth: 3,
                      style:  TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Evening Qty",
                        labelStyle: TextStyle(color: Color.fromRGBO(
                          10,
                          197,
                          4,
                          0.9490196078431372,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(
                              10,
                              197,
                              4,
                              0.9490196078431372,
                            )),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(
                          48,
                          49,
                          58,
                          0.9490196078431372,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                            selectionHandleColor: Color.fromRGBO(
                              10,
                              197,
                              4,
                              0.9490196078431372,
                            )
                        )
                    ),
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      cursorColor: Color.fromRGBO(
                        10,
                        197,
                        4,
                        0.9490196078431372,
                      ),
                      cursorWidth: 3,
                      style:  TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Price Per Liter",
                        labelStyle: TextStyle(color: Color.fromRGBO(
                          10,
                          197,
                          4,
                          0.9490196078431372,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(
                              10,
                              197,
                              4,
                              0.9490196078431372,
                            )),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(
                          48,
                          49,
                          58,
                          0.9490196078431372,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),


                  buttons.button("Update Entry",(){
                    Get.back();
                    record.morningMilk = int.tryParse(morningController.text)!;
                    record.eveningMilk = int.tryParse(eveningController.text)!;
                    record.pricePerLiter = int.tryParse(priceController.text)!;
                    objectBox.addData(record);
                    homePageViewModel.totalPrice();
                    if(DateFormat('dd-MMM-yyyy').format(DateTime.now()) == record.date){
                    settingsViewModel.loadGoal();}


                  },save : true),


                  buttons.button("Cancel",(){
                    Get.back();
                  },cancel : true),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        );
      },
    );;
  }
}