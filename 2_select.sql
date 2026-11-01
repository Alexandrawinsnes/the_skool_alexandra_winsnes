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
-- COUNT(*) räknar ansökningarna, GROUP BY delar upp de efter utbildningsområde
-- ORDER BY DESC sorterar


SELECT UTBILDNINGSOMRÅDE, COUNT(*) AS antal
FROM resultat_2025
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY antal DESC; 



-- Antal BEVILJADE ansökningar per utbildningsområde
-- WHERE filtrerar fram korrekt kolumn

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

-- Hämtar utbildningsnamnet
SELECT MIN(UTBILDNINGSNAMN) AS utbildningsnamn, 
    COUNT(*) AS antal
FROM resultat_2025
WHERE UTBILDNINGSOMRÅDE = 'Data/IT'
    AND BESLUT = 'Beviljad'
-- Hantera skillander i bokstäver och mellanslag
GROUP BY UPPER(TRIM(UTBILDNINGSNAMN))
ORDER BY antal DESC;



-- Antal AVSLAGNA ansökningar per utbildningsnamn inom Data/IT


SELECT MIN(UTBILDNINGSNAMN) AS utbildningsnamn, 
    COUNT(*) AS antal
FROM resultat_2025
WHERE UTBILDNINGSOMRÅDE = 'Data/IT'
    AND BESLUT = 'Avslag'
GROUP BY UPPER(TRIM(UTBILDNINGSNAMN))
ORDER BY antal DESC;



-- Antal BEVILJADE ansökningar per utbildningsanordnare administrativ enhet & utbildningsnamn, inom Data/IT


SELECT UTBILDNINGSANORDNARE_ADMINISTR, UTBILDNINGSNAMN, COUNT(*) AS antal
FROM resultat_2025
WHERE UTBILDNINGSOMRÅDE = 'Data/IT'
    AND BESLUT = 'Beviljad'
-- Grupperar efter administrativ enhet och utbildningsnamn
GROUP BY UTBILDNINGSANORDNARE_ADMINISTR, UTBILDNINGSNAMN
ORDER BY antal DESC;
--Få fram totalt antal beviljade ansökningar per administrativ enget inom Data/IT
SELECT UTBILDNINGSANORDNARE_ADMINISTR,
    COUNT(*) AS totalt_beviljade
FROM resultat_2025
WHERE UTBILDNINGSOMRÅDE = 'Data/IT'
AND BESLUT = 'Beviljad'
GROUP BY UTBILDNINGSANORDNARE_ADMINISTR
ORDER BY totalt_beviljade DESC;



-- Topp 5 län efter antal beviljade ansökningar


SELECT LÄN, COUNT(*) AS antal
FROM resultat_2025
WHERE BESLUT = 'Beviljad'
-- Tar bort flera kommuner
    AND LÄN != 'Flera kommuner'
GROUP BY LÄN
ORDER BY antal DESC
-- Visar de 5 län med flest ansökningar
FETCH FIRST 5 ROWS ONLY;



-- Andel distans och andel bundna utbildningar inom respektive utbildingsområde 
-- Räknar ut andelen i procent och avrundar till decimal

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


SELECT COUNT(UTBILDNINGSNAMN) AS antal
FROM resultat_2025
WHERE UTBILDNINGSNAMN LIKE '%AI%';


EXIT 
