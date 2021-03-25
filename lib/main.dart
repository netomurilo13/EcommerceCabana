import 'package:ELoja/models/admin_orders_manager.dart';
import 'package:ELoja/models/admin_users_manager.dart';
import 'package:ELoja/models/cart_manager.dart';
import 'package:ELoja/models/home_manager.dart';
import 'package:ELoja/models/order.dart';
import 'package:ELoja/models/orders_manager.dart';
import 'package:ELoja/models/products.dart';
import 'package:ELoja/models/products_manager.dart';
import 'package:ELoja/models/stores_manager.dart';
import 'package:ELoja/models/user_manager.dart';
import 'package:ELoja/screens/address/address_screen.dart';
import 'package:ELoja/screens/base/base_screen.dart';
import 'package:ELoja/screens/cart/cart_screen.dart';
import 'package:ELoja/screens/checkout/checkout_screen.dart';
import 'package:ELoja/screens/confirmation/confirmation_screen.dart';
import 'package:ELoja/screens/edit_product/edit_product_screen.dart';
import 'package:ELoja/screens/login/login_screen.dart';
import 'package:ELoja/screens/product/product_screen.dart';
import 'package:ELoja/screens/select_product/select_product_screen.dart';
import 'package:ELoja/screens/signup/signup_screen.dart';
import 'package:ELoja/services/cepaberto_service.dart';
import 'package:cloud_functions/cloud_functions.dart';
//muitos imports devido a falha de segmentação do flutter

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StoresManager(),
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
              ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_, userManager, adminOrdersManager) => adminOrdersManager
            ..updateAdmin(adminEnabled: userManager.adminEnabled),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cabana Outlet',
        theme: ThemeData(
          primaryColor: const Color(0xFFD1AE6C),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => CartScreen(), settings: settings);
            case '/address':
              return MaterialPageRoute(builder: (_) => AddressScreen());
            case '/checkout':
              return MaterialPageRoute(builder: (_) => CheckoutScreen());
            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) =>
                      EditProductScreen(settings.arguments as Product));
            case '/select_product':
              return MaterialPageRoute(builder: (_) => SelectProductScreen());
            case '/confirmation':
              return MaterialPageRoute(
                  builder: (_) =>
                      ConfirmationScreen(settings.arguments as Order));
            case '/':
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(), settings: settings);
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(settings.arguments as Product));
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
