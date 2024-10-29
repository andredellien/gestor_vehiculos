import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Configura el controlador de animación
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Configura la animación de escala
    _scaleAnimation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );

    // Configura la animación de desvanecimiento
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);

    // Inicia la animación
    _controller!.forward();

    // Navega a la pantalla de login después de un retraso
    _navigateToLogin();
  }

  // Navega a la pantalla de login después de la animación
  void _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 3)); // Espera 3 segundos
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation!,
          child: FadeTransition(
            opacity: _fadeAnimation!,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/assets/images/logo.png',
                    height:
                        120), // Asegúrate de que el logo esté en la ruta correcta
                SizedBox(height: 20),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0097b2)),
                ), // Indicador de carga
              ],
            ),
          ),
        ),
      ),
    );
  }
}
