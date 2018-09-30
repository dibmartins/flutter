import 'package:flutter/material.dart';
import 'package:forca_vendas/modules/clientes/widgets/Listar.dart'     as clientes;
import 'package:forca_vendas/modules/fornecedores/widgets/Listar.dart' as fornecedores;

class Menu extends StatefulWidget {
  
    Menu({Key key}) : super(key: key);

    @override
    _MenuState createState() => new _MenuState();
}

class _MenuState extends State<Menu> {

    @override
    Widget build(BuildContext context) {

        return Drawer(
                
                child: ListView(
                
                    padding: EdgeInsets.zero,
                    
                    children: <Widget>[

                        new UserAccountsDrawerHeader(
                            decoration : BoxDecoration(
                                image: new DecorationImage(
                                    image: AssetImage('assets/images/user/background.jpg'),
                                    fit: BoxFit.cover
                                ),
                                color: Colors.blue,
                            ),
                            accountName: new Text('Diego Botelho'),
                            accountEmail: new Text('dibmartins@gmail.com'),
                            currentAccountPicture: new GestureDetector(
                                onTap: () => print('Toque na imagem'),
                                child: new CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/user/avatar.png'),
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
                                        
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => clientes.Listar()));

                                    },
                                ),
                                
                                ListTile(
                                    leading: const Icon(Icons.local_shipping),
                                    title: Text('Fornecedores'),
                                    onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => fornecedores.Listar()));
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
            );
    }

}