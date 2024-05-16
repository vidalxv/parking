class Estacionamento {
  String endereco;
  String nome;
  String foto;

  Estacionamento({
    required this.endereco,
    required this.nome,
    required this.foto,
  });

  Map<String, dynamic> toMap() {
    return {
      'endereco': endereco,
      'nome': nome,
      'foto': foto,
    };
  }

  factory Estacionamento.fromMap(Map<String, dynamic> map) {
    return Estacionamento(
      endereco: map['endereco'] ?? '',
      nome: map['nome'] ?? '',
      foto: map['foto'] ?? '',
    );
  }

  factory Estacionamento.fromFirestore(Map<String, dynamic> data) {
    return Estacionamento(
      endereco: data['endereco'] ?? '',
      nome: data['nome'] ?? '',
      foto: data['foto'] ?? '',
    );
  }
}
