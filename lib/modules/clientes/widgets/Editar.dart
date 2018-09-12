import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';

class Editar extends StatefulWidget {

    final model = new Cliente('Diego', 'dibmartins@gmail.com');
  
    Editar({Key key}) : super(key: key);

    @override
    _EditarState createState() => new _EditarState();
}

class _EditarState extends State<Editar> {

    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    
    List<String> _colors = <String> ['', 'red', 'green', 'blue', 'orange'];
    
    String _color = '';

    void _save() {

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
                    
                    key          : _formKey,
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
                            ),
                        
                            new TextFormField(
                                keyboardType    : TextInputType.phone,
                                inputFormatters : [ WhitelistingTextInputFormatter.digitsOnly],
                                decoration: const InputDecoration(
                                    icon      : const Icon(Icons.phone),
                                    hintText  : '(xx) xxxxx-xxxx',
                                    labelText : 'Telefone',
                                ),
                            ),
                        
                            new TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    icon      : const Icon(Icons.email),
                                    hintText  : 'contato@cliente.com',
                                    labelText : 'Email',
                                ),
                            ),
                        
                            new TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    icon      : const Icon(Icons.edit_location),
                                    hintText  : 'Informe a cidade',
                                    labelText : 'Cidade',
                                ),
                            ),
                        ],
                    )
                )
            ),
        );
    }
}