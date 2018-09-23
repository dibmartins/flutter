import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forca_vendas/modules/clientes/dao/ClienteDao.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';

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

    Cliente cliente;
    final scaffoldKey = new GlobalKey<ScaffoldState>();
    final formKey     = new GlobalKey<FormState>();
    final focusNode   = FocusNode();
    
    List<String> _colors = <String> ['', 'red', 'green', 'blue', 'orange'];
    
    String _color = '';

    void _save() async {

        if(this.formKey.currentState.validate()) {
            
            formKey.currentState.save();
        }
        
        ClienteDao dao = new ClienteDao();

        if(cliente == null){
            
            cliente = Cliente(nome,telefone,email);

            dao.save(cliente);
        }
        else{
            
            cliente = await dao.update(cliente);
        }
        
        scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Salvo!'),
            action: SnackBarAction(
              label: 'Novo',
              onPressed: () {

                    formKey.currentState.reset();

                    FocusScope.of(context).requestFocus(focusNode);
              },
            ),
        ));
    }

    @override
    void dispose() {
        
        focusNode.dispose();
        
        super.dispose();
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
                                autofocus  : true,
                                focusNode  : focusNode,
                                decoration : const InputDecoration(
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