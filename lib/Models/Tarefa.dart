class Tarefa {
  final int? id;
  final String nome;
  final DateTime dataPrevistaConclusao;
  final DateTime? dataConclusao;
  final int? idUsuario;

  const Tarefa({
    this.id,
    required this.nome,
    required this.dataPrevistaConclusao,
    this.dataConclusao,
    this.idUsuario
  });

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'] as int?,
      nome: json['nome'] as String,
      dataPrevistaConclusao: DateTime.parse(json['dataPrevistaConclusao']) as DateTime,
      dataConclusao: json['dataConclusao'] == null ? json['dataConclusao'] : DateTime.parse(json['dataConclusao']) as DateTime?,
      idUsuario: json['idUsuario'] as int?,
    );
  }
}