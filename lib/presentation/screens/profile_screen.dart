import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestor_vehiculos/presentation/screens/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  // Obtener la información del usuario desde Firestore
  Future<void> _getUserInfo() async {
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        setState(() {
          userName = userDoc['name'] ?? 'Usuario';
          userEmail = userDoc['email'] ?? 'Correo no disponible';
        });
      } catch (e) {
        print("Error al obtener los datos del usuario: $e");
      }
    }
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        setState(() {
          userName = userDoc['name'] ?? 'Usuario';
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos del usuario: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: TextStyle(
            color: Color(0xFF0097b2), // Cambia el color del texto a blanco
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 193, 222, 227),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage('lib/assets/images/profile_placeholder.png'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                userName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0097b2),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                userEmail,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 30),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit, color: Color(0xFF0097b2)),
              title: Text('Editar perfil'),
              onTap: () async {
                // Navega a EditProfileScreen y espera el resultado
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(),
                  ),
                );

                // Si el resultado es `true`, recarga el nombre del usuario
                if (result == true) {
                  _loadUserData(); // Método para recargar los datos de Firestore
                }
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xFF0097b2)),
              title: Text('Cerrar sesión'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
