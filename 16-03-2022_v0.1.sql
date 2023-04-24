DROP TABLE ingezetenen_jn;

DROP TABLE identiteitskaart;

DROP TABLE ingezetenen;
--1--

--Tabel ingezetenen
CREATE TABLE ingezetenen (
    ingezetene_id    INT NOT NULL PRIMARY KEY,
    id_nummer        VARCHAR2(10) NOT NULL,
    familienaam      VARCHAR2(50) NOT NULL,
    tweede_naam      VARCHAR2(60),
    voornaam         VARCHAR2(50) NOT NULL,
    nationaliteit    VARCHAR2(60) NOT NULL,
    adres            VARCHAR2(120) NOT NULL,
    geboortedatum    DATE NOT NULL,
    overlijdensdatum DATE DEFAULT NULL,
    geslacht         INT NOT NULL,
    district         VARCHAR2(20) NOT NULL,
    CONSTRAINT idn_uq UNIQUE ( id_nummer )
);

-- Check Constraint
ALTER TABLE ingezetenen ADD CONSTRAINT chk_manofvrouw CHECK ( 2 > geslacht );

-- inserts
-- Data Ingezetenen
INSERT INTO ingezetenen (
    ingezetene_id,
    id_nummer,
    familienaam,
    tweede_naam,
    voornaam,
    nationaliteit,
    adres,
    geboortedatum,
    geslacht,
    district
) VALUES (
    1,
    'AA078363',
    'Khumalo',
    'Wendy ',
    'Puleng',
    'Zuid-Afrikaanse',
    'Van Roseveltkade 5',
    '26 feb 1933',
    0,
    'Paramaribo'
);

INSERT INTO ingezetenen (
    ingezetene_id,
    id_nummer,
    familienaam,
    tweede_naam,
    voornaam,
    nationaliteit,
    adres,
    geboortedatum,
    geslacht,
    district
) VALUES (
    2,
    'AB089474',
    'Bhele',
    'Chantal',
    'Fikile',
    'Surinaamse',
    'Afobakaweg 9',
    '16 mar 1995',
    0,
    'Paramaribo'
);

INSERT INTO ingezetenen (
    ingezetene_id,
    id_nummer,
    familienaam,
    tweede_naam,
    voornaam,
    nationaliteit,
    adres,
    geboortedatum,
    geslacht,
    district
) VALUES (
    3,
    'AC108383',
    'Daniels',
    'Ray',
    'Wade',
    'Surinaamse',
    'Kwattaweg 234',
    '16 may 2000',
    1,
    'Paramaribo'
);

INSERT INTO ingezetenen (
    ingezetene_id,
    id_nummer,
    familienaam,
    tweede_naam,
    voornaam,
    nationaliteit,
    adres,
    geboortedatum,
    geslacht,
    district
) VALUES (
    4,
    'DE003892',
    'Kahn',
    'Simone',
    ' Tahira',
    'Surinaamse',
    'Kwattaweg 45',
    '01 aug 1962',
    0,
    'Paramaribo'
);

INSERT INTO ingezetenen (
    ingezetene_id,
    id_nummer,
    familienaam,
    voornaam,
    nationaliteit,
    adres,
    geboortedatum,
    geslacht,
    district
) VALUES (
    5,
    'DF012211',
    'Braafheid',
    'Ingrid',
    'Surinaamse',
    'Prinsenstraat 1',
    '16 sep 1993',
    0,
    'Paramaribo'
);

INSERT INTO ingezetenen (
    ingezetene_id,
    id_nummer,
    familienaam,
    tweede_naam,
    voornaam,
    nationaliteit,
    adres,
    geboortedatum,
    geslacht,
    district
) VALUES (
    6,
    'DG102529',
    'van Rensburg',
    'David',
    'Reece ',
    'Surinaamse',
    'Josephinastraat',
    '10 oct 1961',
    1,
    'Nickerie'
);

INSERT INTO ingezetenen (
    ingezetene_id,
    id_nummer,
    familienaam,
    voornaam,
    nationaliteit,
    adres,
    geboortedatum,
    geslacht,
    district
) VALUES (
    7,
    'HI292427',
    'Bouman',
    'Ferry',
    'Nederlandse ',
    'May Straat 16',
    '13 jan 1996',
    0,
    'Paramaribo'
);

INSERT INTO ingezetenen (
    ingezetene_id,
    id_nummer,
    familienaam,
    tweede_naam,
    voornaam,
    nationaliteit,
    adres,
    geboortedatum,
    geslacht,
    district
) VALUES (
    8,
    'HJ285231',
    'de Rooij',
    'Yusuf',
    'Kim',
    'Surinaamse',
    'Sidodadiweg 89',
    '28 jul 2002',
    0,
    'Wanica'
);

INSERT INTO ingezetenen (
    ingezetene_id,
    id_nummer,
    familienaam,
    voornaam,
    nationaliteit,
    adres,
    geboortedatum,
    geslacht,
    district
) VALUES (
    9,
    'HK137208',
    'de Vries',
    'Dennis',
    'Surinaamse',
    'Van Roseveltkade 5',
    '23 nov 2001',
    1,
    'Paramaribo'
);

--Show Ingezetenen
SELECT
    *
FROM
    ingezetenen;

-- Ingezetenen Geslacht
SELECT
    voornaam,
    CASE
    WHEN geslacht = 1 THEN
    'Man'
    WHEN geslacht = 0 THEN
    'Vrouw'
    ELSE
    NULL
    END AS geslacht
FROM
    ingezetenen;

SELECT
    id_nummer,
    familienaam,
    voornaam,
    geboortedatum,
    adres,
    CASE
    WHEN geslacht = 1 THEN
    'Man'
    WHEN geslacht = 0 THEN
    'Vrouw'
    ELSE
    NULL
    END AS geslacht
FROM
    ingezetenen
ORDER BY
    geboortedatum DESC;

SELECT
    COUNT(ingezetene_id) inwoners,
    district
FROM
    ingezetenen
GROUP BY
    district;
   
-- Ingezetenen geen  Surinaamse nationaliteit
SELECT
    *
FROM
    ingezetenen
WHERE
    nationaliteit != 'Surinaamse';
    
-- Ingezetenen met Surinaamse nationaliteit
SELECT
    *
FROM
    ingezetenen
WHERE
    nationaliteit = 'Surinaamse';
  
    
    --Tabel Identiteitskaart
CREATE TABLE identiteitskaart (
    identiteitskaart_id INT NOT NULL PRIMARY KEY,
    kaartnummer         VARCHAR2(60) NOT NULL,
    uitgiftedatum       DATE NOT NULL,
    vervaldatum         DATE NOT NULL,
    ingezetene_id       INT,
    CONSTRAINT id_uq UNIQUE ( kaartnummer ),
    CONSTRAINT fk_ingezetenenid FOREIGN KEY ( ingezetene_id )
        REFERENCES ingezetenen ( ingezetene_id )
);

    
--insert
-- Data Identiteitskaart
INSERT ALL INTO identiteitskaart VALUES (
    1,
    '0002091',
    '08 jul 2019',
    '08 jul 2029',
    9
) INTO identiteitskaart VALUES (
    2,
    '0001238',
    '18 jan 2020',
    '18 jan 2030',
    8
) INTO identiteitskaart VALUES (
    3,
    '0002144',
    '12 jan 2021',
    '12 jan 2031',
    6
) INTO identiteitskaart VALUES (
    4,
    '0005676',
    '05 mar 2019',
    '05 mar 2029',
    4
) INTO identiteitskaart VALUES (
    5,
    '0004432',
    '02 apr 2019',
    '02 apr 2029',
    3
) INTO identiteitskaart VALUES (
    6,
    '0003246',
    '10 sep 2017',
    '10 sep 2027',
    1
) SELECT
      *
  FROM
      dual;
      
--Show Identiteitskaart
SELECT
    *
FROM
    identiteitskaart;
    
    
--2--    
-- View Identiteitskaart
SELECT
    voornaam,
    tweede_naam,
    familienaam,
    id_nummer,
    geboortedatum,
    geslacht,
    district,
    nationaliteit,
    kaartnummer,
    uitgiftedatum,
    vervaldatum
FROM
    identiteitskaart
    INNER JOIN ingezetenen ON identiteitskaart.ingezetene_id = ingezetenen.ingezetene_id;
  

-- 2e View Identiteitskaart
SELECT
    voornaam,
    tweede_naam,
    familienaam,
    id_nummer,
    geboortedatum,
    district,
    nationaliteit,
    kaartnummer,
    uitgiftedatum,
    vervaldatum,
    CASE
    WHEN geslacht = 1 THEN
    'Man'
    WHEN geslacht = 0 THEN
    'Vrouw'
    ELSE
    NULL
    END AS geslacht
FROM
    identiteitskaart
    INNER JOIN ingezetenen ON identiteitskaart.ingezetene_id = ingezetenen.ingezetene_id;

--3e View
SELECT
    voornaam,
    tweede_naam,
    familienaam,
    id_nummer,
    geboortedatum,
    district,
    nationaliteit,
    kaartnummer,
    uitgiftedatum,
    vervaldatum,
    CASE
    WHEN geslacht = 1 THEN
    'Man'
    WHEN geslacht = 0 THEN
    'Vrouw'
    ELSE
    NULL
    END AS geslacht
FROM
    identiteitskaart
    INNER JOIN ingezetenen ON identiteitskaart.ingezetene_id = ingezetenen.ingezetene_id
      ORDER BY
    uitgiftedatum DESC;


      
--3--     
--Trigger I, D,U

CREATE TABLE ingezetenen_jn
    AS
        ( SELECT
            *
        FROM
            ingezetenen
        WHERE
            1 = 0
        );

ALTER TABLE ingezetenen_jn ADD dml_actie VARCHAR(1);

--Trigger
CREATE OR REPLACE TRIGGER trigger_dml_audit BEFORE
    INSERT OR DELETE OR UPDATE ON ingezetenen
    FOR EACH ROW
ENABLE BEGIN
    IF inserting THEN
        INSERT INTO ingezetenen_jn (
            ingezetene_id,
            id_nummer,
            familienaam,
            tweede_naam,
            voornaam,
            nationaliteit,
            adres,
            geboortedatum,
            overlijdensdatum,
            geslacht,
            district,
            dml_actie
        ) VALUES (
            :new.ingezetene_id,
            :new.id_nummer,
            :new.familienaam,
            :new.tweede_naam,
            :new.voornaam,
            :new.nationaliteit,
            :new.adres,
            :new.geboortedatum,
            :new.overlijdensdatum,
            :new.geslacht,
            :new.district,
            'I'
        );

    ELSIF deleting THEN
        INSERT INTO ingezetenen_jn (
            ingezetene_id,
            id_nummer,
            familienaam,
            tweede_naam,
            voornaam,
            nationaliteit,
            adres,
            geboortedatum,
            overlijdensdatum,
            geslacht,
            district,
            dml_actie
        ) VALUES (
            :old.ingezetene_id,
            :old.id_nummer,
            :old.familienaam,
            :old.tweede_naam,
            :old.voornaam,
            :old.nationaliteit,
            :old.adres,
            :old.geboortedatum,
            :new.overlijdensdatum,
            :old.geslacht,
            :old.district,
            'D'
        );

    ELSIF updating THEN
        INSERT INTO ingezetenen_jn (
            ingezetene_id,
            id_nummer,
            familienaam,
            tweede_naam,
            voornaam,
            nationaliteit,
            adres,
            geboortedatum,
            overlijdensdatum,
            geslacht,
            district,
            dml_actie
        ) VALUES (
            :new.ingezetene_id,
            :new.id_nummer,
            :new.familienaam,
            :new.tweede_naam,
            :new.voornaam,
            :new.nationaliteit,
            :new.adres,
            :new.geboortedatum,
            :new.overlijdensdatum,
            :new.geslacht,
            :new.district,
            'U'
        );

    END IF;
END;


--dml_acties
SELECT
    *
FROM
    ingezetenen_jn;

INSERT INTO ingezetenen (
    ingezetene_id,
    id_nummer,
    familienaam,
    voornaam,
    nationaliteit,
    adres,
    geboortedatum,
    geslacht,
    district
) VALUES (
    10,
    'HK127208',
    'Munnik',
    'Ruben',
    'Nederlandse',
    'edelstraat 13',
    '13 feb 1996',
    1,
    'Paramaribo'
);

DELETE FROM ingezetenen
WHERE
    ingezetene_id = 10;

UPDATE ingezetenen
SET
    id_nummer = 'SD283738',
    tweede_naam = 'Ricky'
WHERE
    ingezetene_id = 7;

UPDATE ingezetenen
SET
    overlijdensdatum = '17 feb 2022'
WHERE
    ingezetene_id = 2;
    
    

UPDATE ingezetenen
SET
    overlijdensdatum = '09 mar 2022'
WHERE
    ingezetene_id = 5;

SELECT
    *
FROM
    ingezetenen_jn;
    

SELECT
    *
FROM
    ingezetenen_jn
WHERE
    dml_actie = 'U';


--4--  
SELECT
    *
FROM
    ingezetenen;

SELECT
    *
FROM
    ingezetenen
WHERE
    overlijdensdatum IS NOT NULL;


-- Procedure van de maand alle overleden ingezetenen
CREATE PROCEDURE procedure_delete_overleden AS
BEGIN
    DELETE FROM ingezetenen
    WHERE
        overlijdensdatum IS NOT NULL;

END;

-- Schedule 
BEGIN
    dbms_scheduler.set_attribute(
                                name      => '"SYSTEM"."EIND_VD_MAAND"',
                                attribute => 'repeat_interval',
                                value     => 'FREQ=YEARLY;INTERVAL=12;BYDATE=0131,0229,0331,0430,0531,0630,0731,0831,0930,1031,1130,1231;BYTIME=100000'
    );
END;

-- Job van de maand alle overleden ingezetenen

BEGIN
    dbms_scheduler.create_job(
                             job_name            => '"SYSTEM"."MAANDELIJK_JOB"',
                             schedule_name       => '"SYSTEM"."EIND_VD_MAAND"',
                             job_type            => 'STORED_PROCEDURE',
                             job_action          => 'SYSTEM.PROCEDURE_DELETE_OVERLEDEN',
                             number_of_arguments => 0,
                             enabled             => false,
                             auto_drop           => false,
                             comments            => ''
    );

    dbms_scheduler.set_attribute(
                                name      => '"SYSTEM"."MAANDELIJK_JOB"',
                                attribute => 'store_output',
                                value     => true
    );

    dbms_scheduler.set_attribute(
                                name      => '"SYSTEM"."MAANDELIJK_JOB"',
                                attribute => 'logging_level',
                                value     => dbms_scheduler.logging_off
    );

    dbms_scheduler.enable(name => '"SYSTEM"."MAANDELIJK_JOB"');
END;
-- RUN JOB