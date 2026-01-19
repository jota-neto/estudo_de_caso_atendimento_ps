-- =================================================================
-- SCRIPT: 02_EDA_FINANCEIRO
-- OBJETIVO: Analisar a rentabilidade e identificar perdas de receita
-- =================================================================

-- 1. Visão Geral: Principais fontes de receita e Ticket Médio
-- Objetivo: Identificar qual plano é o mais rentável e qual tem o maior volume
SELECT
    plano_de_saude,
    COUNT(*) AS total_pacientes,
    ROUND(AVG(receita_consulta)::numeric, 2) AS ticket_medio
FROM
    atendimentos_ps
GROUP BY
    plano_de_saude
ORDER BY
    ticket_medio DESC;

/* CONCLUSÃO: O Plano A tem o melhor ticket médio, apesar do volume menor. 
O PARTICULAR chama atenção pelo volume (quase o triplo), mas com ticket médio 
desproporcionalmente baixo, sugerindo necessidade de investigação.
*/


-- 2. Performance Real: Lucro Médio por Plano
-- Objetivo: Avaliar a rentabilidade subtraindo custos laboratoriais
SELECT
    plano_de_saude,
    ROUND(AVG(receita_medicamentos)::numeric, 2) AS media_medicamentos,
    ROUND(AVG(custo_laboratorio)::numeric, 2) AS media_custo_lab,
    ROUND((AVG(receita_medicamentos + receita_consulta) - AVG(custo_laboratorio))::numeric, 2) AS lucro_medio
FROM
    atendimentos_ps
GROUP BY
    plano_de_saude
ORDER BY
    lucro_medio DESC;

/* CONCLUSÃO: O lucro médio do PARTICULAR é inferior aos planos A e B. 
Foi identificado ausência total de cobrança de medicamentos no particular (0.00).
*/


-- 3. Análise de Consultas Zeradas (Proporção de Erros)
-- Objetivo: Quantificar o percentual de atendimentos sem registro de valor
SELECT
    plano_de_saude,
    COUNT(*) AS total_consultas,
    SUM(CASE WHEN receita_consulta = 0 THEN 1 ELSE 0 END) AS consultas_zeradas,
    ROUND(
        (SUM(CASE WHEN receita_consulta = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*))::numeric, 
        2
    ) AS percentual_zeradas
FROM
    atendimentos_ps
GROUP BY
    plano_de_saude
ORDER BY
    percentual_zeradas DESC;

/*
CONCLUSÃO: O Plano C tem a maior falha proporcional (67%), mas os casos mais graves 
pelo volume são PARTICULAR (36,15%) e Plano D (24,31%). 
O Plano B prova que o sistema pode funcionar com erro próximo de zero (0.90%).
*/


-- 4. Impacto Financeiro Estimado (Custo de Oportunidade)
-- Objetivo: Estimar quanto a clínica deixou de faturar usando Subquery
SELECT
    base_principal.plano_de_saude,
    ROUND(tabela_medias.media_real_paga::numeric, 2) AS media_real_paga,
    SUM(CASE WHEN base_principal.receita_consulta = 0 THEN 1 ELSE 0 END) AS qtd_zeradas,
    ROUND(
        (tabela_medias.media_real_paga * SUM(CASE WHEN base_principal.receita_consulta = 0 THEN 1 ELSE 0 END))::numeric, 
        2
    ) AS perda_financeira_estimada
FROM atendimentos_ps AS base_principal
INNER JOIN (
    SELECT 
        plano_de_saude, 
        AVG(receita_consulta) AS media_real_paga
    FROM atendimentos_ps
    WHERE receita_consulta > 0 
    GROUP BY plano_de_saude
) AS tabela_medias 
ON base_principal.plano_de_saude = tabela_medias.plano_de_saude
GROUP BY 
    base_principal.plano_de_saude, 
    tabela_medias.media_real_paga
ORDER BY 
    perda_financeira_estimada DESC;

/*
CONCLUSÃO FINAL: Foi identificada uma inconsistência que pode chegar a R$ 694 mil 
em registros não faturados, concentrados principalmente nos pacientes Particulares e Plano D.
*/