# Análise Operacional e Financeira – Unidade de Pronto Socorro 🏥

## 📌 Contexto do Negócio

A gestão da unidade de Pronto Socorro identificou:
- Reclamações recorrentes sobre tempo de espera
- Sensação de ociosidade em determinados períodos
- Inconsistências no faturamento mensal

Este projeto apresenta uma **Análise Exploratória de Dados (EDA)** com foco em transformar essas percepções em **evidências quantitativas**, identificando gargalos operacionais e falhas administrativas com impacto financeiro.

---

## 🎯 Objetivos da Análise

- Identificar perdas financeiras causadas por falhas no registro de cobranças  
- Avaliar o comportamento do tempo de espera por turno, dia da semana e perfil de atendimento  
- Detectar gargalos operacionais e administrativos  
- Apoiar decisões de gestão com dados objetivos  

---

## 🛠️ Tecnologias Utilizadas

- **PostgreSQL (SQL):** limpeza, agregações e análises exploratórias  
- **Excel:** construção de dashboards e indicadores  
- **Git/GitHub:** versionamento e documentação  

---

## 📂 Estrutura do Projeto
dados/
└── base_atendimentos_ps.csv

scripts_sql/
├── 01_preparacao_limpeza.sql
├── 02_eda_financeiro.sql
└── 03_eficiencia_operacional.sql

dashboard_excel/
└── dashboard_atendimento_ps.xlsx


---

## 📊 Principais Resultados (KPIs)

- **Perda financeira estimada:** R$ 694.698  
- **Tempo médio de espera geral:** 43,8 minutos  
- **Pico de espera no turno da manhã:** 55,8 minutos  
- **Maior gargalo administrativo:** Plano C (66 minutos de espera média)  

---

## 🔎 Principais Insights

1. **Falha de registro de receita**  
   Mais de 36% das consultas particulares não apresentaram valor registrado, gerando perda financeira significativa por falha administrativa.

2. **Gargalo estrutural no turno da manhã**  
   O turno da manhã concentra simultaneamente maior volume de atendimentos e maior tempo médio de espera.

3. **Diferença no perfil de atendimento por tipo de médico**  
   Médicos efetivos apresentam maior tempo médio de espera, sugerindo concentração de casos mais complexos ou organização implícita do fluxo.

4. **Entraves administrativos em convênios**  
   O Plano C apresentou maior tempo de espera mesmo com baixo volume, indicando gargalo fora da operação médica.

5. **Impacto da sazonalidade semanal**  
   A terça-feira apresenta maior pico de espera, enquanto a segunda-feira opera de forma mais eficiente mesmo com maior volume.

---

## 🚀 Próximos Passos (Hipóteses Orientadas por Dados)

- Revisar o processo de registro financeiro no atendimento particular  
- Aprofundar a análise do perfil de atendimentos por tipo de médico  
- Avaliar o fluxo administrativo de autorização do Plano C  
- Ajustar planejamento operacional considerando padrões semanais  

Esses pontos representam **hipóteses analíticas**, que podem ser testadas e validadas continuamente.

---

## 📎 Artigo Completo

O estudo detalhado, com gráficos, interpretação dos resultados e contexto analítico, está disponível no artigo publicado no LinkedIn:

👉 https://www.linkedin.com/pulse/an%C3%A1lise-operacional-e-financeira-em-um-pronto-socorro-jo%C3%A3o-neto-99yge/?trackingId=zDP%2BuYhICREim7uKMgGWfg%3D%3D

---

## 📁 Observações

- Os scripts SQL estão organizados por etapa analítica  
- Os dashboards no Excel refletem os KPIs apresentados acima  
- Os dados utilizados são fictícios e destinados exclusivamente para fins educacionais e analíticos  





