/*ESERCIZI DI PRATICA FALCOLTATIVA W11D2*/
SELECT 
    COUNT(DISTINCT dimproduct.ProductKey) AS NUMERO_RIGHE_NON_RIPETUTE,
    COUNT(dimproduct.ProductKey) AS NUMERO_RIGHE
FROM
    dimproduct;

/*RICHIESTA 2: VERIFICARE CHE LA COMBINAZIONE DI DUE CAMPI SIA UNA PRIMARY KEY*/
SELECT 
    COUNT(CONCAT(FACTSALES.SALESORDERNUMBER,
            FACTSALES.SALESORDERLINENUMBER)) AS NUMERO_CHIAVE,
    COUNT(*)
FROM
    FACTSALES;
/*METODO2:SE NON DA RISULTATO ALLORA E' PRIMARYKEY*/
SELECT 
    SalesOrderLineNumber, SalesOrderNumber, COUNT(*)
FROM
    FACTSALES
GROUP BY 1 , 2
HAVING COUNT(*) > 1;

/*RICHIESTA NUMERO 3: NUMERO TRANSAZIONI REALIZZATE OGNI GIORNO DAL 1 GENNAIO 2020*/
SELECT 
    ORDERDATE,
    COUNT(DISTINCT (SalesOrderNumber)) AS NUMERO_TRANSAZIONI
FROM
    factsales
WHERE
    YEAR(ORDERDATE) > '2019'
GROUP BY ORDERDATE
ORDER BY ORDERDATE;
/*RICHIESTA NUMERO 4:*/
SELECT 
    SUM(factresellersales.SalesAmount) AS FATTURATO_TOTALE,
    SUM(factresellersales.OrderQuantity) AS QUANTITA_TOTALE_VENDUTA,
    SUM(factresellersales.SalesAmount) / SUM(factresellersales.OrderQuantity) AS PREZZO_MEDIO,
    EnglishProductName
FROM
    factresellersales
        LEFT JOIN
    dimproduct ON factresellersales.ProductKey = dimproduct.ProductKey
WHERE
    FACTRESELLERSALES.ORDERDATE >= '2020-01-01'
GROUP BY EnglishProductName
ORDER BY 4;
/*5.Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory).
Il result set deve esporre pertanto il nome della categoria prodotto,
il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!*/
SELECT SUM(factresellersales.SalesAmount) AS FATTURATO_TOTALE, SUM(factresellersales.OrderQuantity) AS QUANTITA_VENDUTA, dimproductcategory.EnglishProductCategoryName
FROM factresellersales   JOIN dimproduct ON factresellersaleS.ProductKey=dimproduct.ProductKey JOIN dimproductsubcategory ON dimproductsubcategory.ProductSubcategoryKey=dimproduct.ProductSubcategoryKey LEFT JOIN
dimproductcategory ON dimproductsubcategory.ProductCategoryKey=dimproductcategory.ProductCategoryKey
group by dimproductcategory.EnglishProductCategoryName
ORDER BY 3;
/*6.Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K.*/
SELECT SUM(factresellersales.SalesAmount) AS TOTALE_FATTURATO , dimgeography.City AS CITTA
FROM factresellersales JOIN dimreseller ON factresellersales.ResellerKey=dimreseller.ResellerKey JOIN dimgeography ON dimreseller.GeographyKey=dimgeography.GeographyKey
WHERE factresellersales.OrderDate >= "2020.01.01"
GROUP BY dimgeography.City
HAVING SUM(factresellersales.SalesAmount) > 60000;
