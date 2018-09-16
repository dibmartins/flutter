class Cliente {
    
    int _id_cliente;
    String _nome;
    String _email;
 
    int    get id    => _id_cliente;
    String get nome  => _nome;
    String get email => _email;
 
    Cliente(this._nome, this._email);
 
    Cliente.map(dynamic obj) {
        
        this._id_cliente    = obj['id'];
        this._nome  = obj['nome'];
        this._email = obj['email'];
    }

    Map<String, dynamic> toMap() {
        
        var map = new Map<String, dynamic>();
        
        if(_id_cliente != null) map['id'] = _id_cliente; 
        
        map['nome']  = _nome;
        map['email'] = _email;

        return map;
    }
 
    Cliente.fromMap(Map<String, dynamic> map) {
        
        this._id_cliente = map['id'];
        this._nome       = map['nome'];
        this._email      = map['email'];
    }

    Cliente.fromJson(Map<String, dynamic> json){
        
        this._id_cliente = json['id'];
        this._nome       = json['name'];
        this._email      = json['email'];
    }
}