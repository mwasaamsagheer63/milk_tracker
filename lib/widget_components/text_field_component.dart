import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldComponent{
  Widget textField(BuildContext context, TextEditingController textEditingController,String hintText,{Function? onChanged}){
    return Theme(data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
           selectionHandleColor: Color.fromRGBO(10, 197, 4, 0.9490196078431372),
        )
    ), child: TextField(
      controller: textEditingController,
      keyboardType: TextInputType.number,
      cursorColor: Color.fromRGBO(10, 197, 4, 0.9490196078431372),
      style:  TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor:Color.fromRGBO(194, 198, 194, 0.18098039215686275) ,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white)

        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color.fromRGBO(10, 197, 4, 0.9490196078431372))
        ),

      ),
      onChanged: (value) => onChanged!(),
    ));
  }
}