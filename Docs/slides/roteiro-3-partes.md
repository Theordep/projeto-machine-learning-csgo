# Roteiro de apresentação em 3 partes (10–15 min)

**Trabalho:** Predição de vitória de round em CS:GO com Machine Learning Clássico  
**Repositório:** https://github.com/Theordep/projeto-machine-learning-csgo  
**Colab:** [`notebooks/COLAB_PROJETO-COMPLETO.ipynb`](../../notebooks/COLAB_PROJETO-COMPLETO.ipynb) → Runtime → Executar tudo

> Este roteiro divide a apresentação em **3 blocos** alinhados aos notebooks `01_EDA` → `02_Preprocessamento` → `03_Modelagem`.  
> Complementa [`roteiro-apresentacao.md`](roteiro-apresentacao.md) e [`slides-conteudo.md`](slides-conteudo.md).

---

## Visão geral

| Parte | Título | Notebook | Colab | Tempo | Integrante(s) |
|-------|--------|----------|-------|-------|---------------|
| **1** | Problema, dataset e EDA | `01_EDA.ipynb` | Parte 01 | ~4 min | Karen + Carlos |
| **2** | Pré-processamento e features | `02_Preprocessamento.ipynb` | Parte 02 | ~4 min | Carlos + Pedro |
| **3** | Modelagem, métricas e conclusão | `03_Modelagem.ipynb` | Parte 03 | ~5 min | Pedro + Karen |

**Setup (`00_Setup_Colab`)** — não precisa de slide dedicado; citar só na demo final: *“Roda no Google Colab; o dataset baixa automaticamente via kagglehub.”*

---

# PARTE 1 — Problema, dataset e EDA (~4 min)

**Objetivo:** explicar **por que** o projeto existe e **o que os dados mostram** antes de qualquer modelo.

## Slides sugeridos (4)

| # | Slide | Conteúdo |
|---|-------|----------|
| 1.1 | Capa | Título, integrantes, disciplina, 2026 |
| 1.2 | O problema | CS:GO: rounds CT vs T; economia + armas no início do round; leitura hoje é subjetiva |
| 1.3 | Por que ML? | Regra “quem tem mais $ ganha” → só **~60%**; dezenas de variáveis (mapa, AWP, granadas) |
| 1.4 | EDA — achados | Balanceamento ~51% T / 49% CT; mapas; bomba plantada; **leakage** → filtrar `time_left` |

## Palavras-chave

`EDA`, `dataset Kaggle`, `economia`, `balanceamento`, `leakage`, `time_left`, `round_winner`

## Figuras (após rodar o Colab)

- `01_distribuicao_vencedor.png` — balanceamento CT/T
- `02_economia.png` — diferença de dinheiro por vencedor
- `03_mapas.png` ou `04_buy_tier.png` — contexto tático

## Dataset (cite estes números)

| Campo | Valor |
|-------|--------|
| Fonte | [Kaggle — CS:GO Round Winner Classification](https://www.kaggle.com/datasets/christianlillelund/csgo-round-winner-classification) |
| Dimensão bruta | 122.410 linhas × 97 colunas |
| Nulos | 0 |
| Origem | Skybox AI Challenge (~700 demos profissionais, 2019–2020) |

## Fala sugerida — Karen (abertura, ~1 min)

> “Em partidas de CS:GO, cada round começa com decisões de economia e compra de armas. Nosso projeto usa Machine Learning para estimar quem vence o round com base nesses dados — algo que hoje ainda depende muito de intuição do jogador ou treinador.”

## Fala sugerida — Carlos (EDA, ~3 min)

> “Usamos 122 mil snapshots de partidas profissionais do Kaggle. As classes estão balanceadas entre CT e T, mas ter mais dinheiro só garante vitória em cerca de 60% dos casos — por isso precisamos de modelos multivariados. Na EDA também vimos que mapa, AWP e bomba plantada influenciam, e que precisamos filtrar snapshots do início do round para evitar leakage.”

## Checklist Parte 1

- [ ] Mencionar alvo: `round_winner` (CT ou T)
- [ ] Citar **Skybox** (origem) e **Lillelund/Kaggle** (dataset usado)
- [ ] Mencionar trabalhos relacionados (Hiemstra, Ghosh) — ver [`referencias-e-trabalhos-relacionados.md`](referencias-e-trabalhos-relacionados.md)
- [ ] Mostrar pelo menos 1 gráfico de economia ou mapas
- [ ] Explicar por que 60% não basta para uma regra simples

---

# PARTE 2 — Pré-processamento e features (~4 min)

**Objetivo:** mostrar **como transformamos** o dataset bruto em entrada para os modelos.

## Slides sugeridos (3–4)

| # | Slide | Conteúdo |
|---|-------|----------|
| 2.1 | Filtros | `time_left >= 150`, 5v5, sem `de_cache` → **122k → ~33k linhas** |
| 2.2 | Features derivadas | `money_diff`, buy tier, AWP, rifles, utilitários |
| 2.3 | Pipeline sklearn | `StandardScaler` + `OneHotEncoder`; split 80/20 estratificado |
| 2.4 | Buy tier (opcional) | force / eco / half / full / mixed — média $/jogador |

## Palavras-chave

`pré-processamento`, `feature engineering`, `buy tier`, `StandardScaler`, `OneHotEncoder`, `anti-leakage`, `train_test_split`

## Tabela de filtros (copiar para slide)

| Filtro | Motivo |
|--------|--------|
| `time_left >= 150` | Snapshot no **início** do round |
| 5 CT e 5 T vivos | Round completo |
| Excluir `de_cache` | Poucos dados / inconsistência |
| **Resultado** | 122.410 → **33.365 linhas** |

## Features principais

- Numéricas: `money_diff`, `money_ratio`, contagem rifles/granadas, colete, vida
- Categóricas: `map`, `ct_buy_tier`, `t_buy_tier`
- Alvo classificação: `target_cls` (1 = T vence)
- Alvo regressão (complementar): `money_diff`

## Fala sugerida — Carlos / Pedro (~4 min)

> “Filtramos apenas snapshots do início do round, com times completos, para evitar leakage — usar informação que só existiria depois do combate. Criamos features táticas como buy tier e contagem de rifles, e montamos um pipeline no scikit-learn com normalização e one-hot encoding. Separamos 80% para treino e 20% para teste de forma estratificada.”

## Demo rápida no Colab (opcional)

Mostrar na **Parte 02** do `COLAB_PROJETO-COMPLETO`:

```
Bruto: (122410, 97)
Após filtros: (33365, ...)
```

## Checklist Parte 2

- [ ] Explicar o que é leakage e como evitamos
- [ ] Citar redução 122k → 33k
- [ ] Mencionar pipeline reproduzível (Colab)

---

# PARTE 3 — Modelagem, métricas e conclusão (~5 min)

**Objetivo:** comparar modelos, apresentar **métricas** e fechar com conclusão e limitações.

## Slides sugeridos (5–6)

| # | Slide | Conteúdo |
|---|-------|----------|
| 3.1 | Duas tarefas | **Classificação** (CT vs T) + **Regressão** (`money_diff`) |
| 3.2 | Modelos — classificação | LR · SVM · **KNN** · **Random Forest** + GridSearchCV |
| 3.3 | Resultados — classificação | Tabela F1 / ROC-AUC; RF vence |
| 3.4 | Modelos — regressão | Linear · Random Forest Regressor; MAE, RMSE, R² |
| 3.5 | Gráficos | ROC, matriz de confusão, feature importance |
| 3.6 | Conclusão + demo | Limitações; link GitHub + Colab |

## Onde fica cada modelo no código (Colab Parte 03)

| Modelo | Tipo | Onde no notebook |
|--------|------|------------------|
| Regressão Logística | Classificação | `cls_cfgs[0]` |
| Random Forest | Classificação | `cls_cfgs[1]` — **melhor** |
| SVM (RBF) | Classificação | `cls_cfgs[2]` — 6k amostras |
| **KNN** | Classificação | `cls_cfgs[3]` — issue #9, Aula 5 |
| Regressão Linear | Regressão | `reg_cfgs[0]` |
| Random Forest Regressor | Regressão | `reg_cfgs[1]` — **melhor** |

## Métricas — onde ficam

| Saída | Caminho |
|-------|---------|
| **JSON final** | `/content/reports/metrics/model_results.json` |
| Curva ROC | `reports/figures/10_roc_classificacao.png` |
| Matriz de confusão | `reports/figures/11_matriz_confusao.png` |
| Feature importance | `reports/figures/12_importancia_classificacao.png` |
| Regressão real vs previsto | `reports/figures/13_regressao_real_vs_previsto.png` |

## Resultados para citar

### Classificação (CT vs T)

| Modelo | F1 | ROC-AUC |
|--------|-----|---------|
| Regressão Logística | 0,774 | 0,878 |
| SVM | 0,781 | 0,878 |
| KNN | ~0,785 | ~0,865 |
| **Random Forest** | **0,903** | **0,970** |

### Regressão (`money_diff`)

| Modelo | MAE | RMSE | R² |
|--------|-----|------|-----|
| Regressão Linear | 6.588 | 9.227 | 0,451 |
| **Random Forest** | **4.828** | **7.896** | **0,598** |

## KNN — o que dizer em 30 segundos

> “O **KNN** compara o round novo com os **K rounds mais parecidos** no treino — após normalizar as features — e vota na classe majoritária. Testamos K em 5, 11 e 21. Ficou competitivo com LR e SVM (~0,78 F1), mas abaixo do Random Forest, que captura melhor interações entre mapa, economia e armamento.”

## Random Forest — o que dizer em 30 segundos

> “O **Random Forest** é um conjunto de árvores de decisão que votam juntas. Foi o melhor modelo, com **F1 ≈ 0,90** e **ROC-AUC ≈ 0,97**, mostrando que economia, armamento e mapa juntos predizem bem o vencedor — mas não determinam sozinhos o resultado.”

## Limitações (slide obrigatório)

- Dados CS:GO **2019–2020** (não CS2)
- Dataset **sem ID de round** — possível overlap treino/teste
- SVM treinado em **subamostra** (6.000 linhas)
- Buy tier usa **média de $/jogador**; loss bonus não está no dataset

## Fala sugerida — Pedro (modelos, ~3 min)

> “Comparamos quatro classificadores — Regressão Logística, SVM, KNN e Random Forest — com GridSearchCV e métrica F1. O Random Forest foi o melhor, com F1 de 0,90. Na regressão complementar, prevendo a diferença de dinheiro, o RF também superou a regressão linear. As métricas ficam salvas em `model_results.json` e os gráficos em `reports/figures`.”

## Fala sugerida — Karen (fechamento, ~2 min)

> “Concluímos que Machine Learning clássico consegue estimar bem a vitória do round a partir de economia e armamento, mas a economia sozinha não basta. Tudo é reproduzível no Google Colab pelo link do GitHub. Obrigado — perguntas?”

## Checklist Parte 3

- [ ] Citar os 4 classificadores + 2 regressores
- [ ] Destacar RF como melhor modelo
- [ ] Mencionar F1, ROC-AUC (classificação) e MAE, RMSE, R² (regressão)
- [ ] Mostrar link Colab + GitHub
- [ ] Abrir `model_results.json` ou gráfico ROC (demo ao vivo, se possível)

---

## Divisão por integrante (referência)

| Integrante | Partes | Foco |
|------------|--------|------|
| **Karen** | 1 (abertura) + 3 (fechamento) | Problema, slides, conclusão, demo |
| **Carlos Eduardo** | 1 (EDA) + 2 | Dataset, gráficos, filtros, features |
| **Pedro Ernesto** | 2 (pipeline) + 3 (modelos) | Colab, modelagem, métricas, RF vs KNN |

---

## Roteiro em 3 frases (elevator pitch)

1. **Parte 1:** Temos dados reais de CS:GO e a EDA mostra que dinheiro sozinho não basta para prever vitória.  
2. **Parte 2:** Limpamos e enriquecemos os dados com features táticas, sem leakage.  
3. **Parte 3:** Comparamos LR, SVM, KNN e Random Forest; o RF ganhou com F1 0,90.

---

## Links para slide final

```
GitHub:  https://github.com/Theordep/projeto-machine-learning-csgo
Colab:   notebooks/COLAB_PROJETO-COMPLETO.ipynb
Relatório: Docs/relatorio/Relatorio-Final-CSGO.md
Guias:   Docs/guias/00-indice.md
```

---

## Antes da defesa — checklist geral

- [ ] Rodar `COLAB_PROJETO-COMPLETO` uma vez (Executar tudo **2×** na 1ª sessão)
- [ ] Exportar figuras `01_`, `10_`, `11_`, `12_` para os slides
- [ ] Ensaiar transições entre os 3 blocos
- [ ] Ter link do GitHub na última slide
- [ ] Tempo total: 10–15 min + perguntas
