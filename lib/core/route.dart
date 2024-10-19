import 'package:flutter/material.dart';
import 'package:shubtest/screen/input_screen.dart';

import '../screen/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/form':
        return MaterialPageRoute(builder: (_) => const TransactionForm());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}