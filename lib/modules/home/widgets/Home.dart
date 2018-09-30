import 'package:flutter/material.dart';
import 'package:forca_vendas/modules/home/widgets/Menu.dart';
import 'package:forca_vendas/modules/home/widgets/Grafico1.dart';
import 'package:forca_vendas/modules/home/widgets/Grafico2.dart';
import 'package:forca_vendas/modules/home/widgets/Grafico3.dart';

class Home extends StatefulWidget {
  
    Home({Key key}) : super(key: key);

    @override
    _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

    @override
    Widget build(BuildContext context) {

        List<Container> items = <Container>[
                
            Container(
                height: 250.0,
                child: new Padding(
                    padding: new EdgeInsets.all(8.0),
                    child: Card(child: new Grafico1.withSampleData())
                )
            ),           
                
            Container(
                height: 250.0,
                child: new Padding(
                    padding: new EdgeInsets.all(8.0),
                    child: Card(child: new Grafico2.withSampleData())
                )
            ),           
                
            Container(
                height: 250.0,
                child: new Padding(
                    padding: new EdgeInsets.all(8.0),
                    child: Card(child: new Grafico3.withSampleData())
                )
            ),           
        ];
        
        return Scaffold(

            appBar: new AppBar(title: new Text('Desempenho')),
            drawer: Menu(),
            
            body: ListView.builder(
                
                itemCount   : items.length,
                itemBuilder : (context, index) {
                    
                    return items[index];
                },
            ),
            
        );
    }

}