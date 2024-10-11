import 'package:client_side/screens/customer/provider/customer_provider.dart';
import 'package:client_side/screens/invoice/provider/invoice_provider.dart';
import 'package:client_side/screens/signIn/provider/sign_in_provider.dart';
import 'package:client_side/screens/signOut/provider/sign_up_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../core/data/data_provider.dart';
import '../screens/area/provider/area_provider.dart';
import '../screens/brands/provider/brand_provider.dart';
import '../screens/category/provider/category_provider.dart';
import '../screens/dashboard/provider/dash_board_provider.dart';
import '../screens/main/provider/main_screen_provider.dart';

extension Providers on BuildContext {
  DataProvider get dataProvider => Provider.of<DataProvider>(this, listen: false);
  MainScreenProvider get mainScreenProvider => Provider.of<MainScreenProvider>(this, listen: false);
  CategoryProvider get categoryProvider => Provider.of<CategoryProvider>(this, listen: false);
  AreaProvider get areaProvider => Provider.of<AreaProvider>(this, listen: false);
  BrandProvider get brandProvider => Provider.of<BrandProvider>(this, listen: false);
  CustomerProvider get customerProvider => Provider.of<CustomerProvider>(this, listen: false);
  InvoiceProvider get invoiceProvider => Provider.of<InvoiceProvider>(this, listen: false);
  SignInProvider get signInProvider => Provider.of<SignInProvider>(this, listen: false);
  SignUpProvider get signUpProvider => Provider.of<SignUpProvider>(this, listen: false);
  DashBoardProvider get dashBoardProvider => Provider.of<DashBoardProvider>(this, listen: false);
  }