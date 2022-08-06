//routing page using name
import 'package:flutter/material.dart';
import 'package:logique_techtest/screen/detail_user/detail_user_provider.dart';
import 'package:logique_techtest/screen/detail_user/detail_user_screen.dart';
import 'package:logique_techtest/screen/home/home_screen.dart';
import 'package:logique_techtest/utils/common_strings.dart';
import 'package:provider/provider.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CommonString.HOME_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const MyHomePage(),
        );
      case CommonString.DETAIL_USER_ROUTE:
        var args = settings.arguments as DetailUserScreen;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => DetailUserProvider(),
            child: args,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
