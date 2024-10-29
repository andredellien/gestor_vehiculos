import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestor_vehiculos/config/app_routes.dart';
import 'package:gestor_vehiculos/presentation/screens/vehicle_list_screen.dart';
import 'package:gestor_vehiculos/presentation/screens/profile_screen.dart';
import 'package:gestor_vehiculos/presentation/widgets/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  String userName = 'Usuario'; // Nombre predeterminado

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        setState(() {
          userName = userDoc['name'] ??
              'Usuario'; // Obtener el nombre o mostrar 'Usuario' si está vacío
        });
      } catch (e) {
        print("Error al obtener el nombre del usuario: $e");
      }
    }
  }

  // Cambiar página sin animación
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: PageView(
        controller: _pageController,
        physics:
            NeverScrollableScrollPhysics(), // Deshabilita el swipe entre páginas
        children: [
          _buildHomeContent(context),
          VehicleListScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }

  // Contenido principal de HomeScreen
  Widget _buildHomeContent(BuildContext context) {
    return Column(
      children: [
        _buildCustomHeader(context),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bienvenida personalizada
                Text(
                  'Hola, $userName 👋',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0097b2),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '¿Qué te gustaría hacer hoy?',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      // Opción: Añadir Vehículo
                      _buildOptionCard(
                        context,
                        icon: Icons.add,
                        label: "Añadir Vehículo",
                        color: Color(0xFF0097b2),
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.addVehicle),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Método para construir el encabezado personalizado con borde moderno
  Widget _buildCustomHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 193, 222, 227),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 20, bottom: 7, left: 16, right: 16),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              'lib/assets/images/logo.png',
              height: 80,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 20,
            child: IconButton(
              icon: Icon(Icons.logout, color: Color(0xFF0097b2)),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir una tarjeta de opción
  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
