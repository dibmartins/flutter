class Cliente {
    
    int _id;
    String _nome;
    String _email;
 
    int    get id    => _id;
    String get nome  => _nome;
    String get email => _email;
 
    Cliente(this._nome, this._email);
 
    Cliente.map(dynamic obj) {
        
        this._id    = obj['id'];
        this._nome  = obj['nome'];
        this._email = obj['email'];
    }

    Map<String, dynamic> toMap() {
        
        var map = new Map<String, dynamic>();
        
        if(_id != null) map['id'] = _id; 
        
        map['nome']  = _nome;
        map['email'] = _email;

        return map;
    }
 
    Cliente.fromMap(Map<String, dynamic> map) {
        
        this._id    = map['id'];
        this._nome  = map['nome'];
        this._email = map['email'];
    }
}