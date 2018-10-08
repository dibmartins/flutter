import 'package:flutter/material.dart';
import 'package:forca_vendas/modules/home/widgets/Home.dart';

class App extends StatelessWidget {

    @override
    Widget build(BuildContext context) {

        return new MaterialApp(
            
            title : 'Força de Vendas',
            theme : new ThemeData(primarySwatch: Colors.blue),
            home  : new Home(),
            
            debugShowCheckedModeBanner: false
        
        );
    }
}