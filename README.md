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


Alla frågor finns i `2_select.sql`. Exempel och resultat:

```sql
SELECT UTBILDNINGSOMRÅDE, COUNT(*) AS antal
FROM resultat_2025
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY antal DESC;
```
![Ansökningar per utbildningsområde] (screenshots/Uppgift1a.png)

Ekonomi, Teknik och tillverkning och Data/IT har flest ansökningar.

## Uppgift 2: intervjua domänexperten
Det viktigaste jag tar med mig från intervjun är att The Skool är öppna för möjligheter när det gäller utbildingens studeform, geografiska placering och utbildningsområde. 
Jag har därför i uppgift 3 utan att specificera mig på ett specifikt område försökt få fram så mycket information som möjligt för att få fram ett tydligt resultat

Dessa frågor är de jag tog med mig från intervjun i uppgift 3
- Vilka område har högst beviljandegrad
- Hur skiljer sig antalet beviljande utbildningar från antalet avslafna utbildningar mellan de olika studieformer?
- Vilka utbildningsområden och län har högst beviljandegrad för platsbunda utbildningar?
- Vilka specifika platsbunda utbildningar har högst beviljandegrad?
- Påverkar utbildningens längd chansen till en beviljad utbildning?


## Uppgift 3: Datadrivna beslut
I denna uppgift har jag användt mig av SQL för att undersöka de frågorna jag tog med mig från intervjun i upgift 2.

Alla frågor finns i `3_explore.sql. Exempel på de viktigaste resultaten jag fick fram:

![Hur skiljer sig antalet beviljade utbildningar från antalet avslagna utbildningar mellan olika studieformer] (screenshots/Uppgift3_Studieform.png)

![Resultat] (screenshots/Uppgift3_Studieform_Resultat.png)









