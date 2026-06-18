#!/usr/bin/env bash
# Cria branches locais mapeadas às issues #1–#13.
# Rodar APÓS o primeiro commit na main (Pedro).
set -euo pipefail

BRANCHES=(
  issue-1-readme-colab
  issue-2-gitignore
  issue-3-setup-colab
  issue-4-eda
  issue-5-preprocess-features
  issue-6-preprocess-pipeline
  issue-7-classificacao
  issue-8-regressao
  issue-9-knn
  issue-10-metricas-graficos
  issue-11-relatorio
  issue-12-slides
  issue-13-readme-final
)

if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
  echo "ERRO: faça o primeiro commit na main antes de criar branches."
  echo "  git add ."
  echo "  git commit -m \"chore: estrutura inicial Colab + Docs\""
  exit 1
fi

BASE=$(git branch --show-current)
echo "Base: $BASE"

for b in "${BRANCHES[@]}"; do
  if git show-ref --verify --quiet "refs/heads/$b"; then
    echo "já existe: $b"
  else
    git branch "$b"
    echo "criada: $b"
  fi
done

echo ""
echo "Branches criadas. Para enviar ao GitHub:"
echo "  git push origin --all"
echo ""
echo "Trabalhar em uma issue:"
echo "  git checkout issue-4-eda"
