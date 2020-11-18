import 'package:flutter/material.dart';
import 'package:testapp/tabs/tab_inicio.dart';
import 'package:testapp/tabs/tab_categorias.dart';
import 'package:testapp/tabs/tab_buscar.dart';
import 'package:testapp/tabs/tab_ofertas.dart';

class NuevoHome extends StatefulWidget {
  NuevoHome({Key key}) : super(key: key);

  @override
  _NuevoHomeState createState() => _NuevoHomeState();
}

class _NuevoHomeState extends State<NuevoHome> {
  int _index = 0;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compro Aqui App',
      home: SafeArea(
        child: Scaffold(
          body: PageView(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() => _index = index);
            },
            children: [TabInicio(), TabCategorias(), TabBuscar(), TabOfertas()],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() => _index = index);
              _controller.animateToPage(_index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white30,
            currentIndex: _index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Inicio",
                  backgroundColor: Colors.pink[900]),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: "Categorías",
                  backgroundColor: Colors.pink[900]),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "Buscar",
                  backgroundColor: Colors.pink[900]),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_offer),
                  label: "Ofertas",
                  backgroundColor: Colors.orangeAccent)
            ],
          ),
        ),
      ),
    );
  }
}
