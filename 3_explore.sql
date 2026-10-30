SET PAGESIZE 2000
SET LINESIZE 200



-- Vilka utbildningsområden har högst beviljandegrad?

SELECT UTBILDNINGSOMRÅDE,
    COUNT(*) AS ansökningar,
    SUM(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) AS beviljade,
    ROUND(AVG(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) * 100, 1) AS beviljandegrad
FROM resultat_2025
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY beviljandegrad DESC;



-- Hur skiljer sig antalet beviljade utbildningar från antalet avslagna utbildningar mellan olika studieformer?

SELECT STUDIEFORM,
    COUNT(*) AS ansökningar,
    SUM(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) AS beviljade,
    SUM(CASE WHEN BESLUT = 'Avslag' THEN 1 ELSE 0 END) AS avslag,
    ROUND(AVG(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) * 100,1) AS beviljandegrad
FROM resultat_2025
GROUP BY STUDIEFORM
ORDER BY beviljandegrad DESC;



-- Vilka utbildningsområden och län har högst beviljandegrad för platsbunda utbildningar?

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



-- Vilka specifika platsbunda utbildningar har högst beviljandegrad?

SELECT UTBILDNINGSNAMN, UTBILDNINGSOMRÅDE,
    COUNT(*) AS ansökningar,
    SUM(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) AS beviljade,
    ROUND(AVG(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) * 100,1) AS beviljandegrad
FROM resultat_2025
WHERE STUDIEFORM = 'Bunden'
GROUP BY UTBILDNINGSNAMN, UTBILDNINGSOMRÅDE
HAVING COUNT(*) >= 3
ORDER BY beviljandegrad DESC, ansökningar DESC;



-- Vilka utbildningar har högst beviljandegrad gällande utbildningsområde och utbildningslängd

SELECT UTBILDNINGSOMRÅDE, YH_POÄNG,
    COUNT(*) AS ansökningar,
    SUM(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) AS beviljade,
    ROUND(AVG(CASE WHEN BESLUT = 'Beviljad' THEN 1 ELSE 0 END) * 100,1) AS beviljandegrad
FROM resultat_2025
WHERE YH_POÄNG IS NOT NULL
GROUP BY UTBILDNINGSOMRÅDE, YH_POÄNG
ORDER BY beviljandegrad DESC, ansökningar DESC
FETCH FIRST 10 ROWS ONLY;



EXIT
