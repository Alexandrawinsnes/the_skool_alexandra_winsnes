SET PAGESIZE 2000

DESC system.resultat_2025

SELECT * FROM resultat_2025
FETCH FIRST 10 ROWS ONLY;



-- Visar alla kolumnnamn


SELECT column_name
FROM user_tab_columns
WHERE table_name = 'RESULTAT_2025'
ORDER BY column_id;



-- Antal ansökningar per utbildningsområde, sorterat på flest ansökningar


SELECT UTBILDNINGSOMRÅDE, COUNT(*) AS antal
FROM resultat_2025
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY antal DESC; 



-- Antal BEVILJADE ansökningar per utbildningsområde


SELECT UTBILDNINGSOMRÅDE, COUNT(*) AS antal
FROM resultat_2025
WHERE BESLUT = 'Beviljad'
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY antal DESC;



-- Antal AVSLAGNA ansökningar per utbildningsområde


SELECT UTBILDNINGSOMRÅDE, COUNT(*) AS antal
FROM resultat_2025
WHERE BESLUT = 'Avslag'
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY antal DESC;



-- Antal BEVILJADE ansökningar per utbildningsnamn inom Data/IT


SELECT UTBILDNINGSNAMN, COUNT(*) AS antal
FROM resultat_2025
WHERE UTBILDNINGSOMRÅDE = 'Data/IT'
    AND BESLUT = 'Beviljad'
GROUP BY UTBILDNINGSNAMN
ORDER BY antal DESC;



-- Antal AVSLAGNA ansökningar per utbildningsnamn inom Data/IT


SELECT UTBILDNINGSNAMN, COUNT(*) AS antal
FROM resultat_2025
WHERE UTBILDNINGSOMRÅDE = 'Data/IT'
    AND BESLUT = 'Avslag'
GROUP BY UTBILDNINGSNAMN
ORDER BY antal DESC;



-- Antal BEVILJADE ansökningar per utbildningsanordnare administrativ enhet & utbildningsnamn, inom Data/IT


SELECT UTBILDNINGSANORDNARE_ADMINISTR, UTBILDNINGSNAMN, COUNT(*) AS antal
FROM resultat_2025
WHERE UTBILDNINGSOMRÅDE = 'Data/IT'
    AND BESLUT = 'Beviljad'
GROUP BY UTBILDNINGSANORDNARE_ADMINISTR, UTBILDNINGSNAMN
ORDER BY antal DESC;



-- Topp 5 län efter antal beviljade ansökningar


SELECT LÄN, COUNT(*) AS antal
FROM resultat_2025
WHERE BESLUT = 'Beviljad'
    AND LÄN != 'Flera kommuner'
GROUP BY LÄN
ORDER BY antal DESC
FETCH FIRST 5 ROWS ONLY;



-- Andel distans och andel bundna utbildningar inom respektive utbildingsområde 


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



-- Antal utbildningar som innehåller ordet AI


SELECT SUM(antal) AS totalt
FROM (SELECT UTBILDNINGSNAMN, COUNT(*) AS antal
    FROM resultat_2025
    WHERE INSTR(' ' || REPLACE(REPLACE(UPPER(UTBILDNINGSNAMN), '-', ' '), ',', '') || ' ', ' AI ') > 0
    GROUP BY UTBILDNINGSNAMN);


SELECT UTBILDNINGSNAMN
FROM resultat_2025
WHERE INSTR(' ' || REPLACE(REPLACE(UPPER(UTBILDNINGSNAMN), '-', ' '), ',', '') || '     ', ' AI ') > 0
ORDER BY UTBILDNINGSNAMN;

EXIT 
