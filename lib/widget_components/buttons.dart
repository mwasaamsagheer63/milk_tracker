import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttons{
  Widget button(String name,Function onPressed,{bool delete = false,bool save = false, bool cancel = false,bool clear = false,bool price = false,bool goal =false}){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: save || price || goal ?Color.fromRGBO(
          10,
          197,
          4,
          0.9490196078431372,
        ):cancel ? Color.fromRGBO(
          81,
          83,
          81,
          0.6490196078431372,
        ):clear || delete ? Color.fromRGBO(
          239,
          2,
          58,
          0.6509803921568628,
        ):null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(price || goal || clear ?10:15),
        ),
      ),
      onPressed: () =>onPressed(),
      child: Padding(
        padding: price?EdgeInsets.symmetric(horizontal: 100) :
        goal?EdgeInsets.symmetric(horizontal: 113)
            :clear?EdgeInsets.symmetric(horizontal: 106.0):EdgeInsets.all(4.0),
        child: Text(
          name,
          style: TextStyle(
            color:Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}