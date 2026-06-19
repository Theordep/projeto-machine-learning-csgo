# Predição de vitória de round em CS:GO (Machine Learning Clássico)

Trabalho final da disciplina **Machine Learning Clássico**: prever o vencedor de rounds em Counter-Strike: Global Offensive com base em **economia**, **armamento** e **estado tático**.

**Repositório:** https://github.com/Theordep/projeto-machine-learning-csgo

## Equipe

| Integrante | Papel |
|------------|--------|
| **Pedro Ernesto** ([Theordep](https://github.com/Theordep)) | Ideia, modelagem, pipeline Colab, merges |
| **Carlos Eduardo** | EDA, pré-processamento, fundamentação do jogo |
| **Karen** | Documentação, relatório ABNT, slides e apresentação |

## Abrir no Google Colab (recomendado)

| Notebook | Descrição | Link |
|----------|-----------|------|
| **Projeto completo** | Setup + EDA + Preprocess + Modelagem em um arquivo | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Theordep/projeto-machine-learning-csgo/blob/main/notebooks/COLAB_PROJETO-COMPLETO.ipynb) |
| 00 — Setup | Download do dataset (kagglehub) | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Theordep/projeto-machine-learning-csgo/blob/main/notebooks/00_Setup_Colab.ipynb) |
| 01 — EDA | Análise exploratória | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Theordep/projeto-machine-learning-csgo/blob/main/notebooks/01_EDA.ipynb) |
| 02 — Preprocess | Filtros, features, pipeline sklearn | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Theordep/projeto-machine-learning-csgo/blob/main/notebooks/02_Preprocessamento.ipynb) |
| 03 — Modelagem | LR, RF, SVM, KNN + regressão | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Theordep/projeto-machine-learning-csgo/blob/main/notebooks/03_Modelagem.ipynb) |

## Reprodução rápida (professor)

1. Abra o notebook **[COLAB_PROJETO-COMPLETO.ipynb](notebooks/COLAB_PROJETO-COMPLETO.ipynb)** pelo badge acima.
2. Menu **Runtime → Executar tudo** (CPU basta; modelagem leva ~10–20 min).
3. O dataset é baixado automaticamente via **kagglehub** (público, sem credencial).
4. Saídas: gráficos em `/content/reports/figures/` e métricas em `/content/reports/metrics/model_results.json`.

Documentação detalhada: **[Docs/guias/](Docs/guias/00-indice.md)**

## Dataset

- **Nome:** CS:GO Round Winner Classification  
- **Fonte:** [Kaggle](https://www.kaggle.com/datasets/christianlillelund/csgo-round-winner-classification)  
- **Arquivo:** `csgo_round_snapshots.csv` (~122.410 linhas × 97 colunas, 0 nulos)

## Pipeline do projeto

```
00 Setup → 01 EDA → 02 Pré-processamento → 03 Modelagem
```

| Etapa | O quê |
|-------|--------|
| **EDA** | Balanceamento CT/T, economia, mapas, AWP, leakage (`time_left`) |
| **Pré-processamento** | `time_left ≥ 150`, 5v5, sem `de_cache` → ~33.365 linhas |
| **Classificação** | LR, Random Forest, SVM (6k amostras), **KNN** |
| **Regressão** | Linear + Random Forest em `money_diff` |

## Resultados principais

*Referência: `reports/metrics/model_results.json` — valores podem variar levemente no Colab.*

### Classificação (CT vs T)

| Modelo | Accuracy | F1 | ROC-AUC |
|--------|----------|-----|---------|
| Regressão Logística | 0,774 | 0,770 | 0,878 |
| SVM (RBF) | 0,781 | 0,780 | 0,878 |
| KNN | ~0,785 | ~0,782 | ~0,865 |
| **Random Forest** | **0,904** | **0,903** | **0,970** |

### Regressão (`money_diff`)

| Modelo | MAE | RMSE | R² |
|--------|-----|------|-----|
| Regressão Linear | 6.588 | 9.227 | 0,451 |
| **Random Forest** | **4.828** | **7.896** | **0,598** |

**Melhor modelo geral:** Random Forest (classificação e regressão).

## Estrutura do repositório

```
notebooks/          # Notebooks Colab (00–03 + consolidado)
Docs/
  guias/            # Documentação de uso
  relatorio/        # Relatório ABNT (Markdown → Word)
  slides/           # Roteiro e conteúdo dos slides
reports/
  metrics/          # model_results.json
  figures/          # Gráficos (gerados no Colab)
requirements-colab.txt
EQUIPE.md
CONTRIBUTING.md
```

## Dependências (Colab)

Instaladas pelo notebook (`requirements-colab.txt`):

```
kagglehub==1.0.1  scikit-learn==1.9.0  seaborn==0.13.2
```

`pandas`, `numpy` e `matplotlib` usam as versões já presentes no Google Colab.

## Entregas acadêmicas

| Documento | Local |
|-----------|--------|
| Relatório ABNT | [Docs/relatorio/Relatorio-Final-CSGO.md](Docs/relatorio/Relatorio-Final-CSGO.md) |
| Slides / roteiro | [Docs/slides/](Docs/slides/) |
| Código reproduzível | Notebooks Colab (este repositório) |

## Como contribuir

Ver [CONTRIBUTING.md](CONTRIBUTING.md) — fluxo issue → branch → PR.

## Licença e dados

Dataset sob termos do Kaggle. Código do projeto para fins acadêmicos.
