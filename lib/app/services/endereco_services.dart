import 'package:cuidapet_curso/app/repository/endereco_repository.dart';

class EnderecoServices {
  final EnderecoRepository _repository;
  EnderecoServices(
    this._repository,
  );

  Future<bool> existeEnderecoCadastrado() async {
    var listaEnderecos = await _repository.buscarEnderecos();
    return listaEnderecos.isEmpty;
  }
}
