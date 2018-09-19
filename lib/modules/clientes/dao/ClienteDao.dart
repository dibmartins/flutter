import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:forca_vendas/modules/app/database/DbHelper.dart';
import 'package:forca_vendas/modules/clientes/models/Cliente.dart';

class ClienteDao {
    
    final DbHelper database = new DbHelper();

    Database _connection;

    Database get connection => _connection;
    
    final String sourceTable = 'clientes';
    final String idCliente   = 'id_cliente';
    final String nome        = 'title';
    final String telefone    = 'telefone';
    final String email       = 'email';

    Future<int> save(Cliente model) async {

        _connection = await database.db;
        
        return await connection.insert(sourceTable, model.toMap());
    }
    
    Future<int> update(Cliente model) async {

        _connection = await database.db;
        
        return await connection.update(sourceTable, model.toMap(), where: "$idCliente = ?", whereArgs: [model.idCliente]);
    }

    Future<int> delete(int id) async {

        _connection = await database.db;
        
        return await connection.delete(sourceTable, where: '$idCliente = ?', whereArgs: [id]);
    }
    
    Future<List> fetch(List<String> columns) async {

        _connection = await database.db;
        
        var result = await connection.query(sourceTable, columns: columns);
    
        return result.toList();
    }
    
    Future<Cliente> findFirst(int id, List<String> columns) async {

        _connection = await database.db;
        
        List<Map> result = await connection.query(
            sourceTable,
            columns: columns,
            where: '$idCliente = ?',
            whereArgs: [id]
        );
    
        if (result.length <= 0) return null;
            
        return new Cliente.fromMap(result.first);
    }

    Future<int> count() async {

        _connection = await database.db;
        
        return Sqflite.firstIntValue(await connection.rawQuery('SELECT COUNT(*) FROM $sourceTable'));
    }
    
    Future close() async {

        _connection = await database.db;
        
        return connection.close();
    }
}