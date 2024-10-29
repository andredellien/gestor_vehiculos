import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestor_vehiculos/config/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Vehículos Eléctricos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.splash, // Ruta inicial
      onGenerateRoute: AppRoutes.generateRoute, // Generador de rutas
    );
  }
}
