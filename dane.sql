------------------------- tworzenie bazy (do porawy) ----------------------

CREATE TABLE projekt.Typy_platnosci (
                id_typplatnosc INTEGER NOT NULL,
                opis VARCHAR NOT NULL,
                CONSTRAINT id_typplatnosc PRIMARY KEY (id_typplatnosc)
);


CREATE TABLE projekt.Uslugi (
                id_uslugi VARCHAR NOT NULL,
                opis_uslugi VARCHAR NOT NULL,
                cena NUMERIC NOT NULL,
                CONSTRAINT id_uslugi PRIMARY KEY (id_uslugi)
);


CREATE TABLE projekt.Agent (
                id_agent INTEGER NOT NULL,
                nazwa_agencji VARCHAR NOT NULL,
                mail VARCHAR NOT NULL,
                telefon VARCHAR NOT NULL,
                CONSTRAINT id_agent PRIMARY KEY (id_agent)
);


CREATE TABLE projekt.Typy_pokoi (
                id_typpokoj VARCHAR NOT NULL,
                opis VARCHAR NOT NULL,
                CONSTRAINT id_typpokoj PRIMARY KEY (id_typpokoj)
);


CREATE TABLE projekt.Status_rezerwacji (
                id_status INTEGER NOT NULL,
                status_opis VARCHAR NOT NULL,
                CONSTRAINT id_status PRIMARY KEY (id_status)
);


CREATE SEQUENCE projekt.goscie_id_gosc_seq;

CREATE TABLE projekt.goscie (
                id_gosc INTEGER NOT NULL DEFAULT nextval('projekt.goscie_id_gosc_seq'),
                imie VARCHAR NOT NULL,
                nazwisko VARCHAR NOT NULL,
                telefon VARCHAR NOT NULL,
                mail VARCHAR NOT NULL,
                CONSTRAINT id_gosc PRIMARY KEY (id_gosc)
);


ALTER SEQUENCE projekt.goscie_id_gosc_seq OWNED BY projekt.goscie.id_gosc;

CREATE SEQUENCE projekt.rezerwacje_dane_id_rezerwacji_seq;

CREATE TABLE projekt.Rezerwacje_dane (
                id_rezerwacji INTEGER NOT NULL DEFAULT nextval('projekt.rezerwacje_dane_id_rezerwacji_seq'),
                id_agent INTEGER,
                id_gosc INTEGER,
                id_status INTEGER NOT NULL,
                CONSTRAINT id_rezerwacji PRIMARY KEY (id_rezerwacji)
);


ALTER SEQUENCE projekt.rezerwacje_dane_id_rezerwacji_seq OWNED BY projekt.Rezerwacje_dane.id_rezerwacji;

CREATE TABLE projekt.Hotele (
                id_hotel INTEGER NOT NULL,
                nazwa VARCHAR NOT NULL,
                kraj VARCHAR NOT NULL,
                miasto VARCHAR NOT NULL,
                adres VARCHAR NOT NULL,
                telefon VARCHAR NOT NULL,
                strInt VARCHAR NOT NULL,
                mail VARCHAR NOT NULL,
                CONSTRAINT id_hotel PRIMARY KEY (id_hotel)
);


CREATE TABLE projekt.Pokoje (
                nr_pokoju INTEGER NOT NULL,
                id_hotel INTEGER NOT NULL,
                id_typpokoj VARCHAR NOT NULL,
                pietro INTEGER NOT NULL,
                cena INTEGER NOT NULL,
                dlaPalacych BOOLEAN NOT NULL,
                ile_osob INTEGER NOT NULL,
                CONSTRAINT nr_pokoju PRIMARY KEY (nr_pokoju, id_hotel)
);


CREATE TABLE projekt.Rezerwacje (
                id_rezerwacji INTEGER NOT NULL,
                nr_pokoju INTEGER NOT NULL,
                id_hotel INTEGER NOT NULL,
                dataOd DATE NOT NULL,
                dataDo DATE NOT NULL,
                CONSTRAINT id PRIMARY KEY (id_rezerwacji, nr_pokoju, id_hotel)
);


CREATE SEQUENCE projekt.platnosc_id_platnosc_seq;

CREATE TABLE projekt.platnosc (
                id_platnosc VARCHAR NOT NULL DEFAULT nextval('projekt.platnosc_id_platnosc_seq'),
                id_rezerwacji INTEGER NOT NULL,
                nr_pokoju INTEGER NOT NULL,
                id_hotel INTEGER NOT NULL,
                id_typplatnosc INTEGER NOT NULL,
                CONSTRAINT id_platnosc PRIMARY KEY (id_platnosc, id_rezerwacji, nr_pokoju, id_hotel)
);


ALTER SEQUENCE projekt.platnosc_id_platnosc_seq OWNED BY projekt.platnosc.id_platnosc;

CREATE TABLE projekt.UslugiPokoj (
                id_uslugi VARCHAR NOT NULL,
                id_rezerwacji INTEGER NOT NULL,
                nr_pokoju INTEGER NOT NULL,
                id_hotel INTEGER NOT NULL,
                CONSTRAINT id_uslugpokoj PRIMARY KEY (id_uslugi, id_rezerwacji, nr_pokoju, id_hotel)
);


CREATE TABLE projekt.Pracownicy (
                id_pracownik INTEGER NOT NULL,
                id_hotel INTEGER NOT NULL,
                imie VARCHAR NOT NULL,
                nazwisko VARCHAR NOT NULL,
                telefon VARCHAR NOT NULL,
                stanowisko VARCHAR NOT NULL,
                pensja NUMERIC NOT NULL,
                id_przelozony INTEGER NOT NULL,
                CONSTRAINT id_pracownik PRIMARY KEY (id_pracownik)
);

CREATE TABLE projekt.Users(
                id INTEGER NOT NULL,
                username VARCHAR NOT NULL,
                pass VARCHAR NOT NULL
);


ALTER TABLE projekt.platnosc ADD CONSTRAINT typy_platnosci_platnosc_fk
FOREIGN KEY (id_typplatnosc)
REFERENCES projekt.Typy_platnosci (id_typplatnosc)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.UslugiPokoj ADD CONSTRAINT uslugi_uslugipokoj_fk
FOREIGN KEY (id_uslugi)
REFERENCES projekt.Uslugi (id_uslugi)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.Rezerwacje_dane ADD CONSTRAINT agent_rezerwacje_fk
FOREIGN KEY (id_agent)
REFERENCES projekt.Agent (id_agent)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.Pokoje ADD CONSTRAINT typy_pokoi_pokoje_fk
FOREIGN KEY (id_typpokoj)
REFERENCES projekt.Typy_pokoi (id_typpokoj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.Rezerwacje_dane ADD CONSTRAINT status_rezerwacji_rezerwacje_fk
FOREIGN KEY (id_status)
REFERENCES projekt.Status_rezerwacji (id_status)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.Rezerwacje_dane ADD CONSTRAINT guests_bookings_fk
FOREIGN KEY (id_gosc)
REFERENCES projekt.goscie (id_gosc)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.Rezerwacje ADD CONSTRAINT rezerwacje_rezerwacje_fk
FOREIGN KEY (id_rezerwacji)
REFERENCES projekt.Rezerwacje_dane (id_rezerwacji)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.Pracownicy ADD CONSTRAINT hotels_staff_fk
FOREIGN KEY (id_hotel)
REFERENCES projekt.Hotele (id_hotel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.Pokoje ADD CONSTRAINT hotels_rooms_fk
FOREIGN KEY (id_hotel)
REFERENCES projekt.Hotele (id_hotel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.Rezerwacje ADD CONSTRAINT pokoje_rezerwacje_fk
FOREIGN KEY (nr_pokoju, id_hotel)
REFERENCES projekt.Pokoje (nr_pokoju, id_hotel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.UslugiPokoj ADD CONSTRAINT rezerwacje_uslugipokoj_fk
FOREIGN KEY (id_rezerwacji, nr_pokoju, id_hotel)
REFERENCES projekt.Rezerwacje (id_rezerwacji, nr_pokoju, id_hotel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.platnosc ADD CONSTRAINT rezerwacje_platnosc_fk
FOREIGN KEY (id_rezerwacji, nr_pokoju, id_hotel)
REFERENCES projekt.Rezerwacje (id_rezerwacji, nr_pokoju, id_hotel)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projekt.Pracownicy ADD CONSTRAINT staff_staff_fk
FOREIGN KEY (id_przelozony)
REFERENCES projekt.Pracownicy (id_pracownik)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


------------------------ wstawianie danych ------------------------------------------------
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Anna', 'Kowalska', '649187359', 'annkow@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Wiktor', 'Jasinski', '619764513', 'wikjas@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Kamil', 'Marek', '643798156', 'kammar@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Maria', 'Wesolowska', '315874921', 'annwes@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Kamila', 'Kielek', '461975821', 'kamkie@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Barbara', 'Nowak', '461976829', 'barnow@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Tomasz', 'Paciorek', '349781356', 'tompac@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Karol', 'Gora', '346916738', 'kargor@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Ewelina', 'Maciaszek', '976132658', 'ewemac@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Ewa', 'Klepka', '469735013', 'ewakle@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Kacper', 'Abacki', '469816123', 'kacaba@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Wiktoria', 'Babacka', '549138261', 'wikbab@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Joanna', 'Dadacka', '214683428', 'joadad@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Eliza', 'Kakacka', '316452822', 'elizkak@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Konrad', 'Papacki', '468372819', 'konpap@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Gabriel', 'Tatacki', '595954123', 'gabtat@gmail.com');
INSERT INTO Goscie(imie, nazwisko, telefon, mail) VALUES ('Leon', 'Mamacki', '458219785', 'leomam@gmail.com');

INSERT INTO agent VALUES(1, 'Itaka', 'itaka@gmail.com', '513698745');
INSERT INTO agent VALUES(2, 'TravelPlanet', 'tp@gmail.com','65412365/');
INSERT INTO agent VALUES(3, 'Rainbow Tours', 'rainbow@gmail.com', '698741321');
INSERT INTO agent VALUES(4, 'Ecco Holiday', 'eccoholiday@gmail.com', '136547852');

INSERT INTO Typy_platnosci VALUES(1,'gotowka');
INSERT INTO Typy_platnosci VALUES(2,'karta kredytowa');
INSERT INTO Typy_platnosci VALUES(3,'czek');
INSERT INTO Typy_platnosci VALUES(4,'przelew');

INSERT INTO Status_rezerwacji VALUES(1,'Zarezerwowane');
INSERT INTO Status_rezerwacji VALUES(2,'Rezerwacja anulowana');
INSERT INTO Status_rezerwacji VALUES(3,'Wplacona zaliczka');
INSERT INTO Status_rezerwacji VALUES(4,'Pobyt wykupiony');

INSERT INTO Uslugi VALUES(1,'Sprzatanie pokoju', 20.00);
INSERT INTO Uslugi VALUES(2,'All Inclusive', 70.00);
INSERT INTO Uslugi VALUES(3,'Telewizja dodatkowe kanaly', 30.00);
INSERT INTO Uslugi VALUES(4,'Wyzywienie', 50.00);


INSERT INTO hotele VALUES(1, 'Kazimierz', 'Polska', 'Krakow', 'Starowislna 55','6791263157', 'www.hotelkazimierz.pl', 'hotelKazimierz@hotels.com');
INSERT INTO hotele VALUES(2, 'Varsovia', 'Polska', 'Warszawa', 'Marszalkowska 355','546197282', 'www.Varsovia.pl', 'Varsovia@hotels.com');

INSERT INTO Typy_pokoi VALUES(1,'Apartament');
INSERT INTO Typy_pokoi VALUES(2,'Normalny standard');
INSERT INTO Typy_pokoi VALUES(3,'Wysoki standard');
INSERT INTO Typy_pokoi VALUES(4,'Penthouse');


INSERT INTO Pracownicy VALUES(1, 1, 'Marion', 'Moseby', '316428456', 'Kierownik hotelu', null,5000.00);
INSERT INTO Pracownicy VALUES(2, 1, 'Kamila', 'Koziolek', '316428456', 'Szef kuchni', 1,4000.00);
INSERT INTO Pracownicy VALUES(3, 1, 'Artur', 'Frankowski', '316428456', 'Kierownik zmiany', 1, 3500.00);
INSERT INTO Pracownicy VALUES(4, 1, 'Natalia', 'Pietruszka', '316428456', 'Osoba zmywajaca', 2,2000.00);
INSERT INTO Pracownicy VALUES(5, 1, 'Jakub', 'Blaszczyk', '316428456', 'Kucharz', 2, 3000.00);
INSERT INTO Pracownicy VALUES(6, 1, 'Marian', 'Wamor', '316428456', 'Boy hotelowy', 3, 2000.00);
INSERT INTO Pracownicy VALUES(7, 1, 'Barbara', 'Kamyk', '316428456', 'Sprzataczka', 3,2000.00);

INSERT INTO Pracownicy VALUES(8, 2, 'Anna', 'Pieczarka', '316428456', 'Kierownik hotelu', null,8000.00);
INSERT INTO Pracownicy VALUES(9, 2, 'Jacek', 'Bomba', '316428456', 'Szef kuchni', 8, 7000.00);
INSERT INTO Pracownicy VALUES(10, 2, 'Katarzyna', 'Pasek', '316428456', 'Kierownik zmiany', 8, 6000.00);
INSERT INTO Pracownicy VALUES(11, 2, 'Patryk', 'Nowak', '316428456', 'Osoba zmywajaca', 9,3000.00);
INSERT INTO Pracownicy VALUES(12, 2, 'Kacper', 'Kowalski', '316428456', 'Kucharz', 9,4000.00);
INSERT INTO Pracownicy VALUES(13, 2, 'Jan', 'Poniedzielski', '316428456', 'Boy hotelowy', 10,3000.00);
INSERT INTO Pracownicy VALUES(14, 2, 'Janina', 'MosKozaeby', '316428456', 'Sprzataczka', 10,3000.00);



INSERT INTO Pokoje VALUES(1,1,2,1, 120.00,FALSE,2 );
INSERT INTO Pokoje VALUES(2,1,2,1, 160.00,TRUE,3 );
INSERT INTO Pokoje VALUES(3,1,2,1, 80.00,TRUE,1 );
INSERT INTO Pokoje VALUES(4,1,2,2, 80.00,FALSE,1 );
INSERT INTO Pokoje VALUES(5,1,2,2, 120.00,TRUE,2 );
INSERT INTO Pokoje VALUES(6,1,2,2, 160.00,TRUE,3 );

INSERT INTO Pokoje VALUES(7,1,3,3, 160.00,FALSE,1 );
INSERT INTO Pokoje VALUES(8,1,3,3, 300.00,TRUE,2 );
INSERT INTO Pokoje VALUES(9,1,3,3, 420.00,TRUE,3 );

INSERT INTO Pokoje VALUES(10,1,1,4, 650.00,FALSE,2 );
INSERT INTO Pokoje VALUES(11,1,1,4, 800.00,FALSE,3 );
INSERT INTO Pokoje VALUES(12,1,4,5, 1000.00,FALSE,3 );

INSERT INTO Pokoje VALUES(1,2,2,1, 150.00,TRUE,2 );
INSERT INTO Pokoje VALUES(2,2,2,1, 150.00,TRUE,2 );
INSERT INTO Pokoje VALUES(3,2,2,1, 150.00,TRUE,2 );
INSERT INTO Pokoje VALUES(4,2,2,2, 150.00,TRUE,2 );
INSERT INTO Pokoje VALUES(5,2,2,2, 200.00,TRUE,3 );
INSERT INTO Pokoje VALUES(6,2,2,2, 200.00,TRUE,3 );

INSERT INTO Pokoje VALUES(7,2,3,3, 400.00,TRUE,2 );
INSERT INTO Pokoje VALUES(8,2,3,3, 400.00,TRUE,2 );
INSERT INTO Pokoje VALUES(9,2,3,3, 400.00,TRUE,2 );

INSERT INTO Pokoje VALUES(10,2,1,4, 1000.00,TRUE,3 );
INSERT INTO Pokoje VALUES(11,2,1,4, 1000.00,TRUE,3 );
INSERT INTO Pokoje VALUES(12,2,4,5, 1500.00,TRUE,3 );




INSERT INTO Rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(null, 17, 1);
INSERT INTO Rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(null, 2, 2);
INSERT INTO Rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(null, 1, 1);
INSERT INTO Rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(null, 3, 3);
INSERT INTO Rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(null, 6, 3);
INSERT INTO Rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(null, 5, 4);
INSERT INTO Rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(null, 15, 1);
INSERT INTO Rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(null, 12, 1);

INSERT INTO Rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(1, null, 4);
INSERT INTO Rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(2, null, 4);
INSERT INTO Rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(4, null, 4);


INSERT INTO Rezerwacje VALUES(1,2,1, '2020-01-14', '2020-02-01');
INSERT INTO Rezerwacje VALUES(2,1,1, '2020-02-14', '2020-02-20');
INSERT INTO Rezerwacje VALUES(3,2,1, '2020-03-20', '2020-03-22');
INSERT INTO Rezerwacje VALUES(4,1,1, '2020-10-14', '2020-12-01');
INSERT INTO Rezerwacje VALUES(5,6,2, '2020-02-14', '2020-02-15');
INSERT INTO Rezerwacje VALUES(6,1,2, '2020-01-14', '2020-02-09');
INSERT INTO Rezerwacje VALUES(7,2,2, '2020-03-03', '2020-03-10');
INSERT INTO Rezerwacje VALUES(8,3,2, '2020-01-01', '2020-02-01');
INSERT INTO Rezerwacje VALUES(9,12,1, '2020-04-01', '2020-04-08');
INSERT INTO Rezerwacje VALUES(9,11,1, '2020-04-01', '2020-04-08');
INSERT INTO Rezerwacje VALUES(9,10,1, '2020-04-01', '2020-04-08');
INSERT INTO Rezerwacje VALUES(10,10,2, '2020-01-04', '2020-02-01');
INSERT INTO Rezerwacje VALUES(10,11,2, '2020-01-04', '2020-02-01');
INSERT INTO Rezerwacje VALUES(10,12,2, '2020-01-04', '2020-02-01');
INSERT INTO Rezerwacje VALUES(11,4,1, '2020-07-01', '2020-08-01');
INSERT INTO Rezerwacje VALUES(11,5,1, '2020-07-01', '2020-08-01');
INSERT INTO Rezerwacje VALUES(11,6,1, '2020-07-01', '2020-08-01');

INSERT INTO UslugiPokoj VALUES(2,5, 6,2);
INSERT INTO UslugiPokoj VALUES(4,11, 4,1);
INSERT INTO UslugiPokoj VALUES(4,11, 5,1);
INSERT INTO UslugiPokoj VALUES(4,11, 6,1);

INSERT INTO Platnosc(id_rezerwacji, id_typplatnosc) VALUES(1,1);
INSERT INTO Platnosc(id_rezerwacji, id_typplatnosc) VALUES(2,4);
INSERT INTO Platnosc(id_rezerwacji, id_typplatnosc)VALUES(3,2);
INSERT INTO Platnosc(id_rezerwacji, id_typplatnosc)VALUES(4,2);
INSERT INTO Platnosc(id_rezerwacji, id_typplatnosc)VALUES(5,2);
INSERT INTO Platnosc(id_rezerwacji, id_typplatnosc)VALUES(6,2);
INSERT INTO Platnosc(id_rezerwacji, id_typplatnosc)VALUES(7,3);
INSERT INTO Platnosc(id_rezerwacji, id_typplatnosc)VALUES(8,1);
INSERT INTO Platnosc(id_rezerwacji, id_typplatnosc)VALUES(9,4);
INSERT INTO Platnosc(id_rezerwacji, id_typplatnosc)VALUES(10,4);
INSERT INTO Platnosc(id_rezerwacji, id_typplatnosc)VALUES(11,4);

INSERT INTO Users VALUES (1, admin, admin);


-------- funkcje -----


CREATE OR REPLACE FUNCTION oplata_za_pobyt (id_rez INTEGER) 
RETURNS INTEGER AS $$
DECLARE
    oplata double precision := 0.0;
    oplata_dzien double precision :=0.0;
    r1 RECORD;
    r2 RECORD;
    r3 RECORD;
    lp INTEGER;
BEGIN
    SELECT COUNT(*) FROM projekt.rezerwacje INTO lp;
    IF(lp<id_rez) THEN
      RAISE SQLSTATE '00200'   USING HINT = 'Nie ma goscia o takim id rezerwacji';
      RETURN -1;
    END IF;
    SELECT DATE_PART('day', (SELECT DISTINCT datado FROM projekt.rezerwacje WHERE id_rezerwacji = id_rez)::timestamp - (SELECT DISTINCT dataod FROM projekt.rezerwacje WHERE id_rezerwacji = id_rez)::timestamp) AS dni INTO r1;


    FOR r2 IN SELECT p.cena FROM projekt.pokoje p JOIN projekt.rezerwacje r ON p.nr_pokoju = r.nr_pokoju AND p.id_hotel = r.id_hotel WHERE id_rezerwacji = id_rez LOOP
      oplata_dzien = oplata_dzien + r2.cena;
    END LOOP;

    FOR r3 IN SELECT u.cena FROM projekt.uslugi u JOIN projekt.UslugiPokoj up ON u.id_uslugi = up.id_uslugi JOIN projekt.Rezerwacje r ON up.id_rezerwacji = r.id_rezerwacji AND up.nr_pokoju = r.nr_pokoju AND up.id_hotel = r.id_hotel WHERE r.id_rezerwacji = id_rez LOOP
      oplata_dzien = oplata_dzien + r3.cena;
    END LOOP;

    oplata = oplata_dzien*r1.dni;

    RETURN oplata;  
END; 
$$ 
LANGUAGE 'plpgsql';




CREATE OR REPLACE FUNCTION wolne_pokoje (id_hot INTEGER, losob INTEGER, pocz DATE, koniec DATE) 
RETURNS TABLE(nr_pokoju INTEGER, typ VARCHAR, pietro INTEGER, cena DECIMAL, palacze BOOLEAN)AS $$
DECLARE
    lp INTEGER;
BEGIN
    SELECT COUNT(*) FROM projekt.hotele INTO lp;
    IF(lp<id_hot) THEN
      RAISE SQLSTATE '00200'   USING HINT = 'NIE MA HOTELU O TAKIM ID';
      RETURN;
    END IF;
    IF(pocz>koniec) THEN
      RAISE SQLSTATE '00201' USING HINT = 'Data poczatku pobytu musi byc wczesniejsza niz data konca pobytu';
      RETURN;
    END IF;
    RETURN QUERY
      SELECT DISTINCT p.nr_pokoju, tp.opis, p.pietro, p.cena, p.dlapalacych FROM projekt.pokoje p JOIN projekt.Typy_pokoi tp ON p.id_typpokoj = tp.id_typpokoj JOIN projekt.rezerwacje r ON p.nr_pokoju = r.nr_pokoju AND p.id_hotel = r.id_hotel WHERE p.id_hotel = id_hot AND ile_osob=losob AND (r.dataOd > koniec OR r.datado < pocz);
END; 
$$ 
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION rezerwacjaNaNazwisko (fname VARCHAR, lname VARCHAR) 
RETURNS TABLE(imie VARCHAR, nazwisko VARCHAR, dataod DATE, datado DATE, status_opis VARCHAR)AS $$
BEGIN
    RETURN QUERY
      SELECT g.imie, g.nazwisko, r.dataod, r.datado, sr.status_opis FROM Goscie g JOIN Rezerwacje_dane rd ON g.id_gosc = rd.id_gosc JOIN Rezerwacje r ON r.id_rezerwacji = rd.id_rezerwacji JOIN Status_rezerwacji sr ON sr.id_status = rd.id_status WHERE g.imie = fname AND g.nazwisko = lname; 
END; 
$$ 
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION nowa_rezerwacja ( im VARCHAR, naz VARCHAR, tel VARCHAR, email VARCHAR, id_hot INTEGER, nrpok INTEGER, pocz DATE, kon DATE, typplat INTEGER ) 
RETURNS void AS $$
DECLARE
    lp INTEGER;
    lp1 INTEGER;
    lp2 INTEGER;
BEGIN
    SELECT COUNT(*) FROM projekt.hotele INTO lp;
    IF(lp<id_hot) THEN
     RAISE SQLSTATE '00200'   USING HINT = 'NIE MA HOTELU O TAKIM ID';
      RETURN;
    END IF;

    IF(pocz>koniec) THEN
      RAISE SQLSTATE '00201' USING HINT = 'Data poczatku pobytu musi byc wczesniejsza niz data konca pobytu';
      RETURN;
    END IF;
  

    INSERT INTO projekt.goscie(imie, nazwisko, telefon, mail) VALUES (im, naz, tel, email);
    SELECT max(id_gosc) FROM projekt.goscie INTO lp1;
    INSERT INTO projekt.rezerwacje_dane(id_agent, id_gosc, id_status) VALUES(null,lp1,1);
    SELECT max(id_rezerwacji) FROM projekt.rezerwacje_dane INTO lp2;
    INSERT INTO projekt.rezerwacje VALUES(lp2, nrpok, id_hot, pocz, kon);
    INSERT INTO projekt.platnosc(id_rezerwacji, id_typplatnosc) VALUES(lp2, typplat);
END; 
$$ 
LANGUAGE 'plpgsql';



---------------------- widok ------------------------------------------
CREATE VIEW rezerwacja AS SELECT rd.id_rezerwacji, g.nazwisko, g.imie, a.nazwa_agencji, h.nazwa, p.nr_pokoju, r.dataod, r.datado FROM goscie g RIGHT JOIN  rezerwacje_dane rd ON g.id_gosc=rd.id_gosc LEFT JOIN  agent a ON a.id_agent = rd.id_agent JOIN rezerwacje r ON rd.id_rezerwacji=r.id_rezerwacji JOIN pokoje p ON p.id_hotel = r.id_hotel AND p.nr_pokoju = r.nr_pokoju JOIN hotele h ON h.id_hotel = p.id_hotel ORDER BY rd.id_rezerwacji;


----------------- wyzwalacze ---------------------------


CREATE OR REPLACE FUNCTION sprawdz_dane_gosc()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
    BEGIN
    IF LENGTH(NEW.imie) = 0 THEN
        RAISE EXCEPTION 'Imie nie moze byc puste.';
    END IF;
    IF LENGTH(NEW.nazwisko) = 0 THEN
        RAISE EXCEPTION 'Nazwisko nie moze byc puste.';
    END IF;
    IF LENGTH(NEW.telefon) != 9 THEN
        RAISE EXCEPTION 'Numer telefonu musi zawierac 9 cyfr';
    END IF;
    IF NEW.imie IS NOT NULL THEN
     NEW.imie := lower(NEW.imie);
     NEW.imie := initcap(NEW.imie);
    END IF;
    IF NEW.nazwisko IS NOT NULL THEN
     NEW.nazwisko := lower(NEW.nazwisko);
     NEW.nazwisko := initcap(NEW.nazwisko);
    END IF;
    RETURN NEW;                                                          
    END;
    $$;

    -- Wyzwalacz monitorujacy poprawnosc danych dla tabeli person 
CREATE TRIGGER sprawdzanie_danych_gosc 
    AFTER INSERT OR UPDATE OR DELETE ON goscie
    FOR EACH ROW EXECUTE PROCEDURE sprawdz_dane_gosc();  

CREATE OR REPLACE FUNCTION sprawdz_dane_agent()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
    BEGIN
    IF LENGTH(NEW.nazwa_agencji) = 0 THEN
        RAISE EXCEPTION 'Agencja musi miec nazwe!';
    END IF;
    IF LENGTH(NEW.telefon) != 9 THEN
        RAISE EXCEPTION 'Numer telefonu musi zawierac 9 cyfr';
    END IF;
    RETURN NEW;                                                          
    END;
    $$;

    CREATE TRIGGER sprawdzanie_danych_agencji 
    AFTER INSERT OR UPDATE OR DELETE ON agent
    FOR EACH ROW EXECUTE PROCEDURE sprawdz_dane_agent();  