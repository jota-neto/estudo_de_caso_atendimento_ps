-- =================================================================
-- SCRIPT: 01_PREPARACAO_LIMPEZA
-- OBJETIVO: Validar a integridade dos dados de atendimentos
-- =================================================================

-- 1. Entendimento inicial da base
SELECT * FROM atendimentos_ps LIMIT 10;

-- 2. Verificação de IDs Duplicados
-- Objetivo: Garantir que cada linha represente um evento único de atendimento
SELECT
    id_paciente,
    data_atendimento,
    horario_entrada,
    COUNT(*) AS total_ocorrencias
FROM
    atendimentos_ps
GROUP BY
    id_paciente,
    data_atendimento,
    horario_entrada
HAVING COUNT(*) > 1;

-- CONCLUSÃO: Não existem registros duplicados. Base íntegra quanto à unicidade.


-- 3. Verificação de Valores Nulos
-- Objetivo: Identificar campos vazios que podem prejudicar cálculos de média e soma
SELECT
    COUNT(*) AS total_registros,
    SUM(CASE WHEN id_paciente IS NULL THEN 1 ELSE 0 END) AS nulos_id, 
    SUM(CASE WHEN data_atendimento IS NULL THEN 1 ELSE 0 END) AS nulos_data,
    SUM(CASE WHEN receita_consulta IS NULL THEN 1 ELSE 0 END) AS nulos_receita,
    SUM(CASE WHEN plano_de_saude IS NULL THEN 1 ELSE 0 END) AS nulos_plano
FROM
    atendimentos_ps;

-- CONCLUSÃO: Não existem valores nulos nas colunas essenciais para o faturamento.


-- 4. Inconsistência Lógica de Horários
-- Objetivo: Validar se o horário de saída é posterior ao de entrada
SELECT 
    id_paciente, 
    horario_entrada, 
    horario_finalizacao
FROM 
    atendimentos_ps
WHERE 
    horario_finalizacao < horario_entrada;

-- CONCLUSÃO: Todos os horários de saída são posteriores à entrada. Cronologia validada.


-- 5.Verificação de Texto (Espaços em branco)
-- Objetivo bom checar se existem planos de saúde "vazios" mas que não são nulos (apenas espaços)

SELECT 
    plano_de_saude, 
    COUNT(*) 
FROM 
    atendimentos_ps 
WHERE 
    plano_de_saude = ' ' OR plano_de_saude = ''
GROUP BY 
    plano_de_saude;

-- CONCLUSÃO FINAL: A base está limpa e pronta para a Fase 2 (EDA).