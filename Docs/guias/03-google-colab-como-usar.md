# Como usar no Google Colab

## Opção A — Abrir pelo GitHub (recomendado)

1. Acesse o repositório: https://github.com/Theordep/projeto-machine-learning-csgo
2. Entre em `notebooks/00_Setup_Colab.ipynb`
3. Clique em **Open in Colab** (ou use o badge do README)
4. Em **Arquivo → Salvar uma cópia no Drive** (opcional, para não perder alterações)

## Opção B — Clone dentro do Colab

No primeiro notebook, uma célula pode clonar o repo:

```python
!git clone https://github.com/Theordep/projeto-machine-learning-csgo.git
%cd projeto-machine-learning-csgo
```

Depois abra os outros notebooks a partir da pasta clonada.

## Fluxo mínimo na primeira execução

1. **Runtime → Alterar tipo de ambiente de execução** → GPU não é necessária; CPU basta.
2. Rodar **todas as células** de `00_Setup_Colab.ipynb` em ordem:
   - `pip install` com `requirements-colab.txt`
   - Download do dataset (kagglehub)
   - Verificação `shape` / `head()`
3. Seguir para `01_EDA.ipynb`, etc.

## Autenticação Kaggle

O download usa **kagglehub**. Na primeira vez pode pedir credenciais:

1. Em [kaggle.com](https://www.kaggle.com) → **Account** → **Create New Token** → `kaggle.json`
2. No Colab:
   - **Opção 1:** Upload manual do `kaggle.json` para `~/.kaggle/`
   - **Opção 2:** Colab **Secrets** (`KAGGLE_USERNAME`, `KAGGLE_KEY`) e montar o arquivo na célula de setup

Detalhes: [05-dataset-e-kagglehub.md](05-dataset-e-kagglehub.md)

## Onde os dados ficam no Colab

Por padrão sugerimos:

```
/content/data/raw/csgo_round_snapshots.csv
```

A pasta `/content/` é **efêmera** — ao desligar o runtime, some. Para persistir:

- Salvar cópia no **Google Drive** (`drive.mount`), ou
- Reexecutar o notebook 00 (download leva poucos minutos)

## Reproduzir para o professor

1. Abrir `00_Setup_Colab.ipynb` pelo link do GitHub (branch `main` estável)
2. **Runtime → Executar tudo**
3. Abrir `01` → `02` → `03` na ordem (ou um notebook único consolidado na entrega, se a disciplina permitir)

Versões de pacotes fixadas em `requirements-colab.txt` para reprodutibilidade.

## Problemas comuns

| Problema | Solução |
|----------|---------|
| `ImportError` numpy `_center` / sklearn | Rodar célula de `pip install` do 00 e **reiniciar runtime** (o notebook consolidado reinicia sozinho na 1ª vez; depois **Executar tudo** de novo) |
| `ModuleNotFoundError` | Rodar de novo a célula `pip install` do 00 |
| Erro Kaggle / 403 | Verificar `kaggle.json` ou secrets |
| Caminho do CSV errado | Usar variável `DATA_RAW` definida no 00 |
| SVM muito lento | Usar subamostra (ex.: 6k linhas) — ver notebook 03 |

## Badge Colab no README

O README usa o formato:

```markdown
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/Theordep/projeto-machine-learning-csgo/blob/main/notebooks/00_Setup_Colab.ipynb)
```

Trocar `main` pelo nome da branch se estiver testando uma issue.
