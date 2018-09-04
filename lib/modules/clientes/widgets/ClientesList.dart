import 'package:flutter/material.dart';
import 'package:app/modules/clientes/models/Cliente.dart';

class ClientesList extends StatefulWidget {

    final model = new Cliente('Diego', 'dibmartins@gmail.com');
  
    ClientesList({Key key}) : super(key: key);

    @override
    _ClientesListState createState() => new _ClientesListState();
}

class _ClientesListState extends State<ClientesList> {

    void add() {
        
        AlertDialog alert = new AlertDialog(
            
            title   : new Text(widget.model.nome),
            content : new Text(widget.model.email),
        );
        
        showDialog(context: context, child: alert);
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
            
            appBar: new AppBar(title: new Text('Clientes')),
            
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
                child: new Icon(Icons.add),
                onPressed: add,
            )
        );
    }
}