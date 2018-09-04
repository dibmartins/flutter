import 'package:flutter/material.dart';
import 'package:app/modules/home/widgets/Grafico1.dart';
import 'package:app/modules/home/widgets/Grafico2.dart';
import 'package:app/modules/home/widgets/Grafico3.dart';
import 'package:app/modules/clientes/widgets/ClientesList.dart';

class Home extends StatefulWidget {
  
    Home({Key key}) : super(key: key);

    @override
    _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

    void onSignedInError() {
        
        AlertDialog alert = new AlertDialog(
            
            title   : new Text("Sign in Error"),
            content : new Text("There was an error signing in. Please try again."),
        );
        
        showDialog(context: context, child: alert);
    }
  
    @override
    Widget build(BuildContext context) {

        List<Container> items = <Container>[
                
            Container(
                height: 250.0,
                child: new Padding(
                    padding: new EdgeInsets.all(8.0),
                    child: Card(child: new Grafico1.withSampleData())
                )
            ),           
                
            Container(
                height: 250.0,
                child: new Padding(
                    padding: new EdgeInsets.all(8.0),
                    child: Card(child: new Grafico2.withSampleData())
                )
            ),           
                
            Container(
                height: 250.0,
                child: new Padding(
                    padding: new EdgeInsets.all(8.0),
                    child: Card(child: new Grafico3.withSampleData())
                )
            ),           
        ];
        
        return Scaffold(

            appBar: new AppBar(title: new Text('Desempenho')),
            
            body: ListView.builder(
                
                itemCount   : items.length,
                itemBuilder : (context, index) {
                    
                    return items[index];
                },
            ),
            
            drawer: Drawer(
                
                child: ListView(
                
                    padding: EdgeInsets.zero,
                    
                    children: <Widget>[
                        
                        DrawerHeader(
                            child      : Text('G2 E SÁ SOLUÇÕES EM INFORMÁTICA LTDA', 
                            style      : new TextStyle(fontSize: 13.0, color: Colors.white)),
                            decoration : BoxDecoration(color: Colors.blue),
                        ),

                        ListTile(
                            
                            title: Text('Vendas'),
                            
                            onTap: () {
                                Navigator.pop(context);
                            },
                        ),
                        
                        ListTile(
                            
                            title: Text('Ordens de serviço'),
                            
                            onTap: () {
                                Navigator.pop(context);
                            },
                        ),

                        ExpansionTile(
                            
                            title: Text("Cadastros"),
                            
                            children: <Widget>[
                                
                                ListTile(
                                    title: Text('Produtos'),
                                    onTap: () {
                                        
                                        Navigator.pop(context);
                                    },
                                ),
                                
                                ListTile(
                                    title: Text('Clientes'),
                                    onTap: () {
                                        
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ClientesList()));

                                    },
                                ),
                                
                                ListTile(
                                    title: Text('Fornecedores'),
                                    onTap: () {
                                        Navigator.pop(context);
                                    },
                                ),
                            ],
                        ),
                    ],
                ),
            ),
            
            floatingActionButton: new FloatingActionButton(
                tooltip: 'Adicionar',
                child: new Icon(Icons.add),
                onPressed: onSignedInError,
            )
        );
    }

}