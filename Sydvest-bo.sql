use master
go
if exists(select * from sys.databases where name = 'Sydvest-bo')
begin
	drop database [Sydvest-bo]
end
go


create database [Sydvest-bo]
go


use [Sydvest-bo]
go

CREATE TABLE Udlejningskonsulenter
(
KonsulentID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Fornavn varchar(50) NOT NULL,
Efternavn varchar(50) NOT NULL,
Adresse varchar(50) NOT NULL,
Postnr int NOT NULL CHECK(Postnr > 99 and Postnr < 10000),
Tlf int NOT NULL,
Email nvarchar(50) DEFAULT 'Ingen',
L�n int NOT NULL,
Ans�ttelsesdato DATE NOT NULL
)
GO

CREATE TABLE Ejer
(
EjerID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Fornavn varchar(50) NOT NULL,
Efternavn varchar(50) NOT NULL,
Adresse varchar(50) NOT NULL,
Postnr int NOT NULL CHECK(Postnr > 99 and Postnr < 10000),
Tlf int NOT NULL,
Email nvarchar(50) DEFAULT 'Ingen',
[Kontrakt-periode] varchar(100) NOT NULL
)
GO

CREATE TABLE Opsynsm�nd
(
OpsynsmandID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Fornavn varchar(50) NOT NULL,
Efternavn varchar(50) NOT NULL,
Adresse varchar(50) NOT NULL,
Postnr int NOT NULL CHECK(Postnr > 99 and Postnr < 10000),
Tlf int NOT NULL,
Email nvarchar(50) DEFAULT 'Ingen',
Timel�n int NOT NULL
)
GO

CREATE TABLE Sommerhuse
(
SummerhusID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Adresse varchar(50) NOT NULL,
Postnr int NOT NULL CHECK(Postnr > 99 and Postnr < 10000),
KonsulentID int NOT NULL,
Lejeperiode varchar(50) NOT NULL,
Pris int NOT NULL,
EjerID int NOT NULL FOREIGN KEY (EjerID) REFERENCES Ejer(EjerID),
OpsynsmandID int NOT NULL FOREIGN KEY (OpsynsmandID) REFERENCES Opsynsm�nd(OpsynsmandID)
)
GO

CREATE TABLE Lejligheder
(
LejlighedID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Adresse varchar(50) NOT NULL,
Postnr int NOT NULL CHECK(Postnr > 99 and Postnr < 10000),
Lejeperiode date NOT NULL,
Pris int NOT NULL,
KonsulentID int NOT NULL FOREIGN KEY (KonsulentID) REFERENCES Udlejningskonsulenter(KonsulentID)
)
GO



CREATE TABLE Lejlighedskomplekser
(
LejlighedskompleksID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Adresse varchar(50) NOT NULL,
Postnr int NOT NULL CHECK(Postnr > 99 and Postnr < 10000),
Tlf int NOT NULL,
Email nvarchar(50) DEFAULT 'Ingen',
[Kontrakt-periode] date NOT NULL
)
GO


CREATE TABLE Inspekt�rer
(
Inspekt�rID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Fornavn varchar(50) NOT NULL,
Efternavn varchar(50) NOT NULL,
Adresse varchar(50) NOT NULL,
Postnr int NOT NULL CHECK(Postnr > 99 and Postnr < 10000),
Tlf int NOT NULL,
Email nvarchar(50)DEFAULT 'Ingen',
L�n int NOT NULL
)
GO



CREATE TABLE Kunde
(
KundeID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Fornavn nvarchar(50) NOT NULL,
Efternavn nvarchar(50) NOT NULL,
Adresse nvarchar(50) NOT NULL,
Postnr int,
Tlf bigint NOT NULL,
Email nvarchar(50)DEFAULT 'Ingen',
Lejeperiode varchar(70) NOT NULL,
Nationalitet varchar(30) NOT NULL

)
GO

CREATE TABLE Omr�de
(
Omr�de varchar(50) NOT NULL,
SummerhusID INT NOT NULL FOREIGN KEY (SummerhusID) REFERENCES Sommerhuse(SummerhusID),
KonsulentID INT NOT NULL FOREIGN KEY (KonsulentID) REFERENCES Udlejningskonsulenter(KonsulentID),
PRIMARY KEY (SummerhusID, KonsulentID)
)
GO


INSERT INTO Udlejningskonsulenter (Fornavn,Efternavn,Adresse,Postnr,Tlf,Email,L�n,Ans�ttelsesdato) VALUES
                                  ('Karsten','Hansen','Fugleh�j 24',3000,20203476,'KarstenHansen@gmail.com',34000,'20200310'),
								  ('Lars','Larsen','M�lleh�j 12',2400,24508542,'Larslars@gmail.com',37000,'20170824'),
								  ('Kirsten','Johanne','Fluevej 74',7400,87654092,'Kirstenjohan@gmail.com',35000,'20190729')

GO

INSERT INTO Ejer(Fornavn,Efternavn,Adresse,Postnr,Tlf,Email,[Kontrakt-periode]) VALUES
                ('Egon','Olsen','Folkevej 22',3700,64738292,'Olsenbanden@gmail.com','1/01/19-1/01/20'),
				('Ulrik','L�bebane','Gaden 12',4300,20120094,'L�bebanden@gmail.com','1/05/19-1/05/22'),
				('Mette','Vanne','Kirkeg�rdvej 92',8400,24028472,'Vanne@gmail.com','01/12/19-1/01/21')




INSERT INTO Opsynsm�nd(Fornavn,Efternavn,Adresse,Postnr,Tlf,Email,Timel�n) VALUES
                      ('Niels','Bierkesen','Langevej 25',1400,97647274,'Bierkesen@gmail.com',174),
					  ('Lise','Karlesen','Bakken 4',6400,74788394,'Karlesen@gmail.com',183),
					  ('Anne','�benmund','Humlevej 94',2400,27356372,'�benmund@gmail.com',154)


INSERT INTO Sommerhuse(Adresse,Postnr,KonsulentID,Lejeperiode,Pris,EjerID,OpsynsmandID) VALUES
					  ('Lankevej 2',2500,3,'1/1/2013-1/1/2021',500000,2,1),
					  ('M�lkestr�m 14',3400,2,'1/1/2019-1/1/2024',350000,3,3),
					  ('Underbro 22',6400,1,'1/4/2016-1/1/2021',650000,1,2)


INSERT INTO Inspekt�rer(Fornavn,Efternavn,Adresse,Postnr,Tlf,Email,L�n) VALUES
					   ('Morten','J�rgensen','Hjorteh�j 74',7400,72738495,'MortenJ�rgensen@gmail.com',35000),
					   ('Peter','Tork','Hjorteh�j 74',7400,82749572,'PeterTork@gmail.com',36000),
					   ('Jospeh','�sel','Stalden 13',1200,74829363,'�sel@gmail.com',31000)


INSERT INTO Kunde(Fornavn,Efternavn,Adresse,Postnr,Tlf,Email,Lejeperiode,Nationalitet) VALUES
				 ('Gustav','Duffel','Niechten 382',0,4983722535,'Duffelsnitchel@gmail.com','4-01-2020-11-01-2020','Tyskland'),
				 ('Klaus','Jav���l','Niechten 22',0,4956748289,'Jav���l@gmail.com','11-01-2020-18-01-2020','Tyskland'),
				 ('Birgitte','Skosnavs','Marieh�nen 2',9200,24627383,'Skosnavs@gmail.com','18-01-2020-25-01-2020','Danmark')



INSERT INTO Omr�de(Omr�de,SummerhusID,KonsulentID) VALUES
                  ('Sydjylland',3,1),
				  ('Sj�lland',2,2),
				  ('Sj�lland',1,3)

SELECT * FROM Kunde