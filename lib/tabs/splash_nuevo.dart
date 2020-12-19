import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class SplashNuevo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Container(
          child:
              new Image.asset('lib/images/inicio-app.jpg', fit: BoxFit.cover),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
