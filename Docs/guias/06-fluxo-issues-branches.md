# Fluxo de issues e branches

Repositório: https://github.com/Theordep/projeto-machine-learning-csgo/issues

## Milestones

| Milestone | Issues |
|-----------|--------|
| **M0 — Setup** | #1, #2, #3 |
| **M1 — EDA** | #4 |
| **M2 — Pré-processamento** | #5, #6 |
| **M3 — Modelagem** | #7, #8, #9, #10 |
| **M4 — Entrega** | #11, #12, #13 |

## Mapa issue → branch → artefato

| Issue | Branch | Principal entrega |
|-------|--------|-------------------|
| #1 | `issue-1-readme-colab` | README, `EQUIPE.md`, `requirements-colab.txt`, estrutura |
| #2 | `issue-2-gitignore` | `.gitignore`, política de dados |
| #3 | `issue-3-setup-colab` | `notebooks/00_Setup_Colab.ipynb` |
| #4 | `issue-4-eda` | `notebooks/01_EDA.ipynb` |
| #5 | `issue-5-preprocess-features` | Filtros + features em `02_Preprocessamento.ipynb` |
| #6 | `issue-6-preprocess-pipeline` | Split, scaler, OneHot em `02` |
| #7 | `issue-7-classificacao` | LR, RF, SVM em `03_Modelagem.ipynb` |
| #8 | `issue-8-regressao` | Regressão `money_diff` em `03` |
| #9 | `issue-9-knn` | KNN no pipeline |
| #10 | `issue-10-metricas-graficos` | ROC, confusão, feature importance |
| #11 | `issue-11-relatorio` | `Docs/relatorio/` |
| #12 | `issue-12-slides` | `Docs/slides/` |
| #13 | `issue-13-readme-final` | README final + checklist reprodutibilidade |

## Workflow Git (equipe)

1. **Pedro** faz o primeiro commit na `main` (estrutura inicial).
2. Rodar `scripts/create_branches.sh` para criar todas as branches locais.
3. Para cada issue:
   ```bash
   git checkout issue-4-eda
   # trabalhar...
   git add ...
   git commit -m "feat(eda): ..."
   git push -u origin issue-4-eda
   gh pr create --title "..." --body "Fecha #4"
   ```
4. **Somente Pedro** faz merge na `main` (ou conforme combinado no grupo).

## Quem faz o quê

| Pessoa | Issues típicas |
|--------|----------------|
| **Karen** | #1 (texto), #11, #12, #13 — docs e apresentação |
| **Carlos** | #4, #5 — EDA e preprocess |
| **Pedro** | #3, #6–#10 — Colab, modelagem, merges |

## Estado atual do repositório

- Issues **#1–#13** já criadas no GitHub
- Branches locais: criar com `scripts/create_branches.sh` **após o primeiro commit**
- Documentação detalhada: pasta `Docs/guias/` (este índice)

## Protótipo de referência

Código e resultados experimentais anteriores estão em `c:\TRABALHO-FINAL-MACHINE-LEARNING` (máquina local).  
Use como referência numérica, não como estrutura final — o repo oficial é **Colab-first**.
