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
