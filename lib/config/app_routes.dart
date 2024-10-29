import 'package:flutter/material.dart';
import 'package:gestor_vehiculos/presentation/screens/add_vehicle_screen.dart';
import 'package:gestor_vehiculos/presentation/screens/home_screen.dart';
import 'package:gestor_vehiculos/presentation/screens/login_screen.dart';
import 'package:gestor_vehiculos/presentation/screens/main_screen.dart';
import 'package:gestor_vehiculos/presentation/screens/profile_screen.dart';
import 'package:gestor_vehiculos/presentation/screens/register_screen.dart';
import 'package:gestor_vehiculos/presentation/screens/splash_screen.dart';
import 'package:gestor_vehiculos/presentation/screens/vehicle_list_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String main = '/main';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String vehicleList = '/vehicleList';
  static const String profile = '/profile';
  static const String addVehicle = '/addVehicle'; // Nueva ruta

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case vehicleList:
        return MaterialPageRoute(builder: (_) => VehicleListScreen());
      case addVehicle:
        return MaterialPageRoute(builder: (_) => AddVehicleScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Ruta no encontrada: ${settings.name}')),
          ),
        );
    }
  }
}
