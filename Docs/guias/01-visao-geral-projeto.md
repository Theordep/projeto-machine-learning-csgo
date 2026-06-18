# Visão geral do projeto

## Título

**Predição de vitória de round em Counter-Strike: Global Offensive com base em economia e armamento**

## Objetivo

Construir modelos de **Machine Learning clássico** que estimem a probabilidade de vitória de um round (`round_winner`: CT ou T) usando informações disponíveis no **início do round** — principalmente dinheiro, armas e utilitários — sem depender de eventos que ainda não ocorreram.

## Hipótese de negócio (jogo)

Times com **vantagem econômica** e **equipamento superior** tendem a vencer mais rounds. O dataset permite testar isso com dados reais de partidas competitivas.

## Dataset

- **Fonte:** [Kaggle — CS:GO Round Winner Classification](https://www.kaggle.com/datasets/christianlillelund/csgo-round-winner-classification)
- **Arquivo principal:** `csgo_round_snapshots.csv`
- **Tamanho aproximado:** ~122 mil linhas, ~97 colunas, snapshots por round
- **Download no projeto:** via **kagglehub** dentro do Colab (não versionamos o CSV no Git)

## Abordagem técnica

| Etapa | Onde | O quê |
|-------|------|--------|
| Setup | `00_Setup_Colab.ipynb` | Dependências + download |
| EDA | `01_EDA.ipynb` | Distribuições, correlações, leakage |
| Pré-processamento | `02_Preprocessamento.ipynb` | Filtros, features derivadas, pipeline sklearn |
| Modelagem | `03_Modelagem.ipynb` | Classificação (LR, RF, SVM, KNN), regressão, gráficos |

## Modelos previstos (disciplina)

- **Classificação:** Logistic Regression, Random Forest, SVM, KNN
- **Regressão:** prever `money_diff` (Linear, Random Forest)
- **Clustering (se aplicável nas aulas):** K-Means em features econômicas

## Métricas

- Classificação: acurácia, precisão, recall, F1, AUC-ROC
- Regressão: MAE, RMSE, R²
- Gráficos: matriz de confusão, curva ROC, importância de features

## Entregas finais

1. Notebooks reproduzíveis no **Google Colab**
2. Relatório ABNT (`Docs/relatorio/` — issue #11)
3. Slides e roteiro de apresentação (issue #12, Karen)
4. Repositório GitHub com issues fechadas por PR

## Equipe

Ver [EQUIPE.md](../../EQUIPE.md) na raiz do repositório.
