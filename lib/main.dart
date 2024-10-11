import 'package:client_side/screens/area/provider/area_provider.dart';
import 'package:client_side/screens/brands/provider/brand_provider.dart';
import 'package:client_side/screens/category/provider/category_provider.dart';
import 'package:client_side/screens/customer/provider/customer_provider.dart';
import 'package:client_side/screens/dashboard/provider/dash_board_provider.dart';
import 'package:client_side/screens/invoice/provider/invoice_provider.dart';
import 'package:client_side/screens/main/main_screen.dart';
import 'package:client_side/screens/main/provider/main_screen_provider.dart';
import 'package:client_side/screens/signIn/provider/sign_in_provider.dart';
import 'package:client_side/screens/signOut/provider/sign_up_provider.dart';
import 'package:client_side/utility/constants.dart';
import 'package:client_side/utility/extensions.dart';
import 'package:client_side/utility/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import 'core/data/data_provider.dart';
import 'core/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DataProvider()),
    ChangeNotifierProvider(create: (context) => MainScreenProvider()),
    ChangeNotifierProvider(create: (context) => CategoryProvider(context.dataProvider)),
    ChangeNotifierProvider(create: (context) => BrandProvider(context.dataProvider)),
    ChangeNotifierProvider(create: (context) => CustomerProvider(context.dataProvider)),
    ChangeNotifierProvider(create: (context) => SignInProvider()),
    ChangeNotifierProvider(create: (context) => SignUpProvider()),


    ChangeNotifierProvider(create: (context) => AreaProvider(context.dataProvider)),
    ChangeNotifierProvider(create: (context) => DashBoardProvider(context.dataProvider)),
    ChangeNotifierProvider(create: (context) => InvoiceProvider(context.dataProvider)),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String? getLogin() {
      return html.window.localStorage['isLoggedIn'];
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EBM',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      initialRoute: getLogin() == 'success'? AppPages.HOME:AppPages.SIGN_IN,
      unknownRoute: GetPage(name: '/notFount', page: () => MainScreen()),
      defaultTransition: Transition.cupertino,
      getPages: AppPages.routes,
    );
  }
}


