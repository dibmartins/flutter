import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forca_vendas/modules/clientes/widgets/Editar.dart';
import 'package:forca_vendas/modules/clientes/dao/ClienteDao.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';

List<Cliente> parseClientes(results) {

    final parsed = results.cast<Map<String, dynamic>>();

    return parsed.map<Cliente>((json) => Cliente.fromJson(json)).toList();
}

Future<List<Cliente>> _load() async {

    ClienteDao dao = new ClienteDao();

    Future<List<Cliente>> recordset = dao.fetch(['id_cliente', 'nome', 'telefone', 'email']);

    return recordset;
}

class Listar extends StatefulWidget {

    Listar({Key key}) : super(key: key);

    @override
    _ListarState createState() => new _ListarState();
}

class _ListarState extends State<Listar> {

    var items;
  
    @override
    Widget build(BuildContext context) {

        return Scaffold(
            
            appBar: new AppBar(
                title: new Text('Clientes'),

                actions: <Widget>[
                    new IconButton(
                        onPressed: () {
                        },
                        tooltip: 'Pesquisar',
                        icon: new Icon(Icons.search),
                    )
                ],
            ),

            body: FutureBuilder<List<Cliente>>(
                future: _load(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                    switch (snapshot.connectionState) {
                        case ConnectionState.none: return new Text('Press button to start.');
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                        case ConnectionState.done:
                            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');

                            return ClienteList(clientes: snapshot.data);
                    }
                    
                    return null;
                }
            ),
            
            floatingActionButton: new FloatingActionButton(
                tooltip: 'Adicionar',
                child: new Icon(Icons.person_add),
                onPressed: _add,
            )
        );
    }

    void _add() {

        Navigator.push(context, MaterialPageRoute(builder: (context) => Editar(cliente: new Cliente())));
    }
}

class ClienteList extends StatelessWidget {
    
    final List<Cliente> clientes;

    ClienteList({Key key, this.clientes}) : super(key: key);

    @override
    Widget build(BuildContext context) {

        return ListView.builder(
            
            itemCount   : clientes.length,
            itemBuilder : (context, index) {

                return ListTile(
                    
                    leading  : new CircleAvatar(child: new Text(clientes[index].nome[0])),
                    title    : Text(clientes[index].nome),
                    subtitle : Text((clientes[index].email != null) ? clientes[index].email : ''),
                    onTap    : () => Navigator.push(context,MaterialPageRoute(builder: (context) => Editar(cliente: clientes[index]))),
                );
            },
        );
    }
}