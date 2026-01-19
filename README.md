\# Análise de Eficiência e Recuperação de Receita - Pronto Socorro 🏥



\## 📌 Problema de Negócio

A diretoria da unidade de Pronto Socorro identificou uma percepção de alta ociosidade em alguns turnos, reclamações de tempo de espera elevado e inconsistências no faturamento mensal. 



O objetivo deste projeto foi realizar uma \*\*Análise Exploratória de Dados (EDA)\*\* para identificar gargalos operacionais, falhas de processo administrativo e quantificar perdas financeiras por falta de registro de cobranças.



\## 🛠️ Tecnologias Utilizadas

\- \*\*SQL (PostgreSQL):\*\* Limpeza de dados, manipulação e análise estatística.

\- \*\*Excel:\*\* Criação de Dashboards para visualização de indicadores (KPIs).

\- \*\*Git/GitHub:\*\* Controle de versão e documentação.



\## 📂 Estrutura do Projeto

\- `dados/`: Base de dados utilizada no estudo (CSV).

\- `scripts\_sql/`: Scripts organizados por fases (Limpeza, Financeiro e Operacional).

\- `dashboard\_excel/`: Arquivo final com as visualizações de dados.



\## 📈 Descobertas Principais (Insights)



\### 1. Perda de Receita Estimada (R$ 694.000,00)

Identificamos que \*\*36% das consultas particulares\*\* não possuíam valor de receita registrado. Ao projetar a média real de recebimento sobre esses atendimentos, estimou-se uma perda de quase meio milhão de reais apenas neste plano.



\### 2. Gargalo na Operação Matinal

O turno da \*\*manhã\*\* concentra o maior volume de pacientes e o maior tempo de espera médio (\*\*55 minutos\*\*). O tempo médio de espera geral da unidade é de 43 minutos.



\### 3. Desbalanceamento de Carga Médica

Os médicos \*\*Efetivos\*\* estão sobrecarregados na triagem matinal, enquanto médicos \*\*Plantonistas\*\* operam com tempos de espera 40% menores no mesmo turno, sugerindo uma falha na distribuição de fichas.



\### 4. Burocracia Administrativa

O \*\*Plano C\*\* apresentou a maior espera média (66 min), mesmo com baixo volume de pacientes, indicando que o processo de autorização do convênio é um impeditivo para a fluidez do atendimento.



\## 🚀 Como Executar o Projeto

1\. Execute os scripts na ordem: `01\_preparacao\_limpeza.sql` -> `02\_eda\_financeiro.sql` -> `03\_eficiencia\_operacional.sql`.

2\. Os resultados agregados foram levados ao Excel para construção do Dashboard.

