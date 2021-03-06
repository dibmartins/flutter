import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forca_vendas/modules/clientes/widgets/Editar.dart';
import 'package:forca_vendas/modules/clientes/dao/ClienteDao.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';

class Listar extends StatefulWidget {

    Listar({Key key}) : super(key: key);

    @override
    _ListarState createState() => new _ListarState();
}

class _ListarState extends State<Listar> with RouteAware{


    final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
    List<Cliente> clientes;
    final List<int> selected = new List();
    Future _loader;

    @override
    Widget build(BuildContext context) {

        String title = (selected.length > 0) ? selected.length.toString() : 'Clientes';
        Color bgColor = (selected.length > 0) ? Colors.green : Theme.of(context).accentColor;

        List<Widget> actions = [
            IconButton(
                
                onPressed: () {

                },
                tooltip: 'Pesquisar',
                icon: Icon(Icons.search),
            )
        ];

        List<Widget> selectedActions = [
            IconButton(
                
                onPressed : _delete,
                tooltip   : 'Remover',
                icon      : Icon(Icons.delete),
            )
        ];

        return Scaffold(
            appBar: AppBar(
                
                title           : Text(title),
                backgroundColor : bgColor,
                actions         : (selected.length > 0) ? selectedActions : actions,
            ),

            body: FutureBuilder<List<Cliente>>(
                future: _loader,
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                    switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                        case ConnectionState.done:
                            
                            if (snapshot.hasError) return new Text('Erro: ${snapshot.error}');

                            clientes = snapshot.data;

                            return ClienteList(clientes: clientes, selected: selected, longPressCallback: toogleSelected, changeCallback: refresh);
                    }
                    
                    return null;
                }
            ),
            
            floatingActionButton: new FloatingActionButton(
                tooltip: 'Adicionar',
                child: new Icon(Icons.person_add),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Editar(cliente: new Cliente()))),
            )
        );
    }

    @override
    void didChangeDependencies() {
        
        super.didChangeDependencies();
        
        routeObserver.subscribe(this, ModalRoute.of(context));
    }

    @override
    void dispose() {
        
        routeObserver.unsubscribe(this);
        
        super.dispose();
    }

    @override
    void didPush() {
        
        print('push');
    }

    @override
    void didPop() {
        
        print('pop');
    }

    initState() {
        
        super.initState();
        
        _loader = _load();
    }

    void toogleSelected(int idCliente) {
        
        setState(() {
            
            if(selected.contains(idCliente)){

                selected.remove(idCliente);
            
            }else{
                
                selected.add(idCliente);
            }
        });        
    }

    void refresh() {
        
        setState(() {
            _load();
        });        
    }

    Future<List<Cliente>> _load() async {

        ClienteDao dao = new ClienteDao();

        return dao.fetch(['id_cliente', 'nome', 'telefone', 'email']);
    }

    Future<int> _delete() async {

        ClienteDao dao = new ClienteDao();

        int result = await dao.bulkDelete(selected);

        setState(() {
            
            selected.forEach((id) => clientes.removeWhere((item) => item.idCliente == id));

            selected.clear();
        });

        return result;
    }
}

class ClienteList extends StatelessWidget {
    
    final List<Cliente> clientes;

    final List<int> selected;
    final longPressCallback;
    final changeCallback;

    ClienteList({Key key, this.clientes, this.selected, this.longPressCallback, this.changeCallback}) : super(key: key);

    void onLongPress(int idCliente) {

        this.longPressCallback(idCliente);
    }

    void onChangeCallback() {

        this.changeCallback();
    }

    @override
    Widget build(BuildContext context) {

        return ListView.builder(
            
            itemCount   : clientes.length,
            itemBuilder : (context, index) {

                CircleAvatar leading = (selected.contains(clientes[index].idCliente)) ? 
                    new CircleAvatar(
                        child: new Icon(Icons.check),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                    ) : 
                    new CircleAvatar(child: new Text(clientes[index].nome[0]));

                return new Column(
                    children: <Widget>[
                        ListTile(
                            
                            leading     : leading,
                            title       : Text(clientes[index].nome),
                            subtitle    : Text((clientes[index].email != null) ? clientes[index].email : ''),
                            onTap       : () async {
                                
                                if(selected.length > 0){
                                    
                                    onLongPress(clientes[index].idCliente);
                                }
                                else{

                                    Cliente cliente = await Navigator.push(context, MaterialPageRoute(builder: (context) => Editar(cliente: clientes[index])));

                                    onChangeCallback();
                                }
                            },
                            onLongPress : (){

                                onLongPress(clientes[index].idCliente);
                            }
                        ),

                        new Divider(height: 2.0)
                    ]
                );
            },
        );
    }
}