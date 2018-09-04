import 'package:flutter/material.dart';
import 'package:forca_vendas/modules/home/widgets/Grafico1.dart';
import 'package:forca_vendas/modules/home/widgets/Grafico2.dart';
import 'package:forca_vendas/modules/home/widgets/Grafico3.dart';
import 'package:forca_vendas/modules/clientes/widgets/ClientesList.dart';

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

                        new UserAccountsDrawerHeader(
                            decoration : BoxDecoration(
                                image: new DecorationImage(
                                    image: new NetworkImage('https://wallpaperstudio10.com/static/wpdb/wallpapers/3840x2160/170468.jpg'),
                                    fit: BoxFit.cover
                                ),
                                color: Colors.blue,
                            ),
                            accountName: new Text('Diego Botelho'),
                            accountEmail: new Text('dibmartins@gmail.com'),
                            currentAccountPicture: new GestureDetector(
                                onTap: () => print('Toque na imagem'),
                                child: new CircleAvatar(
                                    backgroundImage: new NetworkImage('https://www.w3schools.com/howto/img_avatar.png'),
                                )
                            )
                        ),

                        ListTile(
                            leading: const Icon(Icons.shopping_cart),
                            title: Text('Vendas'),
                            
                            onTap: () {
                                Navigator.pop(context);
                            },
                        ),
                        
                        ListTile(
                            leading: const Icon(Icons.restaurant),
                            title: Text('Despesas'),
                            
                            onTap: () {
                                Navigator.pop(context);
                            },
                        ),

                        ExpansionTile(
                            
                            leading: const Icon(Icons.style),
                            title: Text("Cadastros"),
                            
                            children: <Widget>[
                                
                                ListTile(
                                    leading: const Icon(Icons.person),
                                    title: Text('Clientes'),
                                    onTap: () {
                                        
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ClientesList()));

                                    },
                                ),
                                
                                ListTile(
                                    leading: const Icon(Icons.local_shipping),
                                    title: Text('Fornecedores'),
                                    onTap: () {
                                        Navigator.pop(context);
                                    },
                                ),

                                ListTile(
                                    leading: const Icon(Icons.widgets),
                                    title: Text('Produtos'),
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