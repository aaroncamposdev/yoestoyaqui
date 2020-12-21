import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class SplashNuevo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.pink[900], //or set color with: Color(0xFF0000FF)
        systemNavigationBarColor: Colors.pink[900]));
    return new Scaffold(
      body: new Container(
        child: new Image.asset(
          'lib/images/inicio-app.jpg',
          fit: BoxFit.fitHeight,
        ),
        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
    );
  }
}
