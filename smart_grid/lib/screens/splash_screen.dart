import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_grid/screens/home_screen.dart';
import 'package:smart_grid/screens/AuthManager.dart';
import 'package:smart_grid/screens/LoginPage.dart';
import 'package:smart_grid/screens/widget_tree.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

 @override
void initState() {
  super.initState();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); 

  Future.delayed(Duration(seconds: 2),() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => WidgetTree(),
    ));
  });
}

@override
void dispose(){
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B1B1D),
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            alignment: Alignment.center,
            image: AssetImage('assets/images/SplashScreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: null,
        ),
    );
  }
}
