import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceWebView: false, enableJavaScript: true, enableDomStorage: true);
  } else {
    throw 'No se pudo abrir el link $url';
  }
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'header_key': 'header_value'},
    );
  } else {
    throw 'No se pudo abrir el link $url';
  }
}

// ignore: must_be_immutable
class HomeTabs extends StatefulWidget {
  int currentTabIndex = 0;

  @override
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  final List<String> _urls = [
    'https://yoestoyaqui.cl/aplicacion-movil',
    'https://yoestoyaqui.cl/categorias',
    'https://yoestoyaqui.cl/explorar',
    'https://yoestoyaqui.cl/promociones'
  ];

  WebViewController _webController;


  Future<void> _onWillPop(BuildContext context) async {
    print("onwillpop");
    if (await _webController.canGoBack()) {
      _webController.goBack();
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('¿Deseas salir de la aplicación?'),
                actions: <Widget>[
                  FlatButton(
                    color: Colors.pink[900],
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                  FlatButton(
                    textColor: Colors.pink[900],
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text('Si'),
                  ),
                ],
              ));
    }
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    print('<----- build init ----->');

    return Scaffold(
      body: WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: WebView(
          initialUrl: _urls[widget.currentTabIndex],
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains("tel:")) {
              _launchURL(request.url);
              return NavigationDecision.prevent;
            } else if (request.url.contains("whatsapp:")) {
              _launchURL(request.url);
              return NavigationDecision.prevent;
            } else if (request.url.contains("mailto:")) {
              _launchURL(request.url);
              return NavigationDecision.prevent;
            } else if (request.url.contains("instagram.com")) {
              _launchInBrowser(request.url);
              return NavigationDecision.prevent;
            } else if (request.url.contains("facebook.com")) {
              _launchInBrowser(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webController) {
            _webController = webController;
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentTabIndex,
        onTap: (selectedIndex) {
          _webController.loadUrl(_urls[selectedIndex]);

          setState(() {
            widget.currentTabIndex = selectedIndex;
            print('$selectedIndex Selected!');
          });
        },
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
