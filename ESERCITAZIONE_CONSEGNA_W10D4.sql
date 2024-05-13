/*SECONDA CONSEGNA W10D4 ED ESERCITAZIONE SULLE JOIN E SUBQUERY*/
/*RICHIESTA 1*/
SELECT 
*
FROM
dimproduct 
JOIN
dimproductsubcategory  ON
dimproduct.ProductSubcategoryKey=dimproductsubcategory.ProductCategoryKey;

/*RICHIESTA 2*/
SELECT
dimproduct.*, dimproductsubcategory.EnglishProductSubcategoryName
FROM dimproduct JOIN dimproductsubcategory ON dimproduct.ProductSubcategoryKey=dimproductsubcategory.ProductSubcategoryKey
JOIN dimproductcategory ON dimproductsubcategory.ProductSubcategoryKey=dimproductcategory.ProductCategoryKey;

/*RICHIESTA 3*/
SELECT DISTINCT
dimproduct.EnglishProductName
FROM dimproduct
JOIN factresellersales ON dimproduct.ProductKey=factresellersales.ProductKey
order by 1;


/*RICHIESTA 4*/
select *
from dimproduct
where dimproduct.productkey not in 
 (SELECT 
    dimproduct.ProductKey
FROM
dimproduct
JOIN
factresellersales AS f ON dimproduct.ProductKey = f.ProductKey)
and dimproduct.finishedgoodsflag=1;

/*RICHIESTA 5*/


select f.SalesOrderNumber as Codice_ordine, p.EnglishProductName as Prodotto, f.OrderDate as Data_ordine, f.SalesAmount as Totale

from factresellersales as f join dimproduct AS P ON P.ProductKey=f.ProductKey;

/*RICHIESTA 6*/
SELECT
f.SalesOrderNumber as Codice_ordine, p.EnglishProductName AS Prodotto, c.EnglishProductCategoryName as Categoria,

f.OrderDate as Data_Oedine, f.SalesAmount as Totale

from factresellersales as f

Join dimproduct as p ON p.ProductKey = f. Productkey

join dimproductsubcategory as d on p.ProductSubcategoryKey = d.ProductCategoryKey

join DimProductCategory as c on d.ProductCategoryKey = c.ProductCategoryKey;
/*RICHIESTA 7/8*/
SELECT 
R.*, G.*
FROM
dimgeography AS G JOIN dimreseller AS R ON R.GeographyKey=G.GeographyKey;
/*RICHIESTA 9*/
SELECT 
P.EnglishProductName, T.*, F.*, D.*
FROM 
DIMPRODUCT AS P JOIN factinternetsales AS F ON P.PRODUCTKEY=f.ProductKey
JOIN dimsalesterritory AS T ON F.SALESTERRITORYKEY=T.SalesTerritoryAlternateKey
JOIN dimgeography AS D ON T.SalesTerritoryAlternateKey=D.SalesTerritoryKey;