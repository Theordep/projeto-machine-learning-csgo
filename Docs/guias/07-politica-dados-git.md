# Política de dados e Git

## O que NÃO entra no repositório

| Item | Motivo |
|------|--------|
| `data/` inteira | CSV ~dezenas de MB |
| `*.csv` em qualquer pasta | Mesmo motivo |
| `kaggle.json` / `.kaggle/` | Credencial pessoal |
| `.venv/`, `venv/` | Ambiente local recriável |
| `.ipynb_checkpoints/` | Lixo do Jupyter |
| Modelos `.pkl` grandes | Regeneráveis pelos notebooks |

Tudo isso está no [`.gitignore`](../../.gitignore).

## O que PODE entrar

- Notebooks `.ipynb` (código + outputs leves)
- `requirements-colab.txt`
- Documentação em `Docs/`
- Figuras em `reports/figures/` (PNG, tamanho razoável)
- Métricas em `reports/metrics/*.json`
- `.gitkeep` em pastas vazias

## Como verificar antes do commit

```bash
git status
```

Não deve aparecer `csgo_round_snapshots.csv`, `kaggle.json` nem `.venv/`.

## Dataset para quem clona o repo

1. Abrir `00_Setup_Colab.ipynb`
2. Executar células de download (kagglehub)
3. CSV gerado em `/content/data/raw/` (Colab) ou `data/raw/` (local)

## Commits

- **Pedro (Theordep)** é quem commita e faz merge na `main`
- Outros integrantes podem trabalhar em branch e abrir PR, ou enviar patch

## Primeiro push (repo vazio no GitHub)

Após o primeiro commit local na `main`:

```bash
git remote add origin https://github.com/Theordep/projeto-machine-learning-csgo.git
git push -u origin main
```

Depois:

```bash
bash scripts/create_branches.sh
git push origin --all
```

## Segurança

- Nunca commitar API keys do Kaggle
- Se vazar, revogar a key no Kaggle e gerar outra
