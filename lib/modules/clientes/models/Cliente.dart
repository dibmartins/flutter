class Cliente {
    
    int _idCliente;
    String _nome;
    String _telefone;
    String _email;
 
    int    get idCliente => _idCliente;
    String get nome      => _nome;
    String get telefone  => _email;
    String get email     => _email;
 
    Cliente(this._nome, this._telefone, this._email);
 
    Cliente.map(dynamic obj) {
        
        this._idCliente = obj['id_cliente'];
        this._nome      = obj['nome'];
        this._telefone  = obj['telefone'];
        this._email     = obj['email'];
    }

    Map<String, dynamic> toMap() {
        
        var map = new Map<String, dynamic>();
        
        if(_idCliente != null) map['id_cliente'] = _idCliente; 
        
        map['nome']     = _nome;
        map['telefone'] = _telefone;
        map['email']    = _email;

        return map;
    }
 
    Cliente.fromMap(Map<String, dynamic> map) {
        
        this._idCliente = map['id_cliente'];
        this._nome      = map['nome'];
        this._telefone  = map['telefone'];
        this._email     = map['email'];
    }

    Cliente.fromJson(Map<String, dynamic> json){
        
        this._idCliente = json['id_cliente'];
        this._nome      = json['name'];
        this._telefone  = json['telefone'];
        this._email     = json['email'];
    }
}