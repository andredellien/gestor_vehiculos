import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditVehicleScreen extends StatefulWidget {
  final String vehicleId;
  final DocumentSnapshot vehicleData;

  EditVehicleScreen({required this.vehicleId, required this.vehicleData});

  @override
  _EditVehicleScreenState createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends State<EditVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _yearController;
  late TextEditingController _batteryRangeController;

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: widget.vehicleData['brand']);
    _modelController = TextEditingController(text: widget.vehicleData['model']);
    _yearController =
        TextEditingController(text: widget.vehicleData['year'].toString());
    _batteryRangeController = TextEditingController(
        text: widget.vehicleData['batteryRange'].toString());
  }

  Future<void> _updateVehicle() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('vehicles')
            .doc(widget.vehicleId)
            .update({
          'brand': _brandController.text,
          'model': _modelController.text,
          'year': int.parse(_yearController.text),
          'batteryRange': int.parse(_batteryRangeController.text),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vehículo actualizado correctamente')),
        );
        Navigator.pop(context); // Vuelve a la lista después de guardar
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el vehículo: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Vehículo',
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
                  onPressed: _updateVehicle,
                  child: Text('Guardar Cambios'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0097b2),
                    foregroundColor: Colors.white,
                  )),
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
