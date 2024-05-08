/*Per prima cosa ho settato il DB adv come Db  di default per evitare ambiguità all'interno dello script che seguirà */
/*Richiesta 1: esplorare la tabella DimProduct*/
select *
from dimproduct;
/*Richiesta 2:Richiamare solo alcuni campi con relativo alias*/
SELECT 
    dimproduct.productkey AS codice_sequenziale,
    dimproduct.ProductAlternateKey AS codice_alfanumerico,
    dimproduct.englishproductname AS nome_inglese,
    dimproduct.color AS colore_prodotto,
    dimproduct.StandardCost AS costo_standard,
    dimproduct.FinishedGoodsFlag AS codice_booleano
FROM
    dimproduct;
/*Richiesta 3: Creare una nuova select con codici modello che iniziano solo per FR o BK*/
select
dimproduct.ProductAlternateKey,
dimproduct.ProductKey,
dimproduct.ModelName,
dimproduct.EnglishProductName,
dimproduct.StandardCost,
dimproduct.ListPrice
from dimproduct where dimproduct.ProductAlternateKey like "FR%" or dimproduct.ProductAlternateKey like "BK%";
/*Richiesta 4: Partendo dalla query precedente esporre solo i prodotti finiti con FinishedGoodsFlag=1*/
select
dimproduct.ProductAlternateKey,
dimproduct.ProductKey,
dimproduct.ModelName,
dimproduct.EnglishProductName,
dimproduct.StandardCost,
dimproduct.ListPrice,
dimproduct.finishedgoodsflag
from dimproduct where ((dimproduct.ProductAlternateKey like "FR%" or dimproduct.ProductAlternateKey like "BK%") and dimproduct.FinishedGoodsFlag=1); 
/*Richiesta 5: Arricchisci il risulatato della query utilizzando una colonna calcolata*/
select
dimproduct.ProductAlternateKey,
dimproduct.ProductKey,
dimproduct.ModelName,
dimproduct.EnglishProductName,
dimproduct.StandardCost,
dimproduct.ListPrice,
dimproduct.finishedgoodsflag,
(dimproduct.ListPrice-dimproduct.StandardCost) as Markup
from dimproduct;
/*Richiesta 6: Prodotti con prezzo di listino compreso tra 1000 e 2000*/
select
dimproduct.ProductAlternateKey,
dimproduct.ProductKey,
dimproduct.ModelName,
dimproduct.EnglishProductName,
dimproduct.StandardCost,
dimproduct.ListPrice,
dimproduct.finishedgoodsflag
from 
dimproduct
where
dimproduct.ListPrice between 1000 and 2000;
/*Richiesta 7: Esplorare tabella impiegati aziendali*/
select
*
from dimemployee;
/*Richiesta 8: Esporre elenco dei soli agenti con Salespersonflag=1*/
select
*
from
dimemployee
where dimemployee.SalesPersonFlag = 1;
/*Richiesta 9: transazioni a partire dai 1/1/2020 con codici prodotto specifici*/
select*
from factresellersales;
select
*,
(factresellersales.SalesAmount-factresellersales.TotalProductCost) as Profit
from 
factresellersales
where ((ProductKey=597 or ProductKey=598 or ProductKey=477 or ProductKey=214) and OrderDate >="2020-01-01");

