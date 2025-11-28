import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/milk.dart';

class DisplayChip{
  Widget chip(String record,String type){
    return Card(
      color:Color.fromRGBO(67, 66, 86, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
        child: Column(
          children: [
            Text(record,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),),
            Text(type,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),),
          ],
        ),
      ),
    );
  }

  Widget filterChip(String time,{bool selected=false}){
    return Chip(label: Text(time),
      color: WidgetStatePropertyAll(selected?Colors.lightBlue:Color.fromRGBO(33, 23, 30, 0.96)),
      labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      side: BorderSide(color:selected?Colors.lightBlue:Color.fromRGBO(33, 23, 30, 0.96)),);
  }
  // Widget fileComponent({bool csv = false, bool json = false}){
  //   return Card(
  //     color:Color.fromRGBO(67, 66, 86, 1.0),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
  //       child: Column(
  //         children: [
  //           Icon(csv?Icons.note_alt_sharp:json?Icons.file_copy:null,color:Colors.white,size: 30,),
  //           Text(csv?"Export CSV":json?"Export JSON":"",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),)
  //         ],
  //       ),
  //     ),
  //   );
  }
