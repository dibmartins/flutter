import 'package:sqflite/sqflite.dart';

class Migrations{

    static Database _db;
    static int _version;

    void onCreate(Database db, int version) async {

        _db      = db;
        _version = version;

        print('Criando banco de dados');
        
        print('Criando tabela clientes');
        await db.execute("CREATE TABLE `clientes` (`id_cliente` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, `nome` TEXT NOT NULL, `telefone` TEXT,`email` TEXT);");
        
        print('Criando tabela fornecedores');
        await db.execute("CREATE TABLE `fornecedores` (`id_fornecedor` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, `nome` TEXT NOT NULL, `telefone`	TEXT,`email` TEXT);");
    }
}