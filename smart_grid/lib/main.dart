import 'package:flutter/material.dart';
import 'package:smart_grid/screens/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';





// void main() {
//   runApp(
//     DevicePreview(
//     enabled: true,
//     builder: (context) => MyApp(), // Wrap your app
//     ),
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
    enabled: true,
    builder: (context) => MyApp(), // Wrap your app
    ),
  );
}






class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1B1B1D)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

