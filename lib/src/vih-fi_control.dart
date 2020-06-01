import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vihfi_control/src/pages/splash_page.dart';

class VihFiApp extends StatelessWidget {
  // This widget is the root of your application.
      
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vih-Fi Control',
      theme: ThemeData.dark(),
      home: SplashPage(),
    );
  }
}