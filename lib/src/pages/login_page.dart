import 'package:flutter/material.dart';
import 'package:router_control/router_control.dart';
import 'package:upnp/upnp.dart';
import 'package:vihfi_control/src/pages/inicio_page.dart';

class LoginPage extends StatefulWidget {
  final Device device;
  LoginPage(this.device);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var _loading = false;
  TextEditingController _usuarioController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/icon_rounded.png',
                scale: 5,
              ),
              SizedBox(
                height: 40,
              ),
              Theme(
                data: ThemeData(primaryColor: Color(0xFF54b41d)),
                child: TextFormField(
                  controller: _usuarioController,
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    labelStyle: TextStyle(color: Colors.white54),
                    contentPadding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Theme(
                data: ThemeData(primaryColor: Color(0xFF54b41d)),
                child: TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.white54),
                    contentPadding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 5.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
                    try {
                      setState(() {
                        _loading = true;
                      });
                      var router = await loginRouter(
                          widget.device,
                          _usuarioController.value.text,
                          _senhaController.value.text);
                   
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InicioPage(router)),
                      );
                    } catch (ex) {
                      if (ex is FormatException) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(ex.message),
                        ));
                      } else {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(ex.toString()),
                        ));
                      }
                    } finally {
                      setState(() {
                        _loading = false;
                      });
                    }
                  },
                  padding: EdgeInsets.all(13),
                  color: Color(0xFF54b41d),
                  child: Text(!_loading ? 'Entrar' : 'Entrando...',
                      style: TextStyle(fontSize: 18, color: Colors.white70)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
