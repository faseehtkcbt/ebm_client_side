import 'package:client_side/screens/signIn/sign_in_page.dart';
import 'package:client_side/screens/signOut/sign_up_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../screens/main/main_screen.dart';



class AppPages {
  static const HOME = '/';
  static const SIGN_IN = '/sign_in';
  static const SIGN_UP = '/sign_up';


  static final routes = [
    GetPage(
      name: HOME,
      fullscreenDialog: true,
      page: () => MainScreen()
    ),
    GetPage(
        name: SIGN_IN,
        fullscreenDialog: true,
        page: () => SignInPage()
    ), GetPage(
        name: SIGN_UP,
        fullscreenDialog: true,
        page: () => SignUpPage()
    ),

  ];
}
