import 'package:flutter/material.dart';

class SplashNuevo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: new Image.asset('lib/images/inicio-app.jpg', fit: BoxFit.cover),
        alignment: Alignment.center,
      ),
    );
  }
}
