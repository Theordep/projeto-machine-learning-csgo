# Roteiro de apresentação (10–15 min)

**Trabalho:** Predição de vitória de round em CS:GO com ML Clássico  
**Repositório:** https://github.com/Theordep/projeto-machine-learning-csgo

| Ordem | Quem | Tempo | Conteúdo |
|-------|------|-------|----------|
| 1 | **Karen** | 2 min | Abertura: CS:GO, problema real, por que importa |
| 2 | **Carlos** | 3 min | Dataset Kaggle, EDA, achados (60% richer wins) |
| 3 | **Pedro** | 4 min | Pipeline Colab, pré-processamento, modelos |
| 4 | **Karen** | 3 min | Resultados (RF F1 0,90), gráficos, limitações |
| 5 | **Todos** | 2 min | Conclusão + perguntas |

## Falas sugeridas

### Karen — abertura
> "Em partidas de CS:GO, cada round começa com decisões de economia e compra de armas. Nosso projeto usa Machine Learning para estimar quem vence o round com base nesses dados — algo que hoje ainda depende muito de intuição."

### Carlos — EDA
> "Usamos 122 mil snapshots de partidas profissionais. As classes estão balanceadas, mas ter mais dinheiro só garante vitória em 60% dos casos — por isso precisamos de modelos multivariados."

### Pedro — metodologia
> "Tudo roda no Google Colab. Filtramos snapshots do início do round para evitar leakage, criamos features como buy tier e contagem de rifles, e comparamos Logistic Regression, SVM, KNN e Random Forest."

### Karen — fechamento
> "O Random Forest foi o melhor, com F1 de 0,90. A economia importa, mas armamento, mapa e utilitários também. Limitação: dados de 2019–2020 e snapshots sem ID de round."

## Checklist antes da defesa

- [ ] Abrir Colab e testar `COLAB_PROJETO-COMPLETO` uma vez  
- [ ] Exportar 3–4 figuras principais para os slides  
- [ ] Link do GitHub na última slide  
- [ ] Ensaiar transições entre falantes
