/*RICHIESTA1*/
SELECT 
    COUNT(DISTINCT track.Name) AS numero_tracce, genre.Name
FROM
    track
        LEFT JOIN
    genre ON track.GenreId = genre.GenreId
GROUP BY track.GenreId
HAVING numero_tracce >= 10;

/*RICHIESTA2*/
SELECT 
    track.Name AS NOME_TRACCIA,
    track.UnitPrice AS PREZZO,
    mediatype.Name
FROM
    track
        LEFT JOIN
    mediatype ON TRACK.MediaTypeId = mediatype.MediaTypeId
ORDER BY 2 DESC
LIMIT 3;

/*richiesta3*/
SELECT DISTINCT
    artist.name AS NOME_ARTISTA
FROM

	track LEFT JOIN ALBUM ON album.AlbumId = track.AlbumId LEFT JOIN ARTIST ON artist.ArtistId = album.ArtistId
WHERE
    track.Milliseconds > 360000;

/*richiesta4*/
SELECT 
    genre.Name AS GENERE,
    CAST(AVG(track.Milliseconds) / 1000 AS DECIMAL(7,3)) AS durata_media_secondi,
    mediatype.Name AS FORMATO
FROM
    track
        LEFT JOIN
    genre ON track.GenreId = genre.GenreId
        LEFT JOIN
    mediatype ON track.MediaTypeId = mediatype.MediaTypeId
GROUP BY Genre.name , mediatype.Name
ORDER BY 1;

/*richieta5*/
SELECT 
    track.Name AS TRACCIA, genre.Name
FROM
    track
        LEFT JOIN
    genre ON track.GenreId = genre.GenreId
WHERE
    track.name LIKE '%love%'
    AND track.Name NOT LIKE "%__LOVE__%"
ORDER BY Genre.NAME , track.Name;

/*RICHIESTA6*/
SELECT 
    AVG(track.UnitPrice) AS COSTO_MEDIO,
    mediatype.NAME AS FORMATO
FROM
    track
        LEFT JOIN
    mediatype ON track.MediaTypeId = mediatype.MediaTypeId
GROUP BY mediatype.Name
ORDER BY 2;

/*RICHIESTA7*/
SELECT 
    COUNT(distinct track.Name) AS NUMERO_TRACCE, genre.NAME AS GENERE
FROM
    track
        LEFT JOIN
    genre ON track.GenreId = genre.GenreId
GROUP BY genre.NAME
ORDER BY 1 DESC
LIMIT 1;

/*RICHIESTA7-APPROCCIO2*/
SELECT G.NAME AS GENRE_NAME, COUNT(DISTINCT T.NAME) AS NUM_TRACK
FROM TRACK T 
LEFT JOIN GENRE G ON T.GENREID=G.GENREID
GROUP BY G.NAME
HAVING NUM_TRACK=(SELECT MAX(NUM_TRACK) FROM (SELECT G.NAME AS GENRE_NAME , COUNT(DISTINCT T.NAME) AS NUM_TRACK
FROM TRACK T
LEFT JOIN GENRE G ON T.GENREID=G.GENREID 
GROUP BY G.NAME) A );

/*RICHIESTA8*/
SELECT 
    ARTIST.Name AS NOME_ARTISTA, COUNT(*) AS NUMERO_ALBUM
FROM
    ALBUM
        LEFT JOIN
    artist ON album.ArtistId = artist.ArtistId
GROUP BY artist.Name
HAVING NUMERO_ALBUM = (SELECT 
        COUNT(*)
        FROM
            ALBUM
        LEFT JOIN artist ON album.ArtistId = artist.ArtistId
        WHERE
            artist.NAME LIKE 'THE ROLLING STONES');



/*RICHIESTA9*/
SELECT 
    ARTIST.NAME,
    ALBUM.ALBUMID,
    SUM(track.UnitPrice) AS PREZZO_TOTALE
FROM
    TRACK
        JOIN
    ALBUM ON TRACK.ALBUMID = ALBUM.ALBUMID
        JOIN
    ARTIST ON ALBUM.ArtistId = artist.ArtistId
GROUP BY album.ALBUMID
ORDER BY 3 DESC
LIMIT 1;

/*RICHIESTA9-APPROCCIO2*/
SELECT AR.NAME ARTIST, AL.TITLE ALBUM
FROM TRACK T
LEFT JOIN ALBUM AL ON T.ALBUMID=AL.ALBUMID
LEFT JOIN ARTIST AR ON AL.ARTISTID=AR.ARTISTID
GROUP BY AR.NAME, AL.TITLE
HAVING SUM(T.UNITPRICE)=( SELECT MAX(ALBUM_PRICE)
FROM(
SELECT AR.NAME ARTIST, AL.TITLE ALBUM, SUM(T.UNITPRICE) AS ALBUM_PRICE
FROM TRACK T
LEFT JOIN ALBUM AL ON T.ALBUMID=AL.ALBUMID
LEFT JOIN ARTIST AR ON AL.ARTISTID=AR.ARTISTID
GROUP BY AR.NAME, AL.TITLE)A);


