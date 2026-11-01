# the_skool_alexandra_winsnes

## Syfte
Syftet med denna labb är att kunna använda datan SQL för att kunna hjälpa utbildningsanordnaren The Skool att ta fram information om ansökningsomgpngen 2025. Detta för att på så sätt kunna förstå vad som ger störst chans till en beviljad ansökan. Detta ska i sin tur göra det enklare för The Skool att ta beslut om vilka exempelvis utbildningar, studieformer och län de ska satsa på inflr kommande ansökan för att få störst chans till en godkänd ansökan.

## Bakgrund
Datan visar vilka ansökningar som blev beviljade år 2025, datan från ansökningsomgången 2026 ska hjälpa oss få fram vilka utbildningar vi bör presentera fram för The Skool som de ska satsa på i kommande ansökning.

## Struktur
``` 
.
├── 1_load_excel.sql
├── 2_select.sql
├── 3_explore.sql
├── README.md
├── resultat-ansokningsomgang-2025.xlsx
└── screenshots
```

- `1_load_excel.sql` laddar in Tabell 3 i Oracle
- `2_select.sql` inehåller uppgift 1, grundläggande analys
- `3.explore.sql` innehåller uppgift 3, mina egna frågor
- `resultat-ansokningsomgang-2025.xlsx` är datan, tabell 3
- `screenshots` innehåller bilder koder/resultat

## Uppgift 1: Grundläggande EDA
I denna uppgift har jag användt mig av följande SQL:
- `WHERE` för att kunna välja ut vilka ansökningar som ska räknas med.
- `GROUP BY` för att kunna välja ut från vilken tabell datan ska plockas.
- `COUNT(*)` för att få fram ett antal.
- `FETCH FIRST 5 ROWS ONLY` för att endast få fram de fem första raderna.
- `ROUND(AVG(CSE WHEN ... THEN 1 ELSE 0 END) * 100, 1)` räknar ut andel i procent
- `UPPER` `TRIM` `REPLACE` `INSTR` och `||` för att kunna hantera text, exempelvis för att kunna hitta ett specifikt ord.


-- Grundläggande EDA

