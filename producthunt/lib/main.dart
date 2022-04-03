import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:producthunt/routes.dart';
import 'package:producthunt/view/resources/palette.dart';
import 'package:producthunt/view/spalsh/splash.dart';

import 'controller/bindings/initial_bindings.dart';
import 'data/network/map_factory.dart';

Future<void> main() async{
  mainCommon();
}

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitialBindings().dependencies();
  //MapperFactory.initialize();
  runApp(getMaterialApp);
}

GetMaterialApp get getMaterialApp => GetMaterialApp(
  title: 'Product Hunt',
  debugShowCheckedModeBanner: false,
  getPages: Routes.get(),
  theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.black38,
          secondary: Colors.white
    )
  ),
  builder: (context, child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: child ?? Container(),
    );
  },
  initialRoute: SplashPage.routeName,
);
