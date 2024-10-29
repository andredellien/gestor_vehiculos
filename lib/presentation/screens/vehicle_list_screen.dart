import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_vehicle_screen.dart';

class VehicleListScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  // Método para eliminar un vehículo
  Future<void> _deleteVehicle(BuildContext context, String vehicleId) async {
    try {
      await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(vehicleId)
          .delete();

      // Muestra el SnackBar solo si el contexto está montado
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vehículo eliminado correctamente')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar el vehículo: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de vehículos',
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('vehicles')
            .where('userId', isEqualTo: user?.uid)
            .snapshots(), // Configuración para actualización en tiempo real
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hay vehículos registrados'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var vehicle = snapshot.data!.docs[index];
              return Row(
                children: [
                  // Card del vehículo que permite editar
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditVehicleScreen(
                              vehicleId: vehicle.id,
                              vehicleData: vehicle,
                            ),
                          ),
                        );
                      },
                      child: VehicleCard(
                        brand: vehicle['brand'],
                        model: vehicle['model'],
                        year: vehicle['year'],
                        batteryRange: vehicle['batteryRange'],
                      ),
                    ),
                  ),
                  // Botón de eliminación
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteVehicle(context, vehicle.id),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  final String brand;
  final String model;
  final int year;
  final int batteryRange;

  VehicleCard({
    required this.brand,
    required this.model,
    required this.year,
    required this.batteryRange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Contenido del card
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$brand $model',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0097b2),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Año: $year',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    Text(
                      'Autonomía: $batteryRange km',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            ),
            // Ícono de edición en la esquina superior derecha
            Positioned(
              right: 0,
              top: 0,
              child: Icon(
                Icons.edit,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
