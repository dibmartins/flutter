import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';
import 'package:forca_vendas/modules/app/database/DbHelper.dart';


class Editar extends StatefulWidget {

    Editar({Key key}) : super(key: key);

    @override
    _EditarState createState() => new _EditarState();
}

class _EditarState extends State<Editar> {

    String nome; 
    String telefone;
    String email;
    String cidade;

    final scaffoldKey = new GlobalKey<ScaffoldState>();
    final formKey     = new GlobalKey<FormState>();
    
    List<String> _colors = <String> ['', 'red', 'green', 'blue', 'orange'];
    
    String _color = '';

    void _save() async {

        if (this.formKey.currentState.validate()) {
            formKey.currentState.save(); 
        }
        
        var cliente  = Cliente(nome,telefone,email);
        var dbhelper = new DbHelper();
        var client   = await dbhelper.db;

        await client.transaction((txn) async {
        
            int done = await txn.rawInsert('INSERT INTO clientes(nome, telefone, email) VALUES('
                     + '"'+ cliente.nome +'", "'
                     + cliente.telefone +'", "'
                     + cliente.email +'")');
        });
        
        //dbhelper.saveCliente(cliente);
        //_showSnackBar("Data saved successfully");

        showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
                title   : new Text('Salvo!'),
                content : new Text(cliente.nome),
            );
        });
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            
            key: scaffoldKey,
            
            appBar: AppBar(
                title: new Text('Novo cliente'),
                actions: <Widget>[

                    IconButton(
                        icon: Icon(Icons.check),
                        onPressed: _save,
                    ),
                ]
            ),
            
            body: new SafeArea(
                
                top    : false,
                bottom : false,
                
                child: new Form(
                    
                    key          : formKey,
                    autovalidate : true,
                    
                    child: new ListView(
                        
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        
                        children: <Widget>[
                  
                            new TextFormField(
                                autofocus : false,
                                decoration: const InputDecoration(
                                    icon      : const Icon(Icons.person),
                                    hintText  : 'Nome ou Razão Social',
                                    labelText : 'Nome',
                                ),
                                onSaved : (val) => this.nome = val,
                            ),
                        
                            new TextFormField(
                                keyboardType    : TextInputType.phone,
                                inputFormatters : [ WhitelistingTextInputFormatter.digitsOnly],
                                decoration: const InputDecoration(
                                    icon      : const Icon(Icons.phone),
                                    hintText  : '(xx) xxxxx-xxxx',
                                    labelText : 'Telefone',
                                ),
                                onSaved : (val) => this.telefone = val,
                            ),
                        
                            new TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    icon      : const Icon(Icons.email),
                                    hintText  : 'contato@cliente.com',
                                    labelText : 'Email',
                                ),
                                onSaved   : (val) => this.email = val,
                            ),
                        
                            new TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    icon      : const Icon(Icons.edit_location),
                                    hintText  : 'Informe a cidade',
                                    labelText : 'Cidade',
                                ),
                                onSaved   : (val) => this.cidade = val,
                            ),
                        ],
                    )
                )
            ),
        );
    }
}