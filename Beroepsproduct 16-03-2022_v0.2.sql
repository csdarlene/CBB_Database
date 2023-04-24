DROP TABLE ingezetene;

DROP TABLE geboorte_akte;

DROP TABLE vreemdelinge_registratie;

--1--
--------------------------------------------------------------------------------
-- Create geboorte_akte
CREATE TABLE geboorte_akte (
    geboorte_akte_id INT NOT NULL PRIMARY KEY,
    familienaam      VARCHAR2(50) NOT NULL,
    voornamen        VARCHAR2(70) NOT NULL,
    nationaliteit    VARCHAR2(60) DEFAULT 'Surinaamse',
    geboortedatum    DATE NOT NULL,
    geslacht         INT NOT NULL,
    geboorteplaats   VARCHAR2(70) NOT NULL,
    CONSTRAINT chk_geslacht CHECK ( geslacht < 2 )
);


      
      
--Show Geboorte_Akte
SELECT
    *
FROM
    geboorte_akte;

SELECT
    voornamen,
    CASE
    WHEN geslacht = 1 THEN
    'Man'
    WHEN geslacht = 0 THEN
    'Vrouw'
    ELSE
    NULL
    END AS geslacht
FROM
    geboorte_akte;
    
    
--Create  vreemdelinge_registratie   
CREATE TABLE vreemdelinge_registratie (
    vreemdelinge_registratie_id INT NOT NULL PRIMARY KEY,
    familienaam                 VARCHAR2(50) NOT NULL,
    voornamen                   VARCHAR2(700) NOT NULL,
    nationaliteit               VARCHAR2(60) NOT NULL,
    geboortedatum               DATE NOT NULL,
    geslacht                    INT NOT NULL,
    CONSTRAINT chk_geslacht1 CHECK ( geslacht < 2 )
);
      
      
--Show Vreemdelinge_Registratie
SELECT
    *
FROM
    vreemdelinge_registratie;

SELECT
    voornamen,
    CASE
    WHEN geslacht = 1 THEN
    'Man'
    WHEN geslacht = 0 THEN
    'Vrouw'
    ELSE
    NULL
    END AS geslacht
FROM
    vreemdelinge_registratie;
     
--create ingezetene

CREATE TABLE ingezetene (
    ingezetene_id               INT NOT NULL,
    id_nummer                   VARCHAR2(10) NOT NULL,
    adres                       VARCHAR2(120) NOT NULL,
    district                    VARCHAR2(120) NOT NULL,
    overlijdensdatum            DATE DEFAULT NULL,
    vreemdelinge_registratie_id INT,
    geboorte_akte_id            INT,
    CONSTRAINT id_num_uq UNIQUE ( id_nummer ),
    CONSTRAINT fk_geboorte_akteid FOREIGN KEY ( geboorte_akte_id )
        REFERENCES geboorte_akte ( geboorte_akte_id ),
    CONSTRAINT fk_vreemdelinge_registratieid FOREIGN KEY ( vreemdelinge_registratie_id )
        REFERENCES vreemdelinge_registratie ( vreemdelinge_registratie_id )
);

   
--Show Ingezetene
SELECT
    *
FROM
    ingezetene;

--2--
--------------------------------------------------------------------------------
-- View alle nationaliteiten
SELECT
    id_nummer,
    adres,
    district,
    vreemdelinge_registratie.familienaam,
    vreemdelinge_registratie.voornamen,
    vreemdelinge_registratie.nationaliteit,
    vreemdelinge_registratie.geslacht,
    geboorte_akte.familienaam,
    geboorte_akte.voornamen,
    geboorte_akte.nationaliteit,
    geboorte_akte.geslacht,
    CASE
    WHEN geboorte_akte.geslacht = 1            THEN
    'Man'
    WHEN geboorte_akte.geslacht = 0            THEN
    'Vrouw'
    WHEN vreemdelinge_registratie.geslacht = 1 THEN
    'Man'
    WHEN vreemdelinge_registratie.geslacht = 0 THEN
    'Vrouw'
    ELSE
    NULL
    END AS geslacht
FROM
    ingezetene
    LEFT JOIN geboorte_akte ON geboorte_akte.geboorte_akte_id = ingezetene.geboorte_akte_id
    LEFT JOIN vreemdelinge_registratie ON vreemdelinge_registratie.vreemdelinge_registratie_id = ingezetene.vreemdelinge_registratie_id;

SELECT
    id_nummer,
    adres,
    district,
    vreemdelinge_registratie.familienaam,
    vreemdelinge_registratie.voornamen,
    vreemdelinge_registratie.nationaliteit,
    vreemdelinge_registratie.geslacht,
    geboorte_akte.familienaam,
    geboorte_akte.voornamen,
    geboorte_akte.nationaliteit,
    geboorte_akte.geslacht,
    CASE
    WHEN geboorte_akte.geslacht = 1            THEN
    'Man'
    WHEN geboorte_akte.geslacht = 0            THEN
    'Vrouw'
    WHEN vreemdelinge_registratie.geslacht = 1 THEN
    'Man'
    WHEN vreemdelinge_registratie.geslacht = 0 THEN
    'Vrouw'
    ELSE
    NULL
    END AS geslacht
FROM
    ingezetene
    LEFT JOIN geboorte_akte ON geboorte_akte.geboorte_akte_id = ingezetene.geboorte_akte_id
    LEFT JOIN vreemdelinge_registratie ON vreemdelinge_registratie.vreemdelinge_registratie_id = ingezetene.vreemdelinge_registratie_id
ORDER BY
    district DESC;

-- View Surinamers
SELECT
    id_nummer,
    adres,
    district,
    geboorte_akte.familienaam,
    geboorte_akte.voornamen,
    geboorte_akte.geboortedatum,
    geboorte_akte.nationaliteit,
    geboorte_akte.geboorteplaats,
    CASE
    WHEN geslacht = 1 THEN
    'Man'
    WHEN geslacht = 0 THEN
    'Vrouw'
    ELSE
    NULL
    END AS geslacht
FROM
    ingezetene
    INNER JOIN geboorte_akte ON geboorte_akte.geboorte_akte_id = ingezetene.geboorte_akte_id
WHERE
    nationaliteit = 'Surinaamse';

SELECT
    COUNT(ingezetene_id) inwoners,
    district
FROM
    ingezetene
    LEFT JOIN geboorte_akte ON geboorte_akte.geboorte_akte_id = ingezetene.geboorte_akte_id
    LEFT JOIN vreemdelinge_registratie ON vreemdelinge_registratie.vreemdelinge_registratie_id = ingezetene.vreemdelinge_registratie_id
GROUP BY
    district;
    
-- view Vreemdelinge
SELECT
    id_nummer,
    adres,
    district,
    vreemdelinge_registratie.familienaam,
    vreemdelinge_registratie.voornamen,
    vreemdelinge_registratie.geboortedatum,
    vreemdelinge_registratie.nationaliteit,
    CASE
    WHEN geslacht = 1 THEN
    'Man'
    WHEN geslacht = 0 THEN
    'Vrouw'
    ELSE
    NULL
    END AS geslacht
FROM
    ingezetene
    INNER JOIN vreemdelinge_registratie ON vreemdelinge_registratie.vreemdelinge_registratie_id = ingezetene.vreemdelinge_registratie_id
WHERE
    nationaliteit != 'Surinaamse';

    
-- 3--
--------------------------------------------------------------------------------
CREATE TABLE geboorte_akte_jn
    AS
        ( SELECT
            *
        FROM
            geboorte_akte
        WHERE
            1 = 0
        );

ALTER TABLE geboorte_akte_jn ADD dml_actie VARCHAR(1);

--Trigger
CREATE OR REPLACE TRIGGER trigger_geboorte_akte_audit BEFORE
    
    OR DELETE OR UPDATE ON geboorte_akte
    FOR EACH ROW
ENABLE BEGIN
    IF inserting THEN
        INSERT INTO geboorte_akte_jn (
            geboorte_akte_id,
            familienaam,
            voornamen,
            geboortedatum,
            geslacht,
            geboorteplaats,
            dml_actie
        ) VALUES (
            :new.geboorte_akte_id,
            :new.familienaam,
            :new.voornamen,
            :new.geboortedatum,
            :new.geslacht,
            :new.geboorteplaats,
            'I'
        );

    ELSIF deleting THEN
        INSERT INTO geboorte_akte_jn (
            geboorte_akte_id,
            familienaam,
            voornamen,
            geboortedatum,
            geslacht,
            geboorteplaats,
            dml_actie
        ) VALUES (
            :old.geboorte_akte_id,
            :old.familienaam,
            :old.voornamen,
            :old.geboortedatum,
            :old.geslacht,
            :old.geboorteplaats,
            'D'
        );

    ELSIF updating THEN
        INSERT INTO geboorte_akte_jn (
            geboorte_akte_id,
            familienaam,
            voornamen,
            geboortedatum,
            geslacht,
            geboorteplaats,
            dml_actie
        ) VALUES (
            :new.geboorte_akte_id,
            :new.familienaam,
            :new.voornamen,
            :new.geboortedatum,
            :new.geslacht,
            :new.geboorteplaats,
            'U'
        );

    END IF;
END;

--dml_acties
SELECT
    *
FROM
    geboorte_akte_jn;

SELECT
    *
FROM
    geboorte_akte;



DELETE FROM geboorte_akte
WHERE
    geboorte_akte_id = 8;

UPDATE geboorte_akte
SET
    geslacht = 1
WHERE
    geboorte_akte_id = 4;

SELECT
    *
FROM
    geboorte_akte_jn;

SELECT
    *
FROM
    geboorte_akte_jn
WHERE
    dml_actie = 'I';
    
    
 -- 4--
 --------------------------------------------------------------------------------
UPDATE ingezetene
SET
    overlijdensdatum = '17 feb 2022'
WHERE
    ingezetene_id = 2;

UPDATE ingezetene
SET
    overlijdensdatum = '09 mar 2022'
WHERE
    ingezetene_id = 4;

SELECT
    *
FROM
    ingezetene;
    
-- procdure
CREATE OR REPLACE NONEDITIONABLE PROCEDURE procedure_overleden AS
BEGIN
    DELETE FROM ingezetene
    WHERE
        overlijdensdatum IS NOT NULL;

END;
    
-- schedule
BEGIN
    dbms_scheduler.set_attribute(
                                name      => '"SYSTEM"."EIND_VD_MAAND"',
                                attribute => 'repeat_interval',
                                value     => 'FREQ=YEARLY;INTERVAL=12;BYDATE=0131,0229,0331,0430,0531,0630,0731,0831,0930,1031,1130,1231;BYTIME=100000'
    );
END;

-- job
BEGIN
    dbms_scheduler.create_job(
                             job_name            => '"SYSTEM"."MAANDELIJKSE_OVERLEDEN_JOB"',
                             schedule_name       => '"SYSTEM"."EIND_VD_MAAND"',
                             job_type            => 'STORED_PROCEDURE',
                             job_action          => 'SYSTEM.PROCEDURE_OVERLEDEN',
                             number_of_arguments => 0,
                             enabled             => false,
                             auto_drop           => false,
                             comments            => ''
    );

    dbms_scheduler.set_attribute(
                                name      => '"SYSTEM"."MAANDELIJKSE_OVERLEDEN_JOB"',
                                attribute => 'store_output',
                                value     => true
    );

    dbms_scheduler.set_attribute(
                                name      => '"SYSTEM"."MAANDELIJKSE_OVERLEDEN_JOB"',
                                attribute => 'logging_level',
                                value     => dbms_scheduler.logging_off
    );

    dbms_scheduler.enable(name => '"SYSTEM"."MAANDELIJKSE_OVERLEDEN_JOB"');
END;
-- Run Job
