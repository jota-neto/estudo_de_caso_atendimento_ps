-- 1- Tabela Financeira

SELECT
    base.plano_de_saude,
    ROUND(medias.media_real_paga::numeric, 2) AS ticket_medio_real,
    SUM(CASE WHEN base.receita_consulta = 0 THEN 1 ELSE 0 END) AS qtd_consultas_zeradas,
    ROUND((medias.media_real_paga * SUM(CASE WHEN base.receita_consulta = 0 THEN 1 ELSE 0 END))::numeric, 2) AS perda_total_estimada
FROM atendimentos_ps AS base
INNER JOIN (
    SELECT plano_de_saude, AVG(receita_consulta) AS media_real_paga
    FROM atendimentos_ps
    WHERE receita_consulta > 0
    GROUP BY plano_de_saude
) AS medias ON base.plano_de_saude = medias.plano_de_saude
GROUP BY base.plano_de_saude, medias.media_real_paga
ORDER BY perda_total_estimada DESC;

-- 2 - Tabela de Eficiência
SELECT
    faixa_horario,
    tipo_medico,
    COUNT(*) AS volume_atendimentos,
    ROUND(AVG(tempo_espera_minutos)::numeric, 2) AS espera_media
FROM (
    SELECT 
        tipo_medico, tempo_espera_minutos,
        CASE
            WHEN hora_chegada >= '08:00' AND hora_chegada < '12:00' THEN 'Manhã'
            WHEN hora_chegada >= '12:00' AND hora_chegada < '18:00' THEN 'Tarde'
            ELSE 'Noite'
        END AS faixa_horario
    FROM atendimentos_ps
) AS sub
GROUP BY faixa_horario, tipo_medico
ORDER BY faixa_horario, volume_atendimentos DESC;

-- 3 - Tabela de Sazonalidade

SELECT
    dia_da_semana,
    COUNT(*) AS total_pacientes,
    ROUND(AVG(tempo_espera_minutos)::numeric, 2) AS espera_media
FROM atendimentos_ps
GROUP BY dia_da_semana
ORDER BY total_pacientes DESC;

-- 4 - Tabela de Burocracia por Plano

SELECT
    plano_de_saude,
    COUNT(*) AS volume,
    ROUND(AVG(tempo_espera_minutos)::numeric, 2) AS espera_media
FROM atendimentos_ps
WHERE hora_chegada >= '08:00' AND hora_chegada < '12:00' -- Foco no turno crítico
GROUP BY plano_de_saude
ORDER BY espera_media DESC;