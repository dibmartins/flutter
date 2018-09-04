import 'package:flutter/material.dart';
import 'package:app/modules/clientes/models/Cliente.dart';
import 'package:app/modules/home/widgets/Home.dart';

class App extends StatelessWidget {

    @override
    Widget build(BuildContext context) {

        return new MaterialApp(
            
            title : 'Prosimples',
            theme : new ThemeData(primarySwatch: Colors.blue),
            home  : new Home(),
        );
    }
}