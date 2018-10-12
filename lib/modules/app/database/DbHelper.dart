import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:forca_vendas/modules/app/migrations/Migrations.dart';

class DbHelper {
  
    static final DbHelper _instance = new DbHelper.internal();
    
    static final String dbname = 'app';

    factory DbHelper() => _instance;

    static Database _db;

    DbHelper.internal();

    Future<Database> get db async {
        
        if (_db != null) {
            return _db;
        }
        
        _db = await open();

        return _db;
    }

    open() async {

        /* !! Desabilitar em produção !! */
        Sqflite.devSetDebugModeOn(true);
        
        String path = await getPath();

        var db = await openDatabase(path, version: 1, onCreate: _onCreate);

        return db;
    }

    drop() async {
        
        String path = await getPath();

        await deleteDatabase(path);
    }

    Future getPath() async {
        
        String databasesPath = await getDatabasesPath();
        
        return join(databasesPath, dbname + '.db');
    }

    void _onCreate(Database db, int newVersion) async {

        Migrations migrations = new Migrations();

        migrations.onCreate(db, newVersion);
    }

    Future close() async {
        
        var dbClient = await db;
        
        return dbClient.close();
    }
}
