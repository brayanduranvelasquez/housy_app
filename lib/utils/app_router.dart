import 'package:flutter/material.dart';
import 'package:housy_app/utils/route_guard.dart';
import 'package:housy_app/views/main_navigation.dart';
import 'package:housy_app/views/login.dart';
import 'package:housy_app/views/initial.dart';
import 'package:housy_app/views/loading.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const InitialPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/home':
        return ProtectedRoute(builder: (_) => const MainNavigation());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

class ProtectedRoute extends MaterialPageRoute {
  ProtectedRoute({required super.builder});

  @override
  Widget buildContent(BuildContext context) {
    return FutureBuilder<bool>(
      future: RouteGuard().isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else if (snapshot.data == true) {
          return super.buildContent(context);
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/');
          });
          return const SizedBox.shrink();
        }
      },
    );
  }
}
