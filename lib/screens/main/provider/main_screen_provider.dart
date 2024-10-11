
// import '../../category/category_screen.dart';
// import '../../coupon_code/coupon_code_screen.dart';
// import '../../dashboard/dashboard_screen.dart';
// import '../../notification/notification_screen.dart';
// import '../../order/order_screen.dart';
// import '../../posters/poster_screen.dart';
// import '../../variants/variants_screen.dart';
// import '../../variants_type/variants_type_screen.dart';
import 'package:client_side/screens/customer/customer_screen.dart';
import 'package:client_side/screens/invoice/invoice_screen.dart';
import 'package:client_side/screens/salesReport/sales_report_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../area/area_screen.dart';
import '../../brands/brand_screen.dart';
import '../../category/category_screen.dart';
import '../../dashboard/dashboard_screen.dart';


// import '../../sub_category/sub_category_screen.dart';

class MainScreenProvider extends ChangeNotifier{
  Widget selectedScreen = DashboardScreen();



  navigateToScreen(String screenName) {
    switch (screenName) {
      case 'Dashboard':
        selectedScreen = DashboardScreen();
        break; // Break statement needed here
      case 'Category':
        selectedScreen = CategoryScreen();
        break;
      case 'Areas':
        selectedScreen = AreaScreen();
        break;
      case 'Brands':
        selectedScreen = BrandScreen();
        break;
      case 'Customer':
        selectedScreen = CustomerScreen();
        break;
      case 'Invoice':
        selectedScreen = InvoiceScreen();
        break;
      case 'SalesReport':
        selectedScreen = SalesReportScreen();
        break;
      // case 'Coupon':
      //   selectedScreen = CouponCodeScreen();
      //   break;
      // case 'Poster':
      //   selectedScreen = PosterScreen();
      //   break;
      // case 'Order':
      //   selectedScreen = OrderScreen();
      //   break;
      // case 'Notifications':
      //   selectedScreen = NotificationScreen();
      //   break;
      // default:
      //   selectedScreen = DashboardScreen();
    }
    notifyListeners();
  }
  
  
}