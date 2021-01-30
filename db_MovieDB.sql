/* Creazione database*/
CREATE SCHEMA IF NOT EXISTS db_MovieDB;
USE db_MovieDB ;

/*Creazione tabella Contenuto*/
CREATE TABLE IF NOT EXISTS db_MovieDB.Contenuto (
  IDContenuto INT UNSIGNED AUTO_INCREMENT NOT NULL,
  Titolo VARCHAR (50) NOT NULL,
  Sinossi VARCHAR(500) NOT NULL,
  AnnoProduzione VARCHAR(4) NOT NULL,
  ImgCopertina VARCHAR(2048) NOT NULL,
  Trailer VARCHAR(2048) NOT NULL, 
  MiPiace INT UNSIGNED NOT NULL, 
  Cast VARCHAR (500) NOT NULL,
  Valutazione FLOAT UNSIGNED NOT NULL,
  
  CHECK (Valutazione>=1 AND Valutazione<=5),
	
  PRIMARY KEY (IDContenuto)
)
ENGINE=InnoDB;

/*Creazione tabella Genere*/
CREATE TABLE IF NOT EXISTS db_MovieDB.Genere (
  Tipo VARCHAR(15) NOT NULL,
  Contenuto_IDContenuto INT UNSIGNED NOT NULL,
	
  CHECK (
			Tipo="Romantico" OR Tipo="Anime" OR Tipo="Serie tv" OR Tipo="Film" OR Tipo="Drammatico" OR Tipo="Avventura" OR Tipo="Azione"
            OR Tipo="Indie" OR Tipo="Crime" OR Tipo="Thriller" OR Tipo="Horror" OR Tipo="Bambini" OR Tipo="Documentari" OR Tipo="Commedia"
            OR Tipo="Fantascienza" OR Tipo="Fantasy" OR Tipo="Musical"
		),
  PRIMARY KEY (Tipo, Contenuto_IDContenuto),
  FOREIGN KEY (Contenuto_IDContenuto)
  REFERENCES db_MovieDB.Contenuto (IDContenuto)
  
  ON DELETE CASCADE
)
ENGINE=InnoDB;

/*Creazione tabella Film*/
CREATE TABLE IF NOT EXISTS db_MovieDB.Film (
  Durata FLOAT NOT NULL, 
  Regista VARCHAR (100) NOT NULL,
  Contenuto_IDContenuto INT UNSIGNED NOT NULL,
  
	PRIMARY KEY (Contenuto_IDContenuto),
    FOREIGN KEY (Contenuto_IDContenuto)
    REFERENCES db_MovieDB.Contenuto (IDContenuto)
    
    ON DELETE CASCADE
)
ENGINE=InnoDB;

/*Creazione tabella Serie tv*/
CREATE TABLE IF NOT EXISTS db_MovieDB.SerieTV (
  Stagioni VARCHAR (2) NOT NULL, 
  Puntate VARCHAR (4) NOT NULL,
  DurataEp FLOAT NOT NULL,
  Contenuto_IDContenuto INT UNSIGNED NOT NULL,
  
	PRIMARY KEY (Contenuto_IDContenuto),
    FOREIGN KEY (Contenuto_IDContenuto)
    REFERENCES db_MovieDB.Contenuto (IDContenuto)
    
    ON DELETE CASCADE
)
ENGINE=InnoDB;

/*Creazione tabella Piattaforma*/
CREATE TABLE IF NOT EXISTS db_MovieDB.Piattaforma (
  Nome VARCHAR (50) NOT NULL, 
  ImgPiattaforma VARCHAR (2048) NOT NULL,
  Link VARCHAR (2048) NOT NULL,
  AbbMinimo FLOAT NOT NULL,
 
	PRIMARY KEY (Nome)
   
   
)
ENGINE=InnoDB;

/*Creazione tabella Utente*/
CREATE TABLE IF NOT EXISTS db_MovieDB.Utente (
  Email VARCHAR (200) NOT NULL,
  Nome VARCHAR (50) NOT NULL,
  Cognome VARCHAR(50) NOT NULL,
  PassUtente CHAR(32) NOT NULL, 
  Tipo CHAR(2) NOT NULL,
  
  CHECK (Tipo="US" OR Tipo="MM"),
  
  PRIMARY KEY (Email)
)
ENGINE=InnoDB;

/*Creazione tabella Segnalazione*/
CREATE TABLE IF NOT EXISTS db_MovieDB.Segnalazione (
  IDSegnalazione INT UNSIGNED AUTO_INCREMENT NOT NULL, 
  Oggetto VARCHAR (25) NOT NULL,
  Messaggio VARCHAR (50) NOT NULL,
  Stato VARCHAR (20) DEFAULT "Ricevuta" NOT NULL,
  Utente_Email VARCHAR (200),
  
  CHECK (Stato="PresaIncarico" OR Stato="Ricevuta" OR Stato="Verificata"),
  
  PRIMARY KEY (IDSegnalazione),
  FOREIGN KEY (Utente_Email)
  REFERENCES db_MovieDB.Utente (Email)
    
  ON DELETE CASCADE
)
ENGINE=InnoDB;

/*Creazione tabella Presente su*/
CREATE TABLE IF NOT EXISTS db_MovieDB.PresenteSu(
	Contenuto_IDContenuto INT UNSIGNED NOT NULL,
	Piattaforma_Nome VARCHAR (150) NOT NULL,
    
    PRIMARY KEY(Contenuto_IDContenuto,Piattaforma_Nome),
	FOREIGN KEY (Contenuto_IDContenuto)
    REFERENCES db_MovieDB.Contenuto(IDContenuto),
    FOREIGN KEY (Piattaforma_Nome)
    REFERENCES db_MovieDB.Piattaforma(Nome)
)
ENGINE = InnoDB;

/*Creazione tabella Preferiti*/
CREATE TABLE IF NOT EXISTS db_MovieDB.Preferiti(
	Contenuto_IDContenuto INT UNSIGNED NOT NULL,
	Utente_Email VARCHAR (200) NOT NULL,
    
    PRIMARY KEY(Contenuto_IDContenuto,Utente_Email),
	FOREIGN KEY (Contenuto_IDContenuto)
    REFERENCES db_MovieDB.Contenuto(IDContenuto),
    FOREIGN KEY (Utente_Email)
    REFERENCES db_MovieDB.Utente(Email)
)
ENGINE = InnoDB;

/*Creazione tabella Piaciuti*/
CREATE TABLE IF NOT EXISTS db_MovieDB.Piaciuti(
	Contenuto_IDContenuto INT UNSIGNED NOT NULL,
	Utente_Email VARCHAR (200) NOT NULL,
    
    PRIMARY KEY(Contenuto_IDContenuto,Utente_Email),
	FOREIGN KEY (Contenuto_IDContenuto)
    REFERENCES db_MovieDB.Contenuto(IDContenuto),
    FOREIGN KEY (Utente_Email)
    REFERENCES db_MovieDB.Utente(Email)
)
ENGINE = InnoDB;

/*Creazione tabella Visti*/
CREATE TABLE IF NOT EXISTS db_MovieDB.Visti(
	Contenuto_IDContenuto INT UNSIGNED NOT NULL,
	Utente_Email VARCHAR (200) NOT NULL,
    
    PRIMARY KEY(Contenuto_IDContenuto,Utente_Email),
	FOREIGN KEY (Contenuto_IDContenuto)
    REFERENCES db_MovieDB.Contenuto(IDContenuto),
    FOREIGN KEY (Utente_Email)
    REFERENCES db_MovieDB.Utente(Email)
)
ENGINE = InnoDB;



