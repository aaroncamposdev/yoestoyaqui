import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    final bool nativeAppLaunchSucceeded = await launch(
      url,
      forceSafariVC: false,
      universalLinksOnly: true,
    );
    if (!nativeAppLaunchSucceeded) {
      await launch(
        url,
        forceSafariVC: true,
      );
    }
  } else {
    throw 'No se pudo abrir el link $url';
  }
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
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
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
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
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.pink[900] // foreground
                        ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.pink[900], // background
                    ),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text('Si, deseo salir'),
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
      body: SafeArea(
        child: WillPopScope(
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
                _launchInBrowser(request.url);
                return NavigationDecision.prevent;
              } else if (request.url.contains("instagram.com")) {
                _launchURL(request.url);
                return NavigationDecision.prevent;
              } else if (request.url.contains("facebook.com")) {
                _launchURL(request.url);
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
