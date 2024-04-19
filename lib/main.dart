import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Common/AppRoutes/app_routes.dart';
import 'package:quiz_app/Provider/provider_classes.dart';
import 'package:quiz_app/view/Admin/admin_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...providerClasses],
      child: GetMaterialApp(
        title: 'Quiz App',
        theme: ThemeData(
        ),
        // home: AdminLogin(),
        debugShowCheckedModeBanner: false,
        initialRoute: adminLoginRoute,
        getPages: AppRoutes,
      ),
    );
  }
}
