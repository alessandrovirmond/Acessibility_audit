import 'dart:convert';
import 'package:accessibility_audit/config.dart';
import 'package:accessibility_audit/report/model/violation_model.dart';
import 'package:flutter/services.dart';

class ViolationRepository {
  final String localPath;

  ViolationRepository({this.localPath = 'assets/relatorio_acessibilidade.json'});

  // Método para buscar dados de violações com base no subdomínio fornecido
  Future<List<ViolationModel>> get() async {
    try {
      final String response = await rootBundle.loadString(localPath);
      final Map<String, dynamic> data = json.decode(response);

      // Busca pelo subdomínio especificado
      final subdomainData = data.entries
          .firstWhere(
            (entry) => entry.key == Config.id,
            orElse: () => MapEntry('', {}),
          )
          ?.value;

      if (subdomainData == null) {
        print("Subdomínio não encontrado: ${Config.id}");
        return [];
      }
final violations = data.entries
    .expand((entry) {
      final sub = entry.value; // Acessa o valor do MapEntry
      if (sub is Map<String, dynamic>) {
        // Verifica se o valor é um mapa
        return (sub['subdominios'] as List<dynamic>?)
            ?.expand((subdomain) => (subdomain['violacoes'] as List<dynamic>?) ?? [])
            ?? [];
      }
      return [];
    })
    .toList();



      // Converte os dados em uma lista de ViolationModel usando fromJson
      final List<ViolationModel> violationList = violations.map((violation) {
        return ViolationModel.fromJson(violation);
      }).toList();

      return violationList;
    } catch (e) {
      print("Erro ao carregar violações: $e");
      rethrow;
    }
  }
}
