import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:router_control/router_control.dart';
import 'package:vihfi_control/src/settings.dart';

class InicioPage extends StatefulWidget {
  final Router router;

  InicioPage(this.router);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  TextEditingController _nomeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vih-Fi Control',
          style: GoogleFonts.mcLaren(fontSize: 17),
        ),
      ),
      body: Container(
        child: FutureBuilder(
            future: widget.router.getConnectedHosts(),
            builder: (context, AsyncSnapshot<List<DeviceHostModel>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: Text('Carregando...'),
                  );
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                             background: Container(
                               child: Padding(
                                 padding: const EdgeInsets.only(left: 12),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: <Widget>[
                                     Text("Permitir",style: GoogleFonts.mcLaren(fontSize: 18),),
                                   ],
                                 ),
                               ),
                               color: Colors.green),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        "Adicione este dispositivo a lista de permitidos\n(${snapshot.data[index].hostName})\n${snapshot.data[index].hostMac}"),
                                    content: Theme(
                                      data: ThemeData(
                                          primaryColor: Color(0xFF54b41d)),
                                      child: TextFormField(
                                        controller: _nomeController,
                                        decoration: InputDecoration(
                                          labelText: 'Nome do Dispositivo',
                                          labelStyle:
                                              TextStyle(color: Colors.white54),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              5.0, 20.0, 5.0, 5.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      // define os botões na base do dialogo
                                      FlatButton(
                                        child: Text("Cancelar"),
                                        onPressed: () {
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Adicionar"),
                                        onPressed: () async {
                                           await widget.router.addNewHostToAccessControl(_nomeController.value.text, snapshot.data[index].hostMac);
                                          _nomeController.clear();
                                          setState(() {
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              title: Text('(${snapshot.data[index].hostName}) ${snapshot.data[index].hostMac}'),
                              subtitle: getVendor(snapshot.data[index].hostMac)
                            ),
                            key: ValueKey('listMacs'),
                          );
                        });
                  } else if (snapshot.hasError) {
                  } else {}
                  break;
              }
              return Container();
            }),
      ),
    );
  }

  Widget getVendor(String mac){
    if(Settings.macVendors!=null){
     var vendorModel = Settings.macVendors[mac.substring(0,8)];
     if(vendorModel!=null){
       return Text(vendorModel.companyName);
     }else{
       return Text('Fabricante desconhecido');
     }
    }else{
      return null;
    }
  }
}
