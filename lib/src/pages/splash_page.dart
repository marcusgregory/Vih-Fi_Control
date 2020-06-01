import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:router_control/router_control.dart';
import 'package:upnp/upnp.dart' as upnp;
import 'package:vihfi_control/src/util/load_macs.dart';
import 'package:worker2/worker2.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Worker worker = Worker();
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void initPlatformState() async {
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/icon_rounded.png',
                scale: 4,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Vih-Fi Control',
              style: GoogleFonts.mcLaren(
                  textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              child: FutureBuilder(
                  future: Future.wait([findRouter(),LoadMacDatabaseAsset.load()],eagerError: true),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return CircularProgressIndicator(
                          value: 0,
                        );
                        break;
                      case ConnectionState.waiting:
                        return Center(
                          //child: Text('Procurando roteadores aguarde...'),
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Color(0xFF54b41d)),
                            //backgroundColor: Color(0xFFb9d94a),
                          ),
                        );
                        break;
                      case ConnectionState.active:
                        return CircularProgressIndicator(
                          value: 0,
                        );
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          _nextPage(context, snapshot.data[0]);
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(left: 80, right: 80),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'Não foi possível encontrar o Roteador na sua rede local.',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.refresh),
                                ),
                              ],
                            ),
                          );
                        }
                        break;
                    }
                    return CircularProgressIndicator(
                      value: 0,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

void _nextPage(BuildContext context, upnp.Device device) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(device)),
    );
  });
}
