# the_skool_alexandra_winsnes


SET LOADFORMAT XLSX 
LOAD TABLE resultat_2025 'resultat-ansokningsomgang-2025.xlsx' NEW
COMMIT;
 
EXIT



SET PAGESIZE 2000

DESC system.resultat_2025

SELECT * FROM resultat_2025
FETCH FIRST 10 ROWS ONLY;

--- Visar alla kolumnnamn

SELECT column_name
FROM user_tab_columns
WHERE table_name = 'RESULTAT_2025'
ORDER BY column_id;


--- Antal ansökningar per utbildningsområde, sorterat på flest ansökningar
  
SELECT UTBILDNINGSOMRÅDE, COUNT(*) AS antal
FROM resultat_2025
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY antal DESC;
 


--- Antal BEVILJADE ansökningar per utbildningsområde
SELECT UTBILDNINGSOMRÅDE, COUNT(*) AS antal
FROM resultat_2025
WHERE BESLUT = 'Beviljad'
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY antal DESC;


--- Antal BEVILJADE ansökningar per utbildningsnamn inom Data/IT
 
SELECT UTBILDNINGSNAMN, COUNT(*) AS antal
FROM resultat_2025
WHERE UTBILDNINGSOMRÅDE = 'Data/IT'
     AND BESLUT = 'Beviljad'
GROUP BY UTBILDNINGSNAMN
ORDER BY antal DESC;


 
--- Antal AVSLAGNA ansökningar per utbildningsnamn inom Data/IT
 
SELECT UTBILDNINGSNAMN, COUNT(*) AS antal
FROM resultat_2025
WHERE UTBILDNINGSOMRÅDE = 'Data/IT'
     AND BESLUT = 'Avslag'
GROUP BY UTBILDNINGSNAMN
ORDER BY antal DESC;


 
--- Antal BEVILJADE ansökningar per utbildningsanordnare administrativ enhet & utbildningsn    amn, inom Data/IT

SELECT UTBILDNINGSANORDNARE_ADMINISTR, UTBILDNINGSNAMN, COUNT(*) AS antal
FROM resultat_2025
WHERE UTBILDNINGSOMRÅDE = 'Data/IT'
     AND BESLUT = 'Beviljad'
GROUP BY UTBILDNINGSANORDNARE_ADMINISTR, UTBILDNINGSNAMN
ORDER BY antal DESC;
 
 
 
--- Topp 5 län efter antal beviljade ansökningar
 
SELECT LÄN, COUNT(*) AS antal
FROM resultat_2025
WHERE BESLUT = 'Beviljad'
     AND LÄN != 'Flera kommuner'
GROUP BY LÄN
ORDER BY antal DESC
FETCH FIRST 5 ROWS ONLY; 
 
--- Andel distans och andel bundna utbildningar inom respektive utbildingsområde 
 
SELECT UTBILDNINGSOMRÅDE,
     ROUND(AVG(CASE
         WHEN STUDIEFORM LIKE '%Bunden%' THEN 1
         ELSE 0
     END) * 100, 1) AS procent_bunden,
     ROUND(AVG(CASE
         WHEN STUDIEFORM LIKE '%Distans%' THEN 1
         ELSE 0
    END) * 100, 1) AS procent_distans
FROM resultat_2025
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY UTBILDNINGSOMRÅDE;


--- Antal utbildningar som innehåller ordet AI
 
SELECT SUM(antal) AS totalt
FROM (SELECT UTBILDNINGSNAMN, COUNT(*) AS antal
FROM resultat_2025
WHERE INSTR(' ' || REPLACE(REPLACE(UPPER(UTBILDNINGSNAMN), '-', ' '), ',', '') || ' ',     ' AI ') > 0
     GROUP BY UTBILDNINGSNAMN); 
SELECT UTBILDNINGSNAMN
FROM resultat_2025
WHERE INSTR(' ' || REPLACE(REPLACE(UPPER(UTBILDNINGSNAMN), '-', ' '), ',', '') || '     ',     ' AI ') > 0
ORDER BY UTBILDNINGSNAMN;
 
EXIT




SET PAGESIZE 2000
SET LINESIZE 200

 
 
--- Vilka utbildningsområden har högst beviljandegrad?

SELECT UTBILDNINGSOMRÅDE,
     COUNT(*) AS ansökningar,
     SUM(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) AS beviljade,
     ROUND(AVG(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) * 100, 1) AS beviljandegrad
FROM resultat_2025
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY beviljandegrad DESC;
 
 
 
--- Hur skiljer sig antalet beviljade utbildningar från antalet avslagna utbildningar mella    n olika studieformer?
 
SELECT STUDIEFORM,
     COUNT(*) AS ansökningar,
     SUM(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) AS beviljade,
     SUM(CASE WHEN BESLUT = 'Avslag' THEN 1 ELSE 0 END) AS avslag,
     ROUND(AVG(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) * 100,1) AS beviljandegrad
FROM resultat_2025
GROUP BY STUDIEFORM
ORDER BY beviljandegrad DESC;
 

  
--- Vilka utbildningsområden och län har högst beviljandegrad för platsbunda utbildningar?
 
SELECT UTBILDNINGSOMRÅDE, LÄN,
     COUNT(*) AS ansökningar,
     SUM(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) AS beviljade,
     ROUND(AVG(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) * 100, 1) AS beviljandegrad
FROM resultat_2025
WHERE STUDIEFORM = 'Bunden'
AND LÄN != 'Flera kommuner'
GROUP BY UTBILDNINGSOMRÅDE, LÄN
HAVING COUNT(*) >= 10
ORDER BY beviljandegrad DESC, ansökningar DESC;


 
--- Vilka specifika platsbunda utbildningar har högst beviljandegrad?
 
SELECT UTBILDNINGSNAMN, UTBILDNINGSOMRÅDE,
     COUNT(*) AS ansökningar,
     SUM(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) AS beviljade,
     ROUND(AVG(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) * 100,1) AS beviljandegrad
FROM resultat_2025
WHERE STUDIEFORM = 'Bunden'
GROUP BY UTBILDNINGSNAMN, UTBILDNINGSOMRÅDE
HAVING COUNT(*) >= 3
ORDER BY beviljandegrad DESC, ansökningar DESC;


 
--- Påverkar utbildningens längd chansen till en beviljad utnildning?
 
SELECT UTBILDNINGSLÄNGD,
     COUNT(*) AS ansökningar,
     SUM(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) AS beviljade,
     ROUND(AVG(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) * 100,1) AS beviljandegrad     FROM (
 SELECT BESLUT,
     CASE
         WHEN YH_POÄNG BETWEEN 100 AND 199 THEN '100-199 YH-poäng'
         WHEN YH_POÄNG BETWEEN 200 AND 399 THEN '200-399 YH-poäng'
         WHEN YH_POÄNG BETWEEN 400 AND 600 THEN '400-600 YH-poäng'
     END AS UTBILDNINGSLÄNGD
FROM resultat_2025
WHERE YH_POÄNG BETWEEN 100 AND 600)
GROUP BY UTBILDNINGSLÄNGD
ORDER BY beviljandegrad DESC;




EXIT






