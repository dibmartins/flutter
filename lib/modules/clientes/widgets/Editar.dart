import 'package:flutter/material.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';
import 'package:dio/dio.dart';

class Editar extends StatefulWidget {

    final model = new Cliente('Diego', 'dibmartins@gmail.com');
  
    Editar({Key key}) : super(key: key);

    @override
    _EditarState createState() => new _EditarState();
}

class _EditarState extends State<Editar> {

    void _load() async {

        Dio dio = new Dio();
        
        Response response = await dio.get('https://swapi.co/api/people');
        
        print(response.data['results']);
    }

    void _save() {

        _load();

        AlertDialog alert = new AlertDialog(
            
            title   : new Text('Salvando...'),
            content : new Text(widget.model.nome),
        );
        
        showDialog(context: context, child: alert);
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            
            appBar: AppBar(
                title: new Text('Adicionar cliente'),
                actions: <Widget>[

                    IconButton(
                        icon: Icon(Icons.check),
                        onPressed: _save,
                    ),
                ]
            ),
            
            body: new Text('Cadastro'),
        );
    }
}