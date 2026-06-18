# Dataset e kagglehub

## Identificação

- **Kaggle slug:** `christianlillelund/csgo-round-winner-classification`
- **Arquivo usado:** `csgo_round_snapshots.csv`
- **Linhas / colunas (bruto):** ~122.410 × 97 (sem nulos no arquivo original)

## Download no Colab

```python
import kagglehub
from pathlib import Path
import shutil

DATASET = "christianlillelund/csgo-round-winner-classification"
DATA_RAW = Path("/content/data/raw")
DATA_RAW.mkdir(parents=True, exist_ok=True)

cache = Path(kagglehub.dataset_download(DATASET))
for src in cache.rglob("*.csv"):
    shutil.copy2(src, DATA_RAW / src.name)
    print("Salvo:", DATA_RAW / src.name)
```

## Autenticação

kagglehub usa as credenciais padrão do Kaggle:

```
~/.kaggle/kaggle.json
```

Conteúdo:

```json
{"username":"SEU_USER","key":"SUA_API_KEY"}
```

No Colab, faça upload antes do download ou configure via Secrets.

## Colunas importantes

| Grupo | Exemplos | Papel |
|-------|----------|--------|
| Meta | `map`, `round_winner` | Contexto + **alvo** |
| Tempo | `time_left` | Filtrar início do round (evitar leakage) |
| Economia | `ct_money`, `t_money` | Features + `money_diff` derivado |
| Estado | `ct_health`, `t_health`, jogadores vivos | Snapshot do round |
| Armas | `ct_weapon_*`, `t_weapon_*` | Contagens, AWP, rifles |
| Granadas | `ct_grenade_*`, `t_grenade_*` | Utilitários |
| Alvo | `round_winner` (`CT` / `T`) | Classificação binária → `target_cls` |

## Regras de filtro (pré-processamento)

Aplicadas no notebook `02_Preprocessamento.ipynb`:

| Regra | Motivo |
|-------|--------|
| `time_left >= 150` | Snapshot no **início** do round |
| `ct_players_alive == 5` e `t_players_alive == 5` | Round completo 5v5 |
| Excluir mapa `de_cache` | Poucos dados / inconsistência |

Resultado esperado: ~33 mil linhas (após filtros).

## Features derivadas (engenharia)

- `money_diff`, `health_diff`, `armor_diff`, `players_alive_diff`
- `money_ratio` = ct_money / t_money
- `ct_has_awp`, `t_has_awp`
- `ct_rifle_count`, `t_rifle_count` (soma de rifles)
- `ct_util_count`, `t_util_count` (granadas)
- `ct_buy_tier`, `t_buy_tier` — classificação por **média de dinheiro por jogador** (`team_money / 5`):
  - **force:** &lt; $1.700/jogador
  - **eco:** $1.700 – $1.999
  - **mixed:** faixas de transição ($2.000–$2.799 e $3.800–$4.699)
  - **half:** $2.800 – $3.799
  - **full:** ≥ $4.700
  - *Limitações:* proxy de média (dinheiro real é desigual entre jogadores); regra de saldo mínimo pós-compra (half) e **loss bonus** não estão no dataset.
- `target_cls` = 1 se `round_winner == "T"`, senão 0

## Política de versionamento

- **Não** commitar CSV no Git (`.gitignore`)
- Documentar no relatório: link Kaggle + comando/célula de download
- Opcional: commitar `reports/metrics/model_results.json` (pequeno)

Ver também [07-politica-dados-git.md](07-politica-dados-git.md).
