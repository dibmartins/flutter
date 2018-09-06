import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';
import 'package:forca_vendas/modules/clientes/widgets/Editar.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';
import 'package:dio/dio.dart';

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

    List<Cliente> items;

    void _load() async {

        Dio dio = new Dio();
        
        Response response = await dio.get('https://swapi.co/api/people');

        items = response.data['results'];
    }
  
    @override
    Widget build(BuildContext context) {

        List<Cliente> items = <Cliente>[
            
            new Cliente('Antônio Abreu' , 'antonio.abreu@example.com'),            
            new Cliente('Mariana Abreu' , 'mariana.abreu@example.com'),            
            new Cliente('Doca Abreu'    , 'doca.abreu@example.com'),            
            new Cliente('Everardo Abreu', 'everardo.abreu@example.com'),            
            new Cliente('Antônio Abreu' , 'antonio.abreu@example.com'),            
            new Cliente('Mariana Abreu' , 'mariana.abreu@example.com'),            
            new Cliente('Doca Abreu'    , 'doca.abreu@example.com'),            
            new Cliente('Everardo Abreu', 'everardo.abreu@example.com'),            
            new Cliente('Antônio Abreu' , 'antonio.abreu@example.com'),            
            new Cliente('Mariana Abreu' , 'mariana.abreu@example.com'),            
            new Cliente('Doca Abreu'    , 'doca.abreu@example.com'),            
            new Cliente('Everardo Abreu', 'everardo.abreu@example.com'),            
            new Cliente('Antônio Abreu' , 'antonio.abreu@example.com'),            
            new Cliente('Mariana Abreu' , 'mariana.abreu@example.com'),            
            new Cliente('Doca Abreu'    , 'doca.abreu@example.com'),            
            new Cliente('Everardo Abreu', 'everardo.abreu@example.com'),            
            new Cliente('Antônio Abreu' , 'antonio.abreu@example.com'),            
            new Cliente('Mariana Abreu' , 'mariana.abreu@example.com'),            
            new Cliente('Doca Abreu'    , 'doca.abreu@example.com'),            
            new Cliente('Everardo Abreu', 'everardo.abreu@example.com'),            
        ];

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
            
            body: ListView.builder(
                
                itemCount   : items.length,
                itemBuilder : (context, index) {
                    
                    return ListTile(
                        leading  : new CircleAvatar(child: new Text(items[index].nome[0])),
                        title    : Text(items[index].nome),
                        subtitle : Text(items[index].email),
                    );
                },
            ),
            
            floatingActionButton: new FloatingActionButton(
                tooltip: 'Adicionar',
                child: new Icon(Icons.person_add),
                onPressed: _add,
            )
        );
    }
}