# Referências e trabalhos relacionados

**Para:** relatório ABNT, slides e defesa oral  
**Objetivo:** mostrar ao professor que o grupo **consultou quem já fez predição de rounds em CS:GO**, se inspirou em abordagens existentes e deixou claro **o que é nosso** no trabalho.

Complementa: [`Relatorio-Final-CSGO.md`](../relatorio/Relatorio-Final-CSGO.md) (seção 3.3) e [`roteiro-3-partes.md`](roteiro-3-partes.md).

---

## Por que isso importa na apresentação

O professor espera:

1. **Referências bibliográficas** — dataset, ferramentas, algoritmos (ABNT no relatório)
2. **Trabalhos relacionados** — projetos/artigos que já tentaram prever vitória de round em CS:GO
3. **Posicionamento** — o que copiamos da ideia deles e **o que nosso grupo fez de diferente**

Sugestão: **1 slide** “Trabalhos relacionados” + slide “Referências” no final.

---

## Linha do tempo (origem dos dados)

```
2019–2020  Partidas profissionais gravadas
     ↓
2020       Skybox CS:GO AI Challenge (hackathon / desafio de IA)
     ↓
2020       Christian Lillelund publica dataset no Kaggle (122k snapshots)
     ↓
2020–2026  Dezenas de notebooks e repositórios no GitHub usam o mesmo CSV
     ↓
2026       Nosso projeto (ML Clássico, disciplina, Colab reproduzível)
```

**Conclusão para falar:** não inventamos o problema nem o dataset — **nos apoiamos no ecossistema Skybox/Kaggle** e comparamos modelos clássicos com pipeline documentado.

---

## Trabalhos relacionados (quem já fez)

### 1. Skybox — CS:GO AI Challenge (fonte original)

| Campo | Detalhe |
|-------|---------|
| **O quê** | Desafio de IA para prever desfecho de rounds em demos profissionais |
| **Dados** | ~700 partidas; snapshots a cada ~20 s até o round acabar |
| **Relevância** | **Origem** de todos os projetos abaixo |
| **Link** | https://skybox.gg/blog/csgo-predictions-showcased-at-blast-premier |

**O que inspirou no nosso projeto:** ideia de **win probability** / classificação por snapshot; features de economia, armas e estado do round.

---

### 2. Christian Lillelund — Dataset Kaggle

| Campo | Detalhe |
|-------|---------|
| **O quê** | CSV `csgo_round_snapshots.csv` — 122.410 linhas × 97 colunas |
| **O quê faz** | Pré-processa e achata os dados do Skybox para ML |
| **Modelos** | Não treina modelo oficial; a comunidade usa o CSV |
| **Link** | https://www.kaggle.com/datasets/christianlillelund/csgo-round-winner-classification |

**O que usamos:** **mesmo dataset** via `kagglehub` no Colab.

---

### 3. Paul Hiemstra — Abordagem Bayesiana

| Campo | Detalhe |
|-------|---------|
| **O quê** | Probabilidade de vitória CT/T com **estatística Bayesiana** |
| **Dados** | Mesmo dataset Kaggle (122k snapshots) |
| **Método** | Prior + evidência (ex.: jogadores vivos) → posterior via Bayes |
| **Links** | [Artigo Medium (TDS)](https://medium.com/data-science/who-will-win-the-next-round-of-counter-strike-global-offensive-de574a4f37f4) · [GitHub `bayes_csgo_round`](https://github.com/PaulHiemstra/bayes_csgo_round) |

**Diferença do nosso trabalho:** Hiemstra usa **probabilidade condicional explícita**; nós usamos **ML clássico supervisionado** (LR, RF, SVM, KNN) com `GridSearchCV` e métricas F1/ROC-AUC.

**Fala sugerida:**

> “Hiemstra mostrou que dá para estimar probabilidade de vitória com o mesmo dataset, usando Bayes. Nós seguimos a abordagem da disciplina: modelos clássicos do scikit-learn e comparação sistemática.”

---

### 4. Soumyadeep Ghosh — CS-GO Round Win Predictor

| Campo | Detalhe |
|-------|---------|
| **O quê** | Classificação CT vs T no dataset Kaggle |
| **Modelos** | Regressão Logística, LDA, **Random Forest** |
| **Link** | https://github.com/soumyadeepghoshGG/CS-GO-Round-Win-Predictor |

**Semelhança:** mesmos algoritmos base (LR, RF) e mesmas perguntas do dataset (“quem tem mais $ ganha?”, “quais features importam?”).

**Nossa extensão:** SVM, **KNN** (exigência da aula 5), regressão em `money_diff`, filtros anti-leakage (`time_left`), buy tier, pipeline Colab reproduzível.

---

### 5. d-roho — CSGOPredictor (aplicação em tempo real)

| Campo | Detalhe |
|-------|---------|
| **O quê** | Predição **ao vivo** via Game State Integration (GSI) |
| **Modelo** | Regressão Logística treinada no Kaggle |
| **Features** | Reduz ~97 colunas para ~23 atributos agregados |
| **Link** | https://github.com/d-roho/CSGOPredictor |

**O que inspirou:** prova de que o problema tem **aplicação prática** (overlay / probabilidade em partida).

**Diferença:** foco acadêmico nosso — comparar **vários** classificadores e documentar EDA + métricas; não integramos GSI.

---

### 6. thecml — csgo-ai-challenge

| Campo | Detalhe |
|-------|---------|
| **O quê** | Solução do desafio Skybox com ensembles |
| **Modelos** | TensorFlow, scikit-learn, **CatBoost** |
| **Link** | https://github.com/thecml/csgo-ai-challenge |

**Diferença:** eles usam **deep learning e ensemble**; nossa disciplina pede **ML clássico** (LR, RF, SVM, KNN).

---

### 7. Gyanesh Samanta — Round winner (XGBoost)

| Campo | Detalhe |
|-------|---------|
| **O quê** | Trabalho de faculdade — classificação por snapshot |
| **Modelos** | scikit-learn + **XGBoost** |
| **Link** | https://github.com/GyaneshSamanta/CS-GO-Round-winner-classification |

**Semelhança:** pipeline EDA → encode → scale → treino/teste.

**Diferença:** XGBoost não faz parte do escopo da nossa disciplina; usamos RF como modelo forte de ensemble de árvores.

---

### 8. Xenopoulos et al. — Mineração de ações em CS:GO (acadêmico)

| Campo | Detalhe |
|-------|---------|
| **O quê** | Pesquisa em **trajetórias e ações de jogadores** em CS:GO (KDD Workshop) |
| **Relevância** | Contexto acadêmico de **esports analytics** — não é o mesmo CSV, mas mesmo domínio |
| **Referência** | Xenopoulos, Peter et al. Trajectory and player action mining in CSGO. **KDD Workshop**, 2022. |

**Uso no relatório:** citar como **trabalho acadêmico no domínio CS:GO / esports**.

---

## Tabela comparativa (slide pronto)

| Trabalho | Método principal | Mesmo dataset? | Nosso projeto |
|----------|------------------|----------------|---------------|
| Skybox Challenge | Desafio / baseline comunidade | ✅ origem | Base conceitual |
| Lillelund (Kaggle) | Publicação de dados | ✅ | Dataset que usamos |
| Hiemstra | Bayesiano | ✅ | Inspirou o problema; método diferente |
| Ghosh | LR, LDA, RF | ✅ | RF similar; nós + SVM, KNN, regressão |
| CSGOPredictor | LR + tempo real | ✅ | Inspirou aplicação; nós foco acadêmico |
| thecml | TF, CatBoost, ensemble | ✅ | ML clássico vs deep/ensemble |
| Samanta | XGBoost | ✅ (variante) | RF no lugar de boosting |
| **Nosso** | **LR, SVM, KNN, RF** + regressão | ✅ | **EDA, anti-leakage, Colab, métricas ABNT** |

---

## O que é contribuição nossa (cite na defesa)

1. **Pipeline reproduzível** — `COLAB_PROJETO-COMPLETO.ipynb`, Runtime → Executar tudo  
2. **Anti-leakage** — filtro `time_left >= 150`, 5v5, documentado na EDA  
3. **Feature engineering** — buy tier (faixas CS:GO), rifles, AWP, utilitários  
4. **Comparação disciplinar** — 4 classificadores + 2 regressores + **KNN**  
5. **Métricas completas** — F1, ROC-AUC, MAE, RMSE, R², `model_results.json`  
6. **Documentação** — guias em `Docs/guias/`, relatório ABNT, este arquivo de referências  

---

## Referências bibliográficas (ABNT) — lista completa

### Dados e domínio

LILLELUND, Christian. **CS:GO round winner classification**. Kaggle, 2020. Disponível em: https://www.kaggle.com/datasets/christianlillelund/csgo-round-winner-classification. Acesso em: 8 jun. 2026.

SKYBOX. **CS:GO AI Challenge**. Skybox.gg, 2020. Disponível em: https://skybox.gg/blog/csgo-predictions-showcased-at-blast-premier. Acesso em: 8 jun. 2026.

### Trabalhos relacionados (comunidade / técnicos)

HIEMSTRA, Paul. Who will win the next round of Counter-Strike: Global Offensive? **Towards Data Science** (Medium), 2021. Disponível em: https://medium.com/data-science/who-will-win-the-next-round-of-counter-strike-global-offensive-de574a4f37f4. Acesso em: 8 jun. 2026.

GOSH, Soumyadeep. **CS-GO Round Win Predictor**. GitHub, 2020. Disponível em: https://github.com/soumyadeepghoshGG/CS-GO-Round-Win-Predictor. Acesso em: 8 jun. 2026.

CSGOPREDICTOR. **CSGOPredictor** — live round winner predictions. GitHub. Disponível em: https://github.com/d-roho/CSGOPredictor. Acesso em: 8 jun. 2026.

THECML. **csgo-ai-challenge**. GitHub, 2020. Disponível em: https://github.com/thecml/csgo-ai-challenge. Acesso em: 8 jun. 2026.

SAMANTA, Gyanesh. **CS-GO-Round-winner-classification**. GitHub. Disponível em: https://github.com/GyaneshSamanta/CS-GO-Round-winner-classification. Acesso em: 8 jun. 2026.

### Acadêmico — esports / algoritmos

XENOPOULOS, Peter et al. Trajectory and player action mining in CSGO. **KDD Workshop**, 2022.

BREIMAN, Leo. Random forests. **Machine Learning**, v. 45, n. 1, p. 5-32, 2001.

CORTES, Corinna; VAPNIK, Vladimir. Support-vector networks. **Machine Learning**, v. 20, n. 3, p. 273-297, 1995.

COVER, Thomas; HART, Peter. Nearest neighbor pattern classification. **IEEE Transactions on Information Theory**, v. 13, n. 1, p. 21-27, 1967.

PEDREGOSA, Fabian et al. Scikit-learn: Machine Learning in Python. **Journal of Machine Learning Research**, v. 12, p. 2825-2830, 2011.

---

## Slide sugerido — “Trabalhos relacionados” (copiar)

**Título:** Quem já fez predição de round em CS:GO?

- **Skybox (2020)** — desafio de IA; dados de partidas pro  
- **Kaggle / Lillelund** — 122k snapshots (nosso dataset)  
- **Hiemstra** — probabilidade Bayesiana no mesmo CSV  
- **GitHub (Ghosh, CSGOPredictor, thecml)** — LR, RF, XGBoost, tempo real  
- **Nosso trabalho** — ML clássico comparativo (LR, SVM, **KNN**, RF) + regressão, Colab reproduzível  

*“Nos inspiramos no ecossistema Skybox/Kaggle; nossa entrega é a comparação sistemática exigida pela disciplina.”*

---

## Slide sugerido — “Referências” (copiar)

- Dataset: Lillelund (Kaggle, 2020) · Skybox AI Challenge  
- Trabalhos relacionados: Hiemstra (Bayes); Ghosh, CSGOPredictor (GitHub)  
- Ferramentas: Pedregosa et al. (scikit-learn, 2011)  
- Algoritmos: Breiman (Random Forest); Cortes & Vapnik (SVM); Cover & Hart (KNN)  
- Domínio: Xenopoulos et al. (CS:GO analytics, KDD 2022)  

Lista completa ABNT: `Docs/relatorio/Relatorio-Final-CSGO.md` e este arquivo.

---

## Onde citar na apresentação (3 partes)

| Parte | Momento | O que citar |
|-------|---------|-------------|
| **1 — EDA** | Ao apresentar o dataset | Skybox + Lillelund (Kaggle); pergunta “60% richer wins” vem do próprio README do dataset |
| **2 — Pré-process** | Ao falar de leakage | Hiemstra e outros usam snapshots — nós **filtramos início do round** (decisão nossa) |
| **3 — Modelos** | Ao comparar RF/LR | Ghosh e CSGOPredictor também usam LR/RF; nós **adicionamos KNN e SVM** |

---

## Checklist antes da defesa

- [ ] Slide “Trabalhos relacionados” incluído  
- [ ] Slide “Referências” no final  
- [ ] Relatório Word com seção 3.3 e referências ABNT atualizadas  
- [ ] Saber explicar em 1 frase a diferença para Hiemstra (Bayes vs ML clássico)  
- [ ] Saber explicar o que o Skybox/Kaggle forneceu vs o que o grupo implementou  
