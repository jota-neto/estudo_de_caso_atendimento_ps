-- =================================================================
-- SCRIPT: 03_EFICIENCIA_OPERACIONAL
-- OBJETIVO: Analisar gargalos de tempo e produtividade por turno, médico e plano
-- =================================================================

-- 1. Visão Geral: Tempo Médio de Espera
-- Objetivo: Estabelecer o benchmark geral da unidade
SELECT
    ROUND(AVG(tempo_espera_minutos)::numeric, 2) AS tempo_medio_espera
FROM
    atendimentos_ps;

-- CONCLUSÃO: O tempo médio geral é de 43,83 minutos. Este será nosso ponto de comparação.


-- 2. Sazonalidade Semanal
-- Objetivo: Identificar os dias de maior pressão na operação
SELECT
    dia_da_semana,
    COUNT(*) AS total_atendimentos,
    ROUND(AVG(tempo_espera_minutos)::numeric, 2) AS tempo_medio_espera
FROM
    atendimentos_ps
GROUP BY
    dia_da_semana
ORDER BY
    tempo_medio_espera DESC;

/* CONCLUSÃO: Terça-feira apresenta a maior espera. Curiosamente, a Quarta-feira, 
apesar do alto volume, é mais eficiente, sugerindo uma melhor escala médica ou fluxo de triagem.
*/


-- 3. Gargalo por Turno e Perfil Médico
-- Objetivo: Cruzar o horário de pico com a categoria do profissional
SELECT
    faixa_horario,
    tipo_medico,
    COUNT(*) AS total_atendimentos,
    ROUND(AVG(tempo_espera_minutos)::numeric, 2) AS media_espera
FROM (
    SELECT
        tipo_medico,
        tempo_espera_minutos,
        CASE
            WHEN hora_chegada >= '08:00' AND hora_chegada < '12:00' THEN 'Manhã'
            WHEN hora_chegada >= '12:00' AND hora_chegada < '18:00' THEN 'Tarde'
            ELSE 'Noite'
        END AS faixa_horario
    FROM atendimentos_ps
) AS atendimentos_por_turno
GROUP BY
    faixa_horario,
    tipo_medico
ORDER BY
    total_atendimentos DESC;

/* CONCLUSÃO: O cenário mais crítico é o Turno da Manhã com Médicos Efetivos (55,8 min). 
Plantonistas na manhã atendem 4x menos pacientes e são 18 minutos mais rápidos, 
indicando desbalanceamento na distribuição de fichas na triagem.
*/


-- 4. Eficiência Administrativa por Plano de Saúde
-- Objetivo: Verificar se a burocracia do convênio impacta o tempo de espera
SELECT
    faixa_horario,
    plano_de_saude,
    COUNT(*) AS total_atendimentos,
    ROUND(AVG(tempo_espera_minutos)::numeric, 2) AS media_espera
FROM (
    SELECT
        plano_de_saude,
        hora_chegada,
        tempo_espera_minutos,
        CASE
            WHEN hora_chegada >= '08:00' AND hora_chegada < '12:00' THEN 'Manhã'
            WHEN hora_chegada >= '12:00' AND hora_chegada < '18:00' THEN 'Tarde'
            ELSE 'Noite'
        END AS faixa_horario
    FROM atendimentos_ps
) AS atendimentos_por_turno
GROUP BY
    faixa_horario,
    plano_de_saude
ORDER BY
    faixa_horario,
    media_espera DESC;

/* CONCLUSÃO FINAL: O Plano C, mesmo com volume baixíssimo, gera a maior espera (66 min na manhã).
O PARTICULAR é mais rápido que os convênios na manhã (48 min), reforçando a hipótese de 
que a demora nos planos é agravada por processos de autorização e burocracia administrativa.
*/