class Cliente {
    
    int idCliente;
    String nome;
    String telefone;
    String email;
 
    Cliente(this.nome, this.telefone, this.email);
 
    Cliente.map(dynamic obj) {
        
        this.idCliente = obj['id_cliente'];
        this.nome      = obj['nome'];
        this.telefone  = obj['telefone'];
        this.email     = obj['email'];
    }

    Map<String, dynamic> toMap() {
        
        var map = new Map<String, dynamic>();
        
        if(idCliente != null) map['id_cliente'] = idCliente; 
        
        map['nome']     = nome;
        map['telefone'] = telefone;
        map['email']    = email;

        return map;
    }
 
    Cliente.fromMap(Map<String, dynamic> map) {
        
        this.idCliente = map['id_cliente'];
        this.nome      = map['nome'];
        this.telefone  = map['telefone'];
        this.email     = map['email'];
    }

    Cliente.fromJson(Map<String, dynamic> json){
        
        this.idCliente = json['id_cliente'];
        this.nome      = json['nome'];
        this.telefone  = json['telefone'];
        this.email     = json['email'];
    }
}