import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milk_tracker/views/home_page_view.dart';

import 'bindings/home_page_binding.dart';
import 'database/objectbox.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
 final objectBox =  await ObjectBox.create();
 runApp(HomePage(objectBox: objectBox,));
}
class HomePage extends StatelessWidget {
  final ObjectBox objectBox;
   const HomePage({super.key, required this.objectBox});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: "/app_home_page",
            page:() => HomePageView(objectBox:objectBox),
            binding:HomePageBinding(objectBox:objectBox)),
      ],
      initialRoute: "/app_home_page",
    );
  }
}
