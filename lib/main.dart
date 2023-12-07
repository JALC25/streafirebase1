import 'package:firebasestrems/firebase_options.dart';
import 'package:firebasestrems/page/home_page%20copy.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';







void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
title: "firebase y flute",
initialRoute: '/' ,
home:HomePage()

//routes: {
  
  //"/":(context) =>  HomePage(),
//   '/motorista': (context) => MotoristaScreen()
//}
      
    );
  }
}