import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forca_vendas/modules/clientes/dao/ClienteDao.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';

class Editar extends StatelessWidget {

    final Cliente cliente;

    Editar({Key key, @required this.cliente}) : super(key: key);

    final scaffoldKey = new GlobalKey<ScaffoldState>();
    final formKey     = new GlobalKey<FormState>();
    final focusNode   = FocusNode();
    
    @override
    Widget build(BuildContext context) {

        return Scaffold(
            
            key: scaffoldKey,
            
            appBar: AppBar(
                title: new Text((cliente.idCliente == null) ? 'Novo Cliente' : 'Editar Cliente'),
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
                                autofocus    : true,
                                focusNode    : focusNode,
                                initialValue : cliente.nome,
                                decoration : const InputDecoration(
                                    icon      : const Icon(Icons.person),
                                    hintText  : 'Nome ou Razão Social',
                                    labelText : 'Nome',
                                ),
                                onSaved : (val) => cliente.nome = val,
                            ),
                        
                            new TextFormField(
                                keyboardType    : TextInputType.phone,
                                inputFormatters : [ WhitelistingTextInputFormatter.digitsOnly],
                                initialValue    : cliente.telefone,
                                decoration: const InputDecoration(
                                    icon      : const Icon(Icons.phone),
                                    hintText  : '(xx) xxxxx-xxxx',
                                    labelText : 'Telefone',
                                ),
                                onSaved : (val) => cliente.telefone = val,
                            ),
                        
                            new TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                initialValue    : cliente.email,
                                decoration: const InputDecoration(
                                    icon      : const Icon(Icons.email),
                                    hintText  : 'contato@cliente.com',
                                    labelText : 'Email',
                                ),
                                onSaved   : (val) => cliente.email = val,
                            )
                        ],
                    )
                )
            ),
        );
    }

    void _save() async {

        if(this.formKey.currentState.validate()) {
            
            formKey.currentState.save();
        }
        
        ClienteDao dao = new ClienteDao();

        if(cliente == null){
            
            dao.save(cliente);
        }
        else{
            
            await dao.update(cliente);
        }
        
        scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Salvo!'),
            action: SnackBarAction(
              label: 'Novo',
              onPressed: () {

                    formKey.currentState.reset();

                    //FocusScope.of(context).requestFocus(focusNode);
              },
            ),
        ));
    }

}