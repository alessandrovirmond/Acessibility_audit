import json

# Definindo pesos para os níveis de impacto
PESO_IMPACTO = {
    "crítico": 7,
    "grave": 5,
    "moderado": 3,
    "menor": 1
}

# Valor de normalização K para ajustar a escala da nota final
K = 100

def calcular_nota_acessibilidade(caminho_arquivo_json, caminho_saida_json):
    # Carrega o JSON do arquivo
    with open(caminho_arquivo_json, 'r', encoding='utf-8') as f:
        dados = json.load(f)
    
    # Estrutura para armazenar os resultados
    relatorio = {}
    
    # Itera sobre cada domínio no JSON
    for dominio, info in dados.items():
        print(f"\n=========================================")
        print(f"Calculando notas para o domínio: {dominio}")
        print(f"=========================================")
        
        subdominios = info.get("subdominios", [])
        notas_subdominios = []
        total_violacoes_dominio = 0
        total_elementos_afetados_dominio = 0
        
        # Estrutura para armazenar os detalhes do domínio
        relatorio_dominio = {
            "notas_paginas": [],
            "total_violacoes": 0,
            "media_violacoes_por_pagina": 0,
            "media_elementos_afetados_por_pagina": 0
        }
        
        # Calcula a nota de cada Página
        for subdominio in subdominios:
            severidade_total = 0
            violacoes = subdominio.get("violacoes", [])
            total_violacoes_subdominio = len(violacoes)
            total_elementos_afetados_subdominio = 0
            
            for violacao in violacoes:
                # Obtem o peso do impacto
                nivel_impacto = violacao.get("nivel_impacto", "").lower()
                peso = PESO_IMPACTO.get(nivel_impacto, 0)
                
                # Calcula a severidade da violação com base no peso e número de elementos afetados
                elementos_afetados = violacao.get("elementos_afetados", [])
                severidade_violacao = peso * len(elementos_afetados)
                total_elementos_afetados_subdominio += len(elementos_afetados)
                
                # Soma a severidade da violação à severidade total do Página
                severidade_total += severidade_violacao
            
            # Atualiza os totais para o domínio
            total_violacoes_dominio += total_violacoes_subdominio
            total_elementos_afetados_dominio += total_elementos_afetados_subdominio
            
            # Calcula a nota do Página
            nota_subdominio = max(1, 10 - (severidade_total / K))
            notas_subdominios.append(nota_subdominio)
            
            # Adiciona os detalhes do Página ao relatório do domínio
            relatorio_dominio["notas_paginas"].append({
                "nome_pagina": subdominio.get("subdominio", "Desconhecido"),
                "nota": round(nota_subdominio, 2),
                "violacoes": total_violacoes_subdominio,
                "elementos_afetados": total_elementos_afetados_subdominio
            })
            
            # Exibe os detalhes do Página
            print(f"\nPágina: {subdominio.get('subdominio', 'Desconhecido')}")
            print(f"  - Nota: {round(nota_subdominio, 2)}")
            print(f"  - Violações: {total_violacoes_subdominio}")
            print(f"  - Elementos Afetados: {total_elementos_afetados_subdominio}")
        
        # Calcula a nota do domínio como a média das notas de suas páginas
        nota_dominio = sum(notas_subdominios) / len(notas_subdominios) if notas_subdominios else 1
        
        # Calcula métricas adicionais para o domínio
        media_violacoes_por_pagina = total_violacoes_dominio / len(subdominios) if subdominios else 0
        media_elementos_afetados_por_pagina = total_elementos_afetados_dominio / len(subdominios) if subdominios else 0
        
        # Adiciona as métricas ao relatório do domínio
        relatorio_dominio["nota_dominio"] = round(nota_dominio, 2)
        relatorio_dominio["total_paginas"] = len(subdominios)
        relatorio_dominio["total_violacoes"] = total_violacoes_dominio
        relatorio_dominio["media_violacoes_por_pagina"] = round(media_violacoes_por_pagina, 2)
        relatorio_dominio["media_elementos_afetados_por_pagina"] = round(media_elementos_afetados_por_pagina, 2)
        
        # Adiciona o domínio ao relatório
        relatorio[dominio] = relatorio_dominio
        
        # Exibe os detalhes do domínio
        print(f"\n-----------------------------------------")
        print(f"Resumo do domínio: {dominio}")
        print(f"  - Nota: {round(nota_dominio, 2)}")
        print(f"  - Total de páginas: {len(subdominios)}")
        print(f"  - Total de violações: {total_violacoes_dominio}")
        print(f"  - Média de violações por página: {round(media_violacoes_por_pagina, 2)}")
        print(f"  - Média de elementos afetados por página: {round(media_elementos_afetados_por_pagina, 2)}")
        print(f"=========================================\n")
    
    # Salva o relatório em um arquivo JSON
    with open(caminho_saida_json, 'w', encoding='utf-8') as f:
        json.dump(relatorio, f, ensure_ascii=False, indent=4)

# Caminho do arquivo JSON de entrada e saída
caminho_arquivo_json = 'relatorio_acessibilidade.json'
caminho_saida_json = 'relatorio_portais.json'

# Calcula e salva as notas de acessibilidade
calcular_nota_acessibilidade(caminho_arquivo_json, caminho_saida_json)
