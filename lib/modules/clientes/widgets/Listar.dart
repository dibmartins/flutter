import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forca_vendas/modules/clientes/widgets/Editar.dart';
import 'package:forca_vendas/modules/clientes/dao/ClienteDao.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';

class Listar extends StatefulWidget {

    Listar({Key key}) : super(key: key);

    @override
    _ListarState createState() => new _ListarState();
}

class _ListarState extends State<Listar> {

    final List<int> selected = new List();

    void toogleSelected(int idCliente) {
        
        setState(() {
            
            if(selected.contains(idCliente)){
                
                selected.remove(idCliente);
            
            }else{
                
                selected.add(idCliente);
            }
        });        
    }
    
    @override
    Widget build(BuildContext context) {

        String title = (selected.length > 0) ? selected.length.toString() : 'Clientes';
        Color bgColor = (selected.length > 0) ? Colors.green : Theme.of(context).accentColor;

        List<Widget> actions = [
            new IconButton(
                
                onPressed: () {

                },
                tooltip: 'Pesquisar',
                icon: new Icon(Icons.search),
            )
        ];

        List<Widget> selectedActions = [
            new IconButton(
                
                onPressed: () {

                    _delete();
                },
                tooltip: 'Remover',
                icon: new Icon(Icons.delete),
            )
        ];

        return Scaffold(
            appBar: new AppBar(
                
                title           : new Text(title),
                backgroundColor : bgColor,
                actions         : (selected.length > 0) ? selectedActions : actions,
            ),

            body: FutureBuilder<List<Cliente>>(
                future: _load(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                    switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                        case ConnectionState.done:
                            
                            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');

                            return ClienteList(clientes: snapshot.data, selected: selected, longPressCallback: toogleSelected);
                    }
                    
                    return null;
                }
            ),
            
            floatingActionButton: new FloatingActionButton(
                tooltip: 'Adicionar',
                child: new Icon(Icons.person_add),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Editar(cliente: new Cliente()))),
            )
        );
    }

    Future<List<Cliente>> _load() async {

        ClienteDao dao = new ClienteDao();

        return dao.fetch(['id_cliente', 'nome', 'telefone', 'email']);
    }

    Future<int> _delete() async {

        ClienteDao dao = new ClienteDao();

        return await dao.bulkDelete(selected);
    }
}

class ClienteList extends StatelessWidget {
    
    final List<Cliente> clientes;

    final List<int> selected;
    final longPressCallback;

    ClienteList({Key key, this.clientes, this.selected, this.longPressCallback}) : super(key: key);

    void onLongPress(int idCliente) {

        this.longPressCallback(idCliente);
    }

    @override
    Widget build(BuildContext context) {

        return ListView.builder(
            
            itemCount   : clientes.length,
            itemBuilder : (context, index) {

                CircleAvatar leading = (selected.contains(clientes[index].idCliente)) ? 
                    new CircleAvatar(
                        child: new Icon(Icons.check),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                    ) : 
                    new CircleAvatar(child: new Text(clientes[index].nome[0]));

                return new Column(
                    children: <Widget>[
                        ListTile(
                            
                            leading     : leading,
                            title       : Text(clientes[index].nome),
                            subtitle    : Text((clientes[index].email != null) ? clientes[index].email : ''),
                            onTap       : (){
                                
                                if(selected.length > 0){
                                    
                                    onLongPress(clientes[index].idCliente);
                                }
                                else{

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Editar(cliente: clientes[index])));
                                }
                            },
                            onLongPress : (){

                                onLongPress(clientes[index].idCliente);
                            }
                        ),

                        new Divider(height: 2.0)
                    ]
                );
            },
        );
    }
}