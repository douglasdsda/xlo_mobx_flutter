class City {
  City({this.id, this.nome});

  factory City.fromJson(Map<String, dynamic> json) =>
      City(id: json["id"], nome: json['nome']);

  int? id;
  String? nome;

  @override
  String toString() {
    return "City{id: $id, nome: $nome}";
  }
}
