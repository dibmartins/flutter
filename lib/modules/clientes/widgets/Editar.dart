import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forca_vendas/modules/clientes/dao/ClienteDao.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Editar extends StatefulWidget {
    
    final Cliente cliente;

    Editar({Key key, @required this.cliente}) : super(key: key);
  
    @override
    State<StatefulWidget> createState() => new EditarState();
}

class EditarState extends State<Editar> {

    final scaffoldKey = new GlobalKey<ScaffoldState>();
    final formKey     = new GlobalKey<FormState>();
    final focusNode   = FocusNode();

    var telefoneController = new MaskedTextController(mask: '(00) 00000-0000');
    
    @override
    Widget build(BuildContext context) {

        return Scaffold(
            
            key: scaffoldKey,
            
            appBar: AppBar(
                title: new Text((widget.cliente.idCliente == null) ? 'Novo Cliente' : 'Editar Cliente'),
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
                                initialValue : widget.cliente.nome,
                                decoration : const InputDecoration(
                                    icon      : const Icon(Icons.person),
                                    hintText  : 'Nome ou Razão Social',
                                    labelText : 'Nome',
                                ),
                                validator: (val) => val.isEmpty ? 'Obrigatório' : null,
                                onSaved : (val) => widget.cliente.nome = val,
                            ),
                        
                            new TextFormField(
                                controller      : telefoneController,
                                keyboardType    : TextInputType.phone,
                                inputFormatters : [ WhitelistingTextInputFormatter.digitsOnly],
                                initialValue    : widget.cliente.telefone,
                                decoration: const InputDecoration(
                                    icon      : const Icon(Icons.phone),
                                    hintText  : '(xx) xxxxx-xxxx',
                                    labelText : 'Telefone',
                                ),
                                onSaved : (val) => widget.cliente.telefone = val,
                            ),
                        
                            new TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                initialValue    : widget.cliente.email,
                                decoration: const InputDecoration(
                                    icon      : const Icon(Icons.email),
                                    hintText  : 'voce@exemplo.com',
                                    labelText : 'Email',
                                ),
                                validator : (val) => validateEmail(val),
                                onSaved   : (val) => widget.cliente.email = val,
                            )
                        ],
                    )
                )
            ),
        );
    }

    String validateEmail(String value) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(value))
        return 'Inválido';
        else
        return null;
    }

    void _save() async {

        if(this.formKey.currentState.validate()) {
            
            formKey.currentState.save();
        }
        
        ClienteDao dao = new ClienteDao();

        if(widget.cliente.idCliente == null){
            
            widget.cliente.idCliente = await dao.save(widget.cliente);
        }
        else{
            
            await dao.update(widget.cliente);
        }
        
        scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Salvo!'),


            action: SnackBarAction(
                label: 'Novo',
                onPressed: () {

                    formKey.currentState.reset();
                },
            ),
        ));
    }

}