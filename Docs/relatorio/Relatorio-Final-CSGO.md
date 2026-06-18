# Projeto Final — Machine Learning Clássico

## Título

**Predição de vitória de round em Counter-Strike: Global Offensive com base em economia e armamento: comparação de modelos de Machine Learning Clássico**

> **Para entrega formal:** transcrever este documento para Word conforme ABNT (capa institucional, margens, Times/Arial 12, espaçamento 1,5, sumário, numeração de figuras). Inserir figuras geradas no Colab (`reports/figures/`).

**Instituição / Curso / Disciplina / Professor(a):** *(preencher)*  
**Integrantes:** Pedro Ernesto, Carlos Eduardo, Karen  
**Repositório:** https://github.com/Theordep/projeto-machine-learning-csgo  
**Ano:** 2026

---

# 1. INTRODUÇÃO, PROBLEMA E JUSTIFICATIVA

## 1.1 Contextualização

Counter-Strike: Global Offensive (CS:GO) é um jogo competitivo em equipes (CT vs T). Cada **round** dura até 115 segundos e a **economia virtual** (dinheiro por kills, vitórias e objetivos) determina o **armamento** disponível no round seguinte — rifles, AWP, coletes e granadas.

Hoje, a leitura de vantagem tática é em grande parte **subjetiva** (experiência do jogador/treinador) ou baseada em **regras simples** (“quem tem mais dinheiro ganha”). Ferramentas como HLTV descrevem o que ocorreu, mas não oferecem um modelo reprodutível de **probabilidade de vitória** antes do desfecho.

## 1.2 Problema de Machine Learning

| Tarefa | Tipo | Variável alvo |
|--------|------|----------------|
| **Principal** | Classificação binária | `round_winner` → CT ou T |
| **Complementar** | Regressão | `money_diff` = `ct_money` − `t_money` |

## 1.3 Dataset

| Campo | Valor |
|-------|--------|
| Nome | CS:GO Round Winner Classification |
| Fonte | [Kaggle](https://www.kaggle.com/datasets/christianlillelund/csgo-round-winner-classification) |
| Origem | Skybox AI Challenge (~700 demos profissionais, 2019–2020) |
| Dimensão bruta | 122.410 × 97, **0 nulos** |
| Download no projeto | **kagglehub** no Google Colab |

## 1.4 Justificativa

Na EDA, o time com **mais dinheiro vence apenas ~60,5%** dos snapshots — regra heurística insuficiente. Machine Learning integra dezenas de variáveis (mapa, armas, utilitários, bomba) e captura relações **não lineares**, com métricas probabilísticas (ROC-AUC).

---

# 2. OBJETIVOS

## 2.1 Objetivo geral

Desenvolver e comparar modelos de **Machine Learning Clássico** para prever o vencedor de rounds em CS:GO usando economia, armamento e estado tático.

## 2.2 Objetivos específicos

1. Estruturar e explorar o dataset Kaggle.  
2. Realizar EDA (balanceamento, economia, mapas, leakage).  
3. Implementar pré-processamento com filtros anti-leakage e feature engineering.  
4. Treinar classificadores: **Regressão Logística, Random Forest, SVM e KNN**.  
5. Treinar regressores: **Linear e Random Forest** para `money_diff`.  
6. Comparar métricas (F1, ROC-AUC, MAE, RMSE, R²) e analisar feature importance.  
7. Entregar pipeline **reproduzível no Google Colab**.

---

# 3. FUNDAMENTAÇÃO TEÓRICA

## 3.1 Domínio (CS:GO)

- **Round:** unidade de disputa; vence quem elimina o adversário, planta/desarma bomba ou expira o tempo.  
- **Buy tiers** (proxy: `ct_money`/`t_money` ÷ 5 jogadores): force (&lt; $1.700), eco (&lt; $2.000), half ($2.800–$3.799), full (≥ $4.700), mixed nas transições. Regra de saldo pós-compra e **loss bonus** não modelados (ausentes no dataset).  
- **AWP:** sniper de alto impacto tático.  
- **Win probability:** estimativa da chance de vitória dado o estado do round.

## 3.2 Algoritmos

| Algoritmo | Uso | Característica |
|-----------|-----|----------------|
| **Regressão Logística** | Classificação | Baseline interpretável |
| **SVM (RBF)** | Classificação | Fronteira não linear |
| **KNN** | Classificação | Similaridade local (Aula 5) |
| **Random Forest** | Classificação e regressão | Ensemble, feature importance |
| **Regressão Linear** | Regressão | Baseline contínua |

---

# 4. METODOLOGIA

## 4.1 Ambiente

- **Execução:** Google Colab (CPU)  
- **Linguagem:** Python 3.10+  
- **Bibliotecas:** pandas 3.0.3, scikit-learn 1.9.0, kagglehub  
- **Notebooks:** `00_Setup` → `01_EDA` → `02_Preprocessamento` → `03_Modelagem`  
- **Consolidado:** `COLAB_PROJETO-COMPLETO.ipynb` (Runtime → Executar tudo)

## 4.2 EDA (resumo)

| Achado | Valor |
|--------|--------|
| Balanceamento | T ≈ 51% / CT ≈ 49% |
| Nulos | 0 |
| Richer wins | ~60,5% |
| Bomba plantada | ~11% dos snapshots |
| Leakage | Múltiplos snapshots/round → filtrar `time_left` |

**Figuras:** `01_distribuicao_vencedor.png` … `09_correlacao.png`

## 4.3 Pré-processamento

| Filtro | Condição |
|--------|----------|
| Início de round | `time_left >= 150` |
| Times completos | 5 CT e 5 T vivos |
| Mapa | Excluir `de_cache` (145 linhas) |

**Resultado:** 122.410 → **33.365 linhas**

**Features derivadas:** `money_diff`, diffs de vida/armadura/jogadores, `money_ratio`, AWP, contagem rifles/util, buy tier (`ct_money`/`t_money` ÷ 5: force &lt; $1.700, eco &lt; $2.000, half $2.800–$3.799, full ≥ $4.700, mixed nas transições), `target_cls`.

**Limitação (buy tier):** média por jogador como proxy; loss bonus e saldo pós-compra não disponíveis no dataset.

**Pipeline:** `StandardScaler` (numéricas) + `OneHotEncoder` (mapa, buy tier).  
**Split:** 80% treino / 20% teste (estratificado na classificação).  
**Validação:** 3-fold CV no `GridSearchCV`.

**Limitação:** dataset sem ID de round — snapshots do mesmo round podem aparecer em treino e teste.

## 4.4 Modelagem

### Classificação

| Modelo | Hiperparâmetros (grid) | Observação |
|--------|------------------------|------------|
| Regressão Logística | `C`: 0.1, 1, 10 | `class_weight=balanced` |
| Random Forest | `max_depth`, `min_samples_leaf` | Melhor desempenho |
| SVM RBF | `C`, `gamma` | Treino em **6.000** amostras |
| KNN | `n_neighbors`: 5, 11, 21 | Com scaler no pipeline |

### Regressão

| Modelo | Target |
|--------|--------|
| Regressão Linear | `money_diff` (sem vazar `ct_money`/`t_money`) |
| Random Forest Regressor | Idem |

---

# 5. RESULTADOS

## 5.1 Classificação (conjunto de teste ≈ 6.673 linhas)

| Modelo | Accuracy | F1 | ROC-AUC |
|--------|----------|-----|---------|
| Regressão Logística | 0,774 | 0,770 | 0,878 |
| SVM (RBF) | 0,781 | 0,780 | 0,878 |
| KNN | ~0,785 | ~0,782 | ~0,865 |
| **Random Forest** | **0,904** | **0,903** | **0,970** |

**Melhor modelo:** Random Forest.

## 5.2 Regressão

| Modelo | MAE | RMSE | R² |
|--------|-----|------|-----|
| Regressão Linear | 6.588 | 9.227 | 0,451 |
| **Random Forest** | **4.828** | **7.896** | **0,598** |

## 5.3 Visualizações

| Figura | Conteúdo |
|--------|----------|
| 10 | Curvas ROC (todos classificadores) |
| 11 | Matriz de confusão (melhor modelo) |
| 12 | Feature importance — RF classificação |
| 13 | Real vs previsto — regressão |
| 14 | Feature importance — RF regressão |

## 5.4 Análise crítica

- **Random Forest** captura interações (mapa × economia × armamento).  
- **LR e SVM** ficam ~0,78 F1 — relações mais complexas que fronteiras simples.  
- **KNN** competitivo com baselines lineares/locais, abaixo do RF.  
- **Limitações:** dados CS:GO 2019–2020; possível leakage entre snapshots; SVM em subamostra.

---

# 6. CONCLUSÃO

O projeto atingiu os objetivos da disciplina: EDA, pré-processamento, comparação de múltiplos modelos clássicos (incluindo **KNN**), métricas adequadas e entrega **reproduzível no Colab**. O Random Forest obteve **F1 = 0,903** e **ROC-AUC = 0,970**, demonstrando que economia e armamento, combinados com outras variáveis táticas, predizem bem o vencedor do round — porém **não determinam** o resultado sozinhos (~60% para “time mais rico”).

Trabalhos futuros: dados CS2, ID de round para split agrupado, dashboard de probabilidade em tempo real.

---

# 7. REPRODUTIBILIDADE

1. Abrir: https://colab.research.google.com/github/Theordep/projeto-machine-learning-csgo/blob/main/notebooks/COLAB_PROJETO-COMPLETO.ipynb  
2. **Runtime → Executar tudo**  
3. Verificar `/content/reports/metrics/model_results.json` e figuras em `/content/reports/figures/`

---

# REFERÊNCIAS (ABNT)

LILLELUND, Christian. **CS:GO round winner classification**. Kaggle, 2020. Disponível em: https://www.kaggle.com/datasets/christianlillelund/csgo-round-winner-classification. Acesso em: 8 jun. 2026.

PEDREGOSA, Fabian et al. Scikit-learn: Machine Learning in Python. **Journal of Machine Learning Research**, v. 12, p. 2825-2830, 2011.

BREIMAN, Leo. Random forests. **Machine Learning**, v. 45, n. 1, p. 5-32, 2001.

CORTES, Corinna; VAPNIK, Vladimir. Support-vector networks. **Machine Learning**, v. 20, n. 3, p. 273-297, 1995.

XENOPOULOS, Peter et al. Trajectory and player action mining in CSGO. **KDD Workshop**, 2022.

SKYBOX. **CS:GO AI Challenge**. Skybox.gg, 2020. Disponível em: https://skybox.gg/blog/csgo-predictions-showcased-at-blast-premier. Acesso em: 8 jun. 2026.

---

*Documento-fonte para conversão Word. Figuras: exportar do Colab após executar os notebooks.*
