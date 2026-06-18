# Slides — conteúdo (copiar para PowerPoint / Google Slides)

> Sugestão: 12 slides, tema escuro ou institucional. Inserir figuras de `reports/figures/` após rodar o Colab.

---

## Slide 1 — Capa
**Predição de vitória de round em CS:GO**  
Machine Learning Clássico — Trabalho Final

Pedro Ernesto · Carlos Eduardo · Karen  
2026

---

## Slide 2 — O problema
- CS:GO: rounds CT vs T, economia + armas  
- Hoje: leitura subjetiva do treinador  
- **Pergunta:** dá para prever o vencedor com ML?

---

## Slide 3 — Por que ML?
- Regra "quem tem mais $ ganha" → só **~60%**  
- Dezenas de variáveis: mapa, AWP, granadas  
- ML captura relações não lineares

---

## Slide 4 — Dataset
- Kaggle: CS:GO Round Winner Classification  
- 122.410 linhas × 97 colunas, 0 nulos  
- Partidas profissionais (Skybox Challenge)

*Figura sugerida: distribuição CT vs T (`01_distribuicao_vencedor.png`)*

---

## Slide 5 — EDA
- Balanceamento ~51% T / 49% CT  
- Mapas: Inferno, Dust2, Nuke…  
- Bomba plantada → forte viés para T  
- **Leakage:** filtrar `time_left >= 150`

*Figura: economia ou mapas (`02_` ou `03_`)*

---

## Slide 6 — Pré-processamento
- Filtros: início do round, 5v5, sem de_cache  
- 122k → **33k linhas**  
- Features: money_diff, buy tier, AWP, rifles  
- StandardScaler + OneHotEncoder

---

## Slide 7 — Modelos
**Classificação:** LR · SVM · KNN · Random Forest  
**Regressão:** Linear · Random Forest (`money_diff`)  
Otimização: GridSearchCV, métrica F1

---

## Slide 8 — Resultados (classificação)

| Modelo | F1 | ROC-AUC |
|--------|-----|---------|
| Logistic Regression | 0,77 | 0,88 |
| SVM | 0,78 | 0,88 |
| KNN | ~0,78 | ~0,87 |
| **Random Forest** | **0,90** | **0,97** |

*Figura: ROC (`10_roc_classificacao.png`)*

---

## Slide 9 — Resultados (regressão)
- Random Forest: R² = **0,60**, RMSE ≈ 7.896  
- Linear: R² = 0,45  
- Loadout explica parte da vantagem econômica

*Figura: real vs previsto (`13_regressao_real_vs_previsto.png`)*

---

## Slide 10 — Matriz e importância
- Matriz de confusão — RF  
- Top features: economia, armas, mapa

*Figuras: `11_matriz_confusao.png`, `12_importancia_classificacao.png`*

---

## Slide 11 — Limitações
- Dados CS:GO 2019–2020 (não CS2)  
- Sem ID de round no dataset  
- SVM treinado em subamostra (6k)

---

## Slide 12 — Conclusão e demo
- RF melhor modelo; economia importa, mas não basta  
- **Reprodução:** Google Colab — link do GitHub  
- Perguntas?

**Link:** https://github.com/Theordep/projeto-machine-learning-csgo  
**Colab:** `COLAB_PROJETO-COMPLETO.ipynb`
