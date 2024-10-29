import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _batteryRangeController = TextEditingController();

  Future<void> _saveVehicle() async {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Agregar los datos del vehículo con el UID del usuario autenticado
        final vehicleData = {
          'brand': _brandController.text,
          'model': _modelController.text,
          'year': int.parse(_yearController.text),
          'batteryRange': int.parse(_batteryRangeController.text),
          'userId': user.uid, // Vincula el vehículo al UID del usuario
          'createdAt': FieldValue.serverTimestamp(),
        };

        try {
          await FirebaseFirestore.instance
              .collection('vehicles')
              .add(vehicleData);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Vehículo guardado correctamente')),
          );

          _brandController.clear();
          _modelController.clear();
          _yearController.clear();
          _batteryRangeController.clear();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al guardar el vehículo: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario no autenticado')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Añadir Vehículo',
          style: TextStyle(
            color: Color(0xFF0097b2), // Cambia el color del texto a blanco
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 193, 222, 227),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _brandController,
                decoration: InputDecoration(labelText: 'Marca'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la marca del vehículo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(labelText: 'Modelo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el modelo del vehículo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Año'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el año del vehículo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _batteryRangeController,
                decoration:
                    InputDecoration(labelText: 'Autonomía de Batería (km)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la autonomía de la batería';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveVehicle,
                child: Text('Guardar Vehículo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0097b2),
                  foregroundColor:
                      Colors.white, // Cambia 'primary' a 'backgroundColor'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _batteryRangeController.dispose();
    super.dispose();
  }
}
