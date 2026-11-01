SET PAGESIZE 2000
SET LINESIZE 200



-- Vilka utbildningsområden har högst beviljandegrad?
-- Grupperar per utbildningsområde och räknar dem
-- Sorterar med högst beviljandegrad först

SELECT UTBILDNINGSOMRÅDE,
    COUNT(*) AS ansökningar,
    COUNT(CASE WHEN BESLUT = 'Beviljad' THEN 1 END) AS beviljade,
    ROUND(COUNT(CASE WHEN BESLUT = 'Beviljad' THEN 1 END) / COUNT(*) * 100, 1) AS beviljandegrad
FROM resultat_2025
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY beviljandegrad DESC;



-- Hur skiljer sig antalet beviljade utbildningar från antalet avslagna utbildningar mellan olika studieformer?

SELECT STUDIEFORM,
    COUNT(*) AS ansökningar,
    COUNT(CASE WHEN BESLUT = 'Beviljad' THEN 1 END) AS beviljade,
    COUNT(CASE WHEN BESLUT = 'Avslag' THEN 1 END) AS avslag,
    ROUND(COUNT(CASE WHEN BESLUT = 'Beviljad' THEN 1 END) / COUNT(*) * 100,1) AS beviljandegrad
FROM resultat_2025
GROUP BY STUDIEFORM
ORDER BY beviljandegrad DESC;


-- Vilka utbildningsområden och län har högst beviljandegrad för platsbunda utbildningar?

SELECT UTBILDNINGSOMRÅDE, LÄN,
    COUNT(*) AS ansökningar,
    COUNT(CASE WHEN BESLUT = 'Beviljad' THEN 1 END) AS beviljade,
    ROUND(COUNT(CASE WHEN BESLUT = 'Beviljad' THEN 1 END) / COUNT(*) * 100, 1) AS beviljandegrad
FROM resultat_2025
WHERE STUDIEFORM = 'Bunden'
AND LÄN != 'Flera kommuner'
GROUP BY UTBILDNINGSOMRÅDE, LÄN
-- Filtrerar bort de med färre än 10 ansökningar
HAVING COUNT(*) >= 10
ORDER BY beviljandegrad DESC, ansökningar DESC;


-- Vilka specifika platsbunda utbildningar har högst beviljandegrad?

SELECT UTBILDNINGSNAMN, UTBILDNINGSOMRÅDE,
    COUNT(*) AS ansökningar,
    COUNT(CASE WHEN BESLUT = 'Beviljad' THEN 1 END) AS beviljade,
    ROUND(COUNT(CASE WHEN BESLUT = 'Beviljad' THEN 1 END) / COUNT(*) * 100,1) AS beviljandegrad
FROM resultat_2025
WHERE STUDIEFORM = 'Bunden'
GROUP BY UTBILDNINGSNAMN, UTBILDNINGSOMRÅDE
-- Tar fram de med minst 3 ansökningar
HAVING COUNT(*) >= 3
ORDER BY beviljandegrad DESC, ansökningar DESC;



-- Påverkar utbildningens längd chansen till en beviljad utbildning?

SELECT UTBILDNINGSLÄNGD,
    COUNT(*) AS ansökningar,
    COUNT(CASE WHEN BESLUT = 'Beviljad' THEN 1 END) AS beviljade,
    ROUND(COUNT(CASE WHEN BESLUT = 'Beviljad' THEN 1 END) / COUNT(*) * 100,1) AS beviljandegrad FROM (
SELECT BESLUT,
-- Delar in varje ansökan i en längdgrupp utifrån YH-poäng
    CASE
        WHEN YH_POÄNG BETWEEN 100 AND 199 THEN '100-199 YH-poäng'
        WHEN YH_POÄNG BETWEEN 200 AND 399 THEN '200-399 YH-poäng'
        WHEN YH_POÄNG BETWEEN 400 AND 600 THEN '400-600 YH-poäng'        
    END AS UTBILDNINGSLÄNGD
-- Hämtar beslutet och längdgruppen för varje ansökan
FROM resultat_2025
WHERE YH_POÄNG BETWEEN 100 AND 600)
GROUP BY UTBILDNINGSLÄNGD
ORDER BY beviljandegrad DESC;


EXIT
