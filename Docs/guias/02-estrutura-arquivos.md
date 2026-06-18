# Estrutura de arquivos

```
projeto-machine-learning-csgo/
├── README.md                 # Atalho + badge Colab
├── EQUIPE.md                 # Integrantes e papéis
├── requirements-colab.txt    # Dependências fixas (Colab)
├── .gitignore                # CSV, venv, checkpoints
│
├── notebooks/                # Fluxo principal (Colab-first)
│   ├── 00_Setup_Colab.ipynb
│   ├── 01_EDA.ipynb
│   ├── 02_Preprocessamento.ipynb
│   └── 03_Modelagem.ipynb
│
├── Docs/
│   ├── guias/                # ← Documentação (este conjunto)
│   ├── relatorio/            # Rascunho relatório ABNT (issue #11)
│   └── slides/               # Slides e roteiro (issue #12)
│
├── reports/
│   ├── figures/              # Gráficos exportados (PNG)
│   └── metrics/              # JSON com resultados dos modelos
│
├── scripts/
│   └── create_branches.sh    # Cria branches das issues (após 1º commit)
│
└── data/                     # NÃO versionado — criado no Colab
    ├── raw/                  # csgo_round_snapshots.csv
    └── processed/            # rounds_start.csv (após preprocess)
```

## O que roda onde

| Ambiente | Uso |
|----------|-----|
| **Google Colab** | Execução oficial dos notebooks (professor / equipe) |
| **Git local** | Versionar código, docs, figuras pequenas — **não** o CSV |
| **Kaggle** | Apenas origem do dataset (download via kagglehub) |

## Notebooks — ordem de execução

1. **00_Setup** — obrigatório primeiro; instala pacotes e baixa dados
2. **01_EDA** — exploração (pode usar `df` salvo em pickle ou reler CSV)
3. **02_Preprocess** — filtros + feature engineering + pipeline
4. **03_Modelagem** — treino, avaliação, gráficos

No Colab, cada notebook pode clonar o repo ou assumir que o **00** já rodou na mesma sessão (variáveis em memória) ou salvar intermediários em `/content/data/`.

## Pastas ignoradas pelo Git

Ver [07-politica-dados-git.md](07-politica-dados-git.md). Em resumo: `data/`, `*.csv`, `.venv`, checkpoints.

## Diferença em relação ao protótipo local

O projeto antigo em `TRABALHO-FINAL-MACHINE-LEARNING` usava `src/` + scripts `.py`.  
**Esta versão** concentra a lógica nos **notebooks** para o Colab; não há módulo `src/` obrigatório.
