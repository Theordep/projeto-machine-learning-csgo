# Ferramentas e bibliotecas

## Linguagem

- **Python 3.10+** (runtime padrão do Google Colab em 2026)

## Bibliotecas principais

| Pacote | Versão (requirements-colab) | Uso no projeto |
|--------|----------------------------|----------------|
| **pandas** | 3.0.3 | Leitura CSV, manipulação, agregações na EDA |
| **numpy** | 2.4.6 | Operações numéricas, arrays |
| **scikit-learn** | 1.9.0 | Pré-processamento, modelos, métricas, pipelines |
| **matplotlib** | 3.10.9 | Gráficos base |
| **seaborn** | 0.13.2 | Gráficos estatísticos (distribuições, heatmaps) |
| **kagglehub** | 1.0.1 | Download do dataset sem CLI manual |

Instalação no Colab:

```python
!pip install -q -r requirements-colab.txt
```

## scikit-learn — componentes usados

| Componente | Onde |
|------------|------|
| `StandardScaler` | Normalizar features numéricas |
| `OneHotEncoder` | Codificar `map`, buy tier |
| `ColumnTransformer` | Pipeline numérico + categórico |
| `Pipeline` | Encadeia preprocess + modelo |
| `train_test_split` | Split 80/20 estratificado (classificação) |
| `LogisticRegression` | Baseline classificação |
| `RandomForestClassifier` / `Regressor` | Modelo forte, feature importance |
| `SVC` | SVM (amostra reduzida por custo) |
| `KNeighborsClassifier` | Issue #9 (aula 5) |
| Métricas | `accuracy_score`, `f1_score`, `roc_auc_score`, `confusion_matrix`, etc. |

## Git e GitHub

- **Git** — versionamento local
- **GitHub** — repositório remoto + **Issues** (#1–#13) + milestones
- **gh CLI** — criar issues/PRs (opcional, máquina local)

## Google Colab

- Ambiente Jupyter na nuvem
- Não precisa instalar Python localmente para a entrega
- Integração com GitHub para abrir `.ipynb` direto

## O que NÃO usamos como núcleo

- Deep learning (PyTorch/TensorFlow) — fora do escopo “ML clássico”
- Banco de dados SQL — CSV em memória basta
- API em produção — projeto acadêmico

## Referências rápidas

- [Documentação scikit-learn](https://scikit-learn.org/stable/)
- [pandas user guide](https://pandas.pydata.org/docs/user_guide/index.html)
- [kagglehub PyPI](https://pypi.org/project/kagglehub/)
