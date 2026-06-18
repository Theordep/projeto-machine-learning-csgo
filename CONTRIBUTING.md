# Contribuindo

## Fluxo de trabalho

1. Escolha uma [issue](https://github.com/Theordep/projeto-machine-learning-csgo/issues).
2. Crie ou use a branch sugerida (ex.: `issue-4-eda`).
3. Implemente e teste no **Google Colab**.
4. Abra **Pull Request** para `main`.
5. Após review, merge na `main`.

Mapa completo: [Docs/guias/06-fluxo-issues-branches.md](Docs/guias/06-fluxo-issues-branches.md)

## Notebooks

- Desenvolvimento por etapa: `00_`, `01_`, `02_`, `03_`.
- Ao concluir uma etapa, atualize também `COLAB_PROJETO-COMPLETO.ipynb`.
- Cada notebook deve rodar **sozinho** no Colab (download automático do CSV).

## Commits

Use mensagens claras:

```
feat(eda): gráficos de economia e mapas
fix(colab): clonar repo antes do pip install
docs(relatorio): seção de metodologia
```

## Dados

- **Não** commitar CSV (`*.csv` está no `.gitignore`).
- Dataset via kagglehub dentro do Colab.

## Windows / Git

Se `git pull` falhar com `.ipynb` modificado:

```bash
git restore notebooks/NOME.ipynb
```

O `.gitattributes` força LF nos notebooks para reduzir diffs fantasma.
