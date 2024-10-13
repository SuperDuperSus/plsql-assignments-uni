--1
DECLARE
    VTEKST  VARCHAR(200) := 'Witaj, świecie';
    VLICZBA NUMBER := 100.1;
BEGIN
    DBMS_OUTPUT.PUT_LINE(VTEKST);
    DBMS_OUTPUT.PUT_LINE(VLICZBA);
END;

--2
DECLARE
    VTEKST  VARCHAR(200) := 'Witaj, świecie! Witaj, nowy dniu!';
    VLICZBA NUMBER := 100.1;
BEGIN
    DBMS_OUTPUT.PUT_LINE(VTEKST);
    DBMS_OUTPUT.PUT_LINE(VLICZBA + 10 * * 25);
END;

--3
DECLARE
    VX   NUMBER := 100;
    VY   NUMBER := 200;
    VOUT NUMBER;
BEGIN
    VOUT := VX + VY;
    DBMS_OUTPUT.PUT_LINE('Wynik dodawania '
                         || VX
                         || ' i '
                         || VY
                         || ':'
                         || VOUT);

END;

--4
DECLARE
    VKOLO NUMBER := 5;
    VP    NUMBER;
    VO    NUMBER;
    VPI   CONSTANT NUMBER := 3.14;
BEGIN
    VO := 2 * VPI * VKOLO;
    VP := VPI * VKOLO * VKOLO;
    DBMS_OUTPUT.PUT_LINE('Obwód koła o promieniu równym '
                         || VKOLO
                         || ':'
                         || VO);
    DBMS_OUTPUT.PUT_LINE('Pole koła o promieniu równym '
                         || VKOLO
                         || ':'
                         || VP);
END;

--5
DECLARE
    VNAZWISKO PRACOWNICY.NAZWISKO%TYPE;
    VETAT     PRACOWNICY.ETAT%TYPE;
BEGIN
    SELECT
        NAZWISKO,
        ETAT
    INTO
        VNAZWISKO,
        VETAT
    FROM
        PRACOWNICY
    WHERE
        PLACA_POD = (
            SELECT
                MAX(PLACA_POD)
            FROM
                PRACOWNICY
        );

    DBMS_OUTPUT.PUT_LINE('Najlepiej zarabia pracownik: ' || VNAZWISKO);
    DBMS_OUTPUT.PUT_LINE('Pracuje on jako: ' || VETAT);
END;

--6
DECLARE
    vPracownik PRACOWNICY%ROWTYPE;
    vMaxPensja PRACOWNICY.PLACA_POD%TYPE;
BEGIN
    SELECT MAX(PLACA_POD)
    INTO vMaxPensja
    FROM PRACOWNICY;
    
    SELECT *
    INTO vPracownik
    FROM Pracownicy
    WHERE PLACA_POD = vMaxPensja;
    
    DBMS_OUTPUT.PUT_LINE('Najlepiej zarabia pracownik: ' || vPracownik.nazwisko);
    DBMS_OUTPUT.PUT_LINE('Pracuje on jako: ' || vPracownik.etat);
END;


--7
DECLARE
    SUBTYPE TPIENIADZE IS NUMBER;
    VZAROBKI TPIENIADZE;
BEGIN
    SELECT
        PLACA_POD
    INTO VZAROBKI
    FROM
        PRACOWNICY
    WHERE
        NAZWISKO = 'SLOWINSKI';

    DBMS_OUTPUT.PUT_LINE('Roczne zarobki prof. Słowińskiego: ' || VZAROBKI);
END;

--8
DECLARE
    VCURRENTTIME TIMESTAMP;
BEGIN
    LOOP
        VCURRENTTIME := SYSTIMESTAMP;
        IF EXTRACT(SECOND FROM VCURRENTTIME) = 25 THEN
            DBMS_OUTPUT.PUT_LINE('Nadeszła 25 sekunda!');
            EXIT;
        END IF;

        DBMS_SESSION.SLEEP(1);
    END LOOP;
END;

--9 
DECLARE 
    VN NUMBER := 5;
    VTOTAL NUMBER := 1;
BEGIN 
    FOR index_i IN 1..VN LOOP
      VTOTAL := VTOTAL * index_i;
      DBMS_OUTPUT.PUT_LINE(VTOTAL);
    END LOOP;
END;

--10
DECLARE
    v_year   NUMBER;
    v_month  NUMBER;
    v_date   DATE;
BEGIN
    FOR v_year IN 2001..2100 LOOP  
        FOR v_month IN 1..12 LOOP 
            v_date := TO_DATE('13-' || v_month || '-' || v_year, 'DD-MM-YYYY');
            
            IF TO_CHAR(v_date, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH') = 'FRI' THEN
                DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_date, 'DD-MM-YYYY'));
            END IF;
        END LOOP;
    END LOOP;
END;
/