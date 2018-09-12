import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';
import 'package:forca_vendas/modules/clientes/widgets/Editar.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';
import 'package:dio/dio.dart';

List<Cliente> parseClientes(results) {

    final parsed = results.cast<Map<String, dynamic>>();

    return parsed.map<Cliente>((json) => Cliente.fromJson(json)).toList();
}

Future<List<Cliente>> _load() async {

    Dio dio = new Dio();
    
    Response response = await dio.get('https://swapi.co/api/people');

    return compute(parseClientes, response.data['results']);
}

class Listar extends StatefulWidget {

    final model = new Cliente('Diego', 'dibmartins@gmail.com');
  
    Listar({Key key}) : super(key: key);

    @override
    _ListarState createState() => new _ListarState();
}

class _ListarState extends State<Listar> {

    final _names =  [
        'Igor Minar',
        'Brad Green',
        'Dave Geddes',
        'Naomi Black',
        'Greg Weber',
        'Dean Sofer',
        'Wes Alvaro',
        'John Scott',
        'Daniel Nadasi',
    ];

    String _name = 'No one';

    final _formKey = new GlobalKey<FormState>();

    _buildMaterialSearchPage(BuildContext context) {
        
        return new MaterialPageRoute<String>(
            
            settings: new RouteSettings(
                name           : 'material_search',
                isInitialRoute : false,
            ),
            
            builder: (BuildContext context) {
                
                return new Material(
                    
                    child: new MaterialSearch<String>(
                        
                        placeholder: 'Pesquisa',
                        
                        results: _names.map((String v) => new MaterialSearchResult<String>(
                            icon: Icons.person,
                            value: v,
                            text: "Mr(s). $v",
                        )).toList(),
                        
                        filter: (dynamic value, String criteria) {
                            
                            return value.toLowerCase().trim()
                                .contains(new RegExp(r'' + criteria.toLowerCase().trim() + ''));
                        },
                        
                        onSelect: (dynamic value) => Navigator.of(context).pop(value),
                        onSubmit: (String value) => Navigator.of(context).pop(value),
                    ),
                );
            }
        );
    }    

    _showMaterialSearch(BuildContext context) {
        Navigator.of(context)
        .push(_buildMaterialSearchPage(context))
        .then((dynamic value) {
            setState(() => _name = value as String);
        });
    }

    void _add() {

        Navigator.push(context, MaterialPageRoute(builder: (context) => Editar()));
    }

    var items;
  
    @override
    Widget build(BuildContext context) {

        return Scaffold(
            
            appBar: new AppBar(
                title: new Text('Clientes'),

                actions: <Widget>[
                    new IconButton(
                        onPressed: () {
                            _showMaterialSearch(context);
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
                );
            },
        );
    }
}