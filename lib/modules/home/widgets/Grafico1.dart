import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Grafico1 extends StatelessWidget {
    
    final List<charts.Series> seriesList;
    final bool animate;

    Grafico1(this.seriesList, {this.animate});

    factory Grafico1.withSampleData() {

        return new Grafico1(
            
            _createSampleData(),
            
            animate: false,
        );
    }

    @override
    Widget build(BuildContext context) {

        return new charts.BarChart(
            seriesList,
            animate : animate,
            barGroupingType : charts.BarGroupingType.grouped,
        );
    }

    static List<charts.Series<OrdinalSales, String>> _createSampleData() {
        
        final desktopSalesData = [
            new OrdinalSales('2014', 5),
            new OrdinalSales('2015', 25),
            new OrdinalSales('2016', 100),
            new OrdinalSales('2017', 75),
        ];

        final tableSalesData = [
            new OrdinalSales('2014', 25),
            new OrdinalSales('2015', 50),
            new OrdinalSales('2016', 10),
            new OrdinalSales('2017', 20),
        ];

        final mobileSalesData = [
            new OrdinalSales('2014', 10),
            new OrdinalSales('2015', 15),
            new OrdinalSales('2016', 50),
            new OrdinalSales('2017', 45),
        ];

        return [
            
            new charts.Series<OrdinalSales, String>(
                id        : 'Desktop',
                domainFn  : (OrdinalSales sales, _) => sales.year,
                measureFn : (OrdinalSales sales, _) => sales.sales,
                data      : desktopSalesData,
            ),
            
            new charts.Series<OrdinalSales, String>(
                id            : 'Tablet',
                domainFn      : (OrdinalSales sales, _) => sales.year,
                measureFn     : (OrdinalSales sales, _) => sales.sales,
                data          : tableSalesData,
                fillPatternFn : (OrdinalSales sales, _) => charts.FillPatternType.forwardHatch,
            ),
            
            new charts.Series<OrdinalSales, String>(
                id        : 'Mobile',
                domainFn  : (OrdinalSales sales, _) => sales.year,
                measureFn : (OrdinalSales sales, _) => sales.sales,
                data      : mobileSalesData,
            ),
        ];
    }
}

class OrdinalSales {

    final String year;
    final int sales;

    OrdinalSales(this.year, this.sales);
}