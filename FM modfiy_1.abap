REPORT zcl_test.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(NEW) TYPE  CHAR01 OPTIONAL
*"     REFERENCE(BLOCKED) TYPE  CHAR01 OPTIONAL
*"     REFERENCE(ZERO) TYPE  CHAR01 OPTIONAL
*"     REFERENCE(KEYDATE) TYPE  DATUM
*"     REFERENCE(REASONCODE) TYPE  CHAR01
*"     REFERENCE(REPORT) TYPE  CHAR01
*"  TABLES
*"      ITAB STRUCTURE  ZAR_AGING OPTIONAL
*"      ITABD STRUCTURE  ZAR_AGING_DETAIL OPTIONAL
*"      ITABH STRUCTURE  ZAR_AGING_HEADER OPTIONAL
*"      KUNNR STRUCTURE  ZAR_AGING_KUNNR OPTIONAL
*"      BUKRS STRUCTURE  ZAR_AGING_BUKRS OPTIONAL
*"      CTLPC STRUCTURE  ZAR_AGING_CTLPC OPTIONAL
*"      SBGRP STRUCTURE  ZAR_AGING_SBGRP OPTIONAL
*"      KDGRP STRUCTURE  ZAR_AGING_KDGRP OPTIONAL
*"      KTOKD STRUCTURE  ZAR_AGING_KTOKD OPTIONAL
*"      SHIPTO STRUCTURE  ZAR_AGING_KUNNR OPTIONAL
*"----------------------------------------------------------------------

***************************************

TYPES: BEGIN OF ty_aging,
         kunnr            TYPE kunnr,
         zuonr            TYPE dzuonr,
         ctlpc            TYPE ctlpc_cm,
         zterm            TYPE dzterm,
         sbgrp            TYPE sbgrp_cm,
         new              TYPE char01,
         belnr            TYPE belnr_d,
         rstgr            TYPE rstgr,
         txt40            TYPE txt40,
         budat            TYPE budat,
         bldat            TYPE bldat,
         xblnr            TYPE xblnr,
         crblb            TYPE crblb_cm,
         sgtxt            TYPE sgtxt,
         gjahr            TYPE gjahr,
         jobnumb          TYPE kunwe,
         jobname          TYPE name1,
         jobstate         TYPE regio,
         jobbond          TYPE kunnr,
         jobbondn         TYPE name1,
         over60           TYPE char01,
         lastpayd         TYPE cashd,
         lastpaya         TYPE char15,
         blart            TYPE blart,
         bschl            TYPE bschl,
         shkzg            TYPE shkzg,
         dmbtr            TYPE dmbtr,
         pswbt            TYPE pswbt,
         vbeln            TYPE vbeln,
         days             TYPE int4,
         kdgrp            TYPE kdgrp,
         dbmon            TYPE dbmon_cm,
         revdb            TYPE revdb_cm,
         zcredit_exp      TYPE klimk,
         kraus            TYPE kraus_cm,
         zinfo_sheet_recd TYPE char01,
         znoticesent      TYPE char01,
         zdatenoticesent  TYPE char01,
         rebzg            TYPE rebzg,
       END OF ty_aging.

TYPES: BEGIN OF ty_agingd,
         kunnr              TYPE kunnr,
         zuonr              TYPE dzuonr,
         name1              TYPE name1,
         time_zone          TYPE ad_tzone,
         new                TYPE char01,
         ctlpc              TYPE ctlpc_cm,
         zterm              TYPE dzterm,
         sbgrp              TYPE sbgrp_cm,
         belnr              TYPE belnr_d,
         jobnumb            TYPE kunnr,
         jobname            TYPE name1,
         rstgr              TYPE rstgr,
         txt40              TYPE txt40,
         crblb              TYPE crblb_cm,
         jobstate           TYPE regio,
         jobbond            TYPE kunnr,
         jobbondn           TYPE name1,
         bldat              TYPE bldat,
         lastpayd           TYPE cashd,
         lastpaya           TYPE char15,
         vbeln              TYPE vbeln,
         xblnr              TYPE xblnr,
         over60             TYPE char01,
         nopay              TYPE char01,
         last30             TYPE char01,
         blart              TYPE blart,
         sgtxt              TYPE sgtxt,
         budat              TYPE budat,
         col1               TYPE dmbtr,
         col2               TYPE dmbtr,
         col2a              TYPE dmbtr,
         col2b              TYPE dmbtr,
         col2c              TYPE dmbtr,
         col3               TYPE dmbtr,
         col3a              TYPE dmbtr,
         col4               TYPE dmbtr,
         col5               TYPE dmbtr,
         col5a              TYPE dmbtr,
         col6               TYPE dmbtr,
         sum                TYPE dmbtr,
         days               TYPE numberdays,
         zinfo_sheet_recd   TYPE char01,
         znoticesent        TYPE char01,
         zdatenoticesent    TYPE sy-datum,
         dbmon              TYPE dbmon_cm,
         revdb              TYPE revdb_cm,
         zcredit_exp        TYPE klimk,
         kraus              TYPE kraus_cm,
         klimk              TYPE klimk,
         zr_partner         TYPE kunn2,
         std_method         TYPE ad_com_tx,
         email              TYPE ad_smtpadr,
         zpersonal_guaranty TYPE char01,
       END OF ty_agingd.

TYPES: BEGIN OF ty_agingh,
         kunnr                TYPE kunnr,
         name1                TYPE name1,
         time_zone            TYPE ad_tzone,
         new                  TYPE char01,
         ctlpc                TYPE ctlpc_cm,
         crblb                TYPE crblb_cm,
         rstgr                TYPE rstgr,
         txt40                TYPE txt40,
         lastpayd             TYPE cashd,
         lastpaya             TYPE char15,
         zterm                TYPE dzterm,
         over60               TYPE char01,
         nopay                TYPE char01,
         last30               TYPE char01,
         kdgrp                TYPE kdgrp,
         sbgrp                TYPE sbgrp_cm,
         col1                 TYPE dmbtr,
         col2                 TYPE dmbtr,
         col2a                TYPE dmbtr,
         col2b                TYPE dmbtr,
         col2c                TYPE dmbtr,
         col3                 TYPE dmbtr,
         col3a                TYPE dmbtr,
         col4                 TYPE dmbtr,
         col5                 TYPE dmbtr,
         col5a                TYPE dmbtr,
         col6                 TYPE dmbtr,
         sum                  TYPE dmbtr,
         klimk                TYPE klimk,
         percover             TYPE dmbtr,
         dbmon                TYPE dbmon_cm,
         revdb                TYPE revdb_cm,
         zcredit_exp          TYPE klimk,
         kraus                TYPE kraus_cm,
         comments             TYPE char100,
         h12sa                TYPE saldo_12,
         ump1u                TYPE umxxu_vor,
         ump2u                TYPE umxxu_akt,
         last_inv_date        TYPE fkdat,
         credit_exposure      TYPE oblig_f02l,
         rtm_sales            TYPE netwr_ak,
         six_month_sales      TYPE netwr_ak,
         credit_limit_percent TYPE klimk,
         last_int_review      TYPE dtrev_cm,
         next_int_review      TYPE nxtrv_cm,
         zpersonal_guaranty   TYPE char01,
         zcredit_card         TYPE char01,
         zkey_account         TYPE char01,
         zcontact_preference  TYPE char60,
       END OF ty_agingh.

DATA: itab       TYPE TABLE OF ty_aging WITH HEADER LINE VALUE IS INITIAL,
      reason     TYPE TABLE OF ty_aging WITH HEADER LINE VALUE IS INITIAL,
      itabd      TYPE TABLE OF ty_agingd WITH HEADER LINE VALUE IS INITIAL,
      itabh      TYPE TABLE OF ty_agingh WITH HEADER LINE VALUE IS INITIAL,
      kunnr      TYPE fkk_rt_kunnr,
      ctlpc      TYPE RANGE OF ctlpc_cm,
      sbgrp      TYPE RANGE OF sbgrp_cm,
      ktokd      TYPE RANGE OF kna1-ktokd,
      shipto     TYPE fkk_rt_kunnr,
      bukrs      TYPE RANGE OF vbak-bukrs_vf,
      reasoncode TYPE char01,
      keydate    TYPE datum,
      bsid       TYPE bsid,
      vbrk       TYPE vbrk,
      report     TYPE char01,
      bsad       TYPE bsad,
      knkk       TYPE knkk,
      knvv       TYPE knvv,
      blocked    TYPE char01,
      new        TYPE char01,
      kna1       TYPE kna1,
      45days     TYPE datum,
      30days     TYPE datum,
      zero       TYPE char01,
      sum2       TYPE dmbtr.

DATA:
  lt_listobject   TYPE STANDARD TABLE OF abaplist,
  lv_date_prev_yr TYPE sy-datum,
  lv_index        TYPE syst_index.      " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575

* Begin of changes by KKAKARLA for PMB-318
DATA: itab2     TYPE STANDARD TABLE OF ty_aging,
      wa_tab2   TYPE ty_aging,
      itab3     TYPE STANDARD TABLE OF ty_aging,
      wa_tab3   TYPE ty_aging,
      itab_temp TYPE STANDARD TABLE OF ty_aging,
      wa_temp   TYPE ty_aging,
      date      TYPE sy-datum.
* End of changes by KKAKARLA for PMB-318
************************************************
FIELD-SYMBOLS:
      <fs_asci_tab>   TYPE STANDARD TABLE.

DATA: BEGIN OF ascitab OCCURS 1,
        line(256),
      END OF ascitab.

DATA: lt_knc1tab LIKE rfdkli_knc1_kkber OCCURS 1 WITH HEADER LINE.
DATA: lr_dirtycodes TYPE RANGE OF rstgr,
      wr_dirtycodes LIKE LINE OF lr_dirtycodes.

date = sy-datum - 365.

***** GET ENTRIES FROM BSID
SELECT kunnr zuonr belnr zfbdt zbd1t zbd2t gjahr blart bschl shkzg dmbtr pswbt vbeln bschl bldat xblnr sgtxt rebzg rstgr
    INTO (itab-kunnr, itab-zuonr, itab-belnr, bsid-zfbdt, bsid-zbd1t,
          bsid-zbd2t,                                     " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575
          itab-gjahr, itab-blart, itab-bschl, itab-shkzg, itab-dmbtr, itab-pswbt, itab-vbeln, bsid-bschl, itab-bldat,
          itab-xblnr, itab-sgtxt,
          itab-rebzg,                                     " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575
          bsid-rstgr)
      FROM bsid
         WHERE kunnr IN kunnr AND
               bukrs IN bukrs AND
               budat <= keydate.

  IF itab-xblnr+0(1) = '5'.
    CONCATENATE '000' itab-xblnr INTO itab-jobnumb.
  ENDIF.

  IF reasoncode <> ' '.
    itab-rstgr = bsid-rstgr.
    SELECT SINGLE * FROM t053s INTO @DATA(ls_t053s)" itab-txt40
       WHERE spras = @sy-langu
         AND bukrs = 'BP01'
         AND rstgr = @bsid-rstgr.
    itab-txt40 = ls_t053s-txt40.
    CLEAR: ls_t053s.
  ENDIF.

  IF itab-belnr BETWEEN '0095000000' AND '0095999999' AND bsid-bschl = '11'.
    itab-budat = bsid-zfbdt.
  ELSE.
    " Begin Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575
    " Discount Days
    IF bsid-zbd2t IS NOT INITIAL.
      itab-budat = bsid-zfbdt + bsid-zbd2t.
    ELSE.
      " End Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575
      itab-budat = bsid-zfbdt + bsid-zbd1t.
    ENDIF.
  ENDIF.

  IF itab-vbeln <> ' '.
    SELECT SINGLE bschl zfbdt zbd1t zbd2t FROM bsid INTO (bsid-bschl, bsid-zfbdt, bsid-zbd1t, bsid-zbd2t)
       WHERE  bukrs = 'BP01' AND
              belnr = itab-vbeln.
    IF sy-subrc = 0.
      IF itab-vbeln BETWEEN '0095000000' AND '0095999999' AND bsid-bschl = '11'.
        itab-budat = bsid-zfbdt.
      ELSE.
        " Begin Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575
        " Discount Days
        IF bsid-zbd2t IS NOT INITIAL.
          itab-budat = bsid-zfbdt + bsid-zbd2t.
        ELSE.
          " End Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575
          itab-budat = bsid-zfbdt + bsid-zbd1t.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.
  itab-days = ( itab-budat - keydate ) * -1.
  IF itab-shkzg = 'H'.
    itab-dmbtr = ( itab-dmbtr * -1 ).
    itab-pswbt = ( itab-pswbt * -1 ).
  ENDIF.
  APPEND itab.
  CLEAR: bsid, itab, vbrk.
ENDSELECT.

* Begin of changes by KKAKARLA RTIT-25098
SELECT sign,
       opti,
       low,
       high
       FROM tvarvc INTO TABLE @DATA(lt_dirtycodes)
       WHERE name = 'Z_AR_DIRTY_REASONCODES'
       AND type = 'S'.
IF sy-subrc = 0.
  SORT lt_dirtycodes BY low ASCENDING.
ENDIF.
* End of changes by KKAKARLA RTIT-25098

" Begin Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046
SELECT sign,
       opti,
       low,
       high
  FROM tvarvc
  INTO TABLE @DATA(lt_cleancodes)
  WHERE name = 'Z_AR_CLEAN_REASONCODES'
    AND type = 'S'.
IF sy-subrc = 0.
  SORT lt_cleancodes BY low.
ENDIF.
" End Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046

IF itab[] IS NOT INITIAL.
  SORT itab[] BY kunnr belnr rebzg.
  DATA(lt_itab) = itab[]. " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575
ENDIF.

IF reasoncode = 'Y'.

  " Begin Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575
*    IF report = 'A' OR      " Header All
*       report = 'I' OR      " Header Dirty
*       report = 'J'.        " Header Clean

  SORT lt_itab[] BY kunnr rebzg.

  LOOP AT itab.
    IF itab-belnr+0(4) EQ '0018'.
      itab-vbeln = itab-belnr.
      MODIFY itab.
    ENDIF.
  ENDLOOP.

  LOOP AT itab.
    READ TABLE lt_itab TRANSPORTING NO FIELDS
      WITH KEY kunnr = itab-kunnr
               rebzg = itab-belnr BINARY SEARCH.

    CHECK sy-subrc EQ 0.

    LOOP AT lt_itab ASSIGNING FIELD-SYMBOL(<fs_itab>) FROM sy-tabix. " WHERE rebzg = itab-belnr.
      IF <fs_itab>-rebzg = itab-belnr.
        IF NOT itab-rstgr IS INITIAL.
          <fs_itab>-rstgr = itab-rstgr.
          <fs_itab>-txt40 = itab-txt40.
        ENDIF.
        MODIFY lt_itab FROM <fs_itab> INDEX sy-tabix.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

  " Unassign Field Symbol
  IF <fs_itab> IS ASSIGNED.
    UNASSIGN <fs_itab>.
  ENDIF.

  " Sort the LT_ITAB based on the BELNR field value
  SORT lt_itab[] BY kunnr belnr.

  LOOP AT itab.
    READ TABLE lt_itab INTO DATA(ls_itab)
      WITH KEY kunnr = itab-kunnr
               belnr = itab-rebzg BINARY SEARCH.
    IF sy-subrc EQ 0.
      IF NOT itab-rstgr IS INITIAL.
        ls_itab-rstgr = itab-rstgr.
        ls_itab-txt40 = itab-txt40.
        MODIFY lt_itab FROM ls_itab INDEX sy-tabix.
      ENDIF.
    ENDIF.
    CLEAR: ls_itab.
  ENDLOOP.

  CLEAR: itab[].
  itab[] = lt_itab[].
*    ENDIF.
  " End Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575

  LOOP AT itab.
    IF itab-rstgr <> ' '.
      MOVE itab-rstgr TO reason-rstgr.
      MOVE itab-vbeln TO reason-vbeln.
      MOVE itab-txt40 TO reason-txt40.
      COLLECT reason.
    ENDIF.
    CLEAR: itab, reason.
  ENDLOOP.


  LOOP AT itab.
    IF itab-vbeln IS NOT INITIAL.
      READ TABLE reason WITH KEY vbeln = itab-vbeln.
      IF sy-subrc = 0.
        itab-rstgr = reason-rstgr.
        itab-txt40 = reason-txt40.
        MODIFY itab.
      ENDIF.
      CLEAR: reason.
    ENDIF.
  ENDLOOP.

*    DELETE itab[] WHERE rstgr IS INITIAL.
  CASE report.
    WHEN 'B'.                            "deductions only (dirty)
      LOOP AT itab.
        READ TABLE lt_dirtycodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
        IF sy-subrc <> 0.
          DELETE itab.
        ENDIF.
        CLEAR itab.
      ENDLOOP.
    WHEN 'C'.                            "no deductions (clean)
      LOOP AT itab.
        " Begin Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046
*          READ TABLE lt_dirtycodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
*          IF sy-subrc = 0.
*            DELETE itab.
*          ENDIF.
        READ TABLE lt_cleancodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
        IF sy-subrc NE 0.
          DELETE itab.
        ENDIF.
        " End Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046
        CLEAR itab.
      ENDLOOP.
    WHEN 'G'.                            "deductions only (dirty)
      LOOP AT itab.
        READ TABLE lt_dirtycodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
        IF sy-subrc <> 0.
          DELETE itab.
        ENDIF.
        CLEAR itab.
      ENDLOOP.
    WHEN 'H'.                            "no deductions (clean)
      LOOP AT itab.
        " Begin Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046
*          READ TABLE lt_dirtycodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
*          IF sy-subrc = 0.
*            DELETE itab.
*          ENDIF.
        READ TABLE lt_cleancodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
        IF sy-subrc NE 0.
          DELETE itab.
        ENDIF.
        " End Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046
        CLEAR itab.
      ENDLOOP.
    WHEN 'I'.                            "deductions only (dirty)
      LOOP AT itab.
        READ TABLE lt_dirtycodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
        IF sy-subrc <> 0.
          DELETE itab.
        ENDIF.
        CLEAR itab.
      ENDLOOP.
    WHEN 'J'.                            "no deductions (clean)
      LOOP AT itab.
        " Begin Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046
*          READ TABLE lt_dirtycodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
*          IF sy-subrc = 0.
*            DELETE itab.
*          ENDIF.
        READ TABLE lt_cleancodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
        IF sy-subrc NE 0.
          DELETE itab.
        ENDIF.
        " End Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046
        CLEAR itab.
      ENDLOOP.

  ENDCASE.
ENDIF.

IF reasoncode = 'X'.

  " Begin Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575
  IF report = 'A' OR      " Header All
     report = 'I' OR      " Header Dirty
     report = 'J'.        " Header Clean

    SORT lt_itab[] BY kunnr rebzg.

    LOOP AT itab.
      IF itab-belnr+0(4) EQ '0018'.
        itab-vbeln = itab-belnr.
        MODIFY itab.
      ENDIF.
    ENDLOOP.

    LOOP AT itab.
      READ TABLE lt_itab TRANSPORTING NO FIELDS
        WITH KEY kunnr = itab-kunnr
                 rebzg = itab-belnr BINARY SEARCH.

      CHECK sy-subrc EQ 0.

      LOOP AT lt_itab ASSIGNING <fs_itab> FROM sy-tabix. " WHERE rebzg = itab-belnr.
        IF <fs_itab>-rebzg = itab-belnr.
          IF NOT itab-rstgr IS INITIAL.
            <fs_itab>-rstgr = itab-rstgr.
            <fs_itab>-txt40 = itab-txt40.
          ENDIF.
          MODIFY lt_itab FROM <fs_itab> INDEX sy-tabix.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    " Unassign Field Symbol
    IF <fs_itab> IS ASSIGNED.
      UNASSIGN <fs_itab>.
    ENDIF.

    " Sort the LT_ITAB based on the BELNR field value
    SORT lt_itab[] BY kunnr belnr.

    LOOP AT itab.
      CLEAR: ls_itab.
      READ TABLE lt_itab INTO ls_itab
        WITH KEY kunnr = itab-kunnr
                 belnr = itab-rebzg BINARY SEARCH.
      IF sy-subrc EQ 0.
        IF NOT itab-rstgr IS INITIAL.
          ls_itab-rstgr = itab-rstgr.
          ls_itab-txt40 = itab-txt40.
          MODIFY lt_itab FROM ls_itab INDEX sy-tabix.
        ENDIF.
      ENDIF.
    ENDLOOP.

    CLEAR: itab[].
    itab[] = lt_itab[].
  ENDIF.
  " End Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575

  LOOP AT itab.
    IF itab-rstgr <> ' '.
      MOVE itab-rstgr TO reason-rstgr.
      MOVE itab-vbeln TO reason-vbeln.
      MOVE itab-txt40 TO reason-txt40.
      COLLECT reason.
    ENDIF.
    CLEAR: itab, reason.
  ENDLOOP.


  LOOP AT itab.
    IF itab-vbeln IS NOT INITIAL.
      READ TABLE reason WITH KEY vbeln = itab-vbeln.
      IF sy-subrc = 0.
        itab-rstgr = reason-rstgr.
        itab-txt40 = reason-txt40.
        MODIFY itab.
      ENDIF.
    ENDIF.
    CLEAR: reason.
  ENDLOOP.

*    DELETE itab[] WHERE rstgr IS INITIAL.
  CASE report.
    WHEN 'C'.                            "no deductions (clean)
      LOOP AT itab.
        " Begin Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046
*          READ TABLE lt_dirtycodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
*          IF sy-subrc = 0.
*            DELETE itab.
*          ENDIF.
        READ TABLE lt_cleancodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
        IF sy-subrc NE 0.
          DELETE itab.
        ENDIF.
        " End Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046
        CLEAR itab.
      ENDLOOP.
    WHEN 'J'.                            "no deductions (clean)
      LOOP AT itab.
        " Begin Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046
*          READ TABLE lt_dirtycodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
*          IF sy-subrc = 0.
*            DELETE itab.
*          ENDIF.
        READ TABLE lt_cleancodes WITH KEY low = itab-rstgr TRANSPORTING NO FIELDS BINARY SEARCH .
        IF sy-subrc NE 0.
          DELETE itab.
        ENDIF.
        " End Of Change: Sakthi Thanigaivelan on 10/29/2019 - PMB 1046
        CLEAR itab.
      ENDLOOP.
  ENDCASE.

  " Begin of Change: Sakthi Thanigaivelan on 11/01/2019 - PMB 1046
**    LOOP AT itab.
**      CLEAR itab-rstgr.
**      CLEAR itab-txt40.
**      MODIFY itab.
**      CLEAR: itab.
**    ENDLOOP.
  " End of Change: Sakthi Thanigaivelan on 11/01/2019 - PMB 1046
ENDIF.

SORT itab[]. " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575

***** GET ENTRIES FROM BSAD
SELECT kunnr zuonr belnr zfbdt zbd1t zbd2t gjahr blart bschl shkzg dmbtr pswbt vbeln bschl bldat xblnr sgtxt
  INTO (itab-kunnr, itab-zuonr, itab-belnr, bsad-zfbdt, bsad-zbd1t,
        bsad-zbd2t,                                                     " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575
        itab-gjahr, itab-blart, itab-bschl, itab-shkzg, itab-dmbtr, itab-pswbt, itab-vbeln, bsad-bschl, itab-bldat,
        itab-xblnr, itab-sgtxt)
    FROM bsad
       WHERE kunnr IN kunnr AND
             bukrs IN bukrs AND
             augdt > keydate AND
             budat <= keydate.
  IF itab-xblnr+0(1) = '5'.
    CONCATENATE '000' itab-xblnr INTO itab-jobnumb.
  ENDIF.

  IF itab-belnr BETWEEN '0095000000' AND '0095999999' AND
     bsad-bschl = '11'.
    itab-budat = bsad-zfbdt.
  ELSE.
    " Begin Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575
    " Discount Days
    IF NOT bsad-zbd2t IS INITIAL.
      itab-budat = bsad-zfbdt + bsad-zbd2t.
    ELSE.
      " End Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575
      itab-budat = bsad-zfbdt + bsad-zbd1t.
    ENDIF.
  ENDIF.

  IF itab-vbeln <> ' '.
    SELECT SINGLE bschl zfbdt zbd1t zbd2t FROM bsad INTO (bsad-bschl, bsad-zfbdt, bsad-zbd1t, bsad-zbd2t)
       WHERE bukrs IN bukrs               " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575
         AND belnr = itab-vbeln.
    IF sy-subrc = 0.
      IF itab-vbeln BETWEEN '0095000000' AND '0095999999' AND
          bsad-bschl = '11'.
        itab-budat = bsad-zfbdt.
      ELSE.
        " Begin Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575
        " Discount Days
        IF NOT bsad-zbd2t IS INITIAL.
          itab-budat = bsad-zfbdt + bsad-zbd2t.
        ELSE.
          " End Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575
          itab-budat = bsad-zfbdt + bsad-zbd1t.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.
  itab-days = ( itab-budat - keydate ) * -1.
  IF itab-shkzg = 'H'.
    itab-dmbtr = ( itab-dmbtr * -1 ).
    itab-pswbt = ( itab-pswbt * -1 ).
  ENDIF.
  APPEND itab.
  CLEAR: bsad, itab, vbrk.
ENDSELECT.

SORT itab[] BY kunnr. " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575
***** GET RISK CAT, CUST REP AND CHECK NEW CUSTOMER
LOOP AT itab.
  SELECT SINGLE * FROM knkk
     WHERE kunnr = itab-kunnr AND
          kkber = 'BP01' AND
          ctlpc IN ctlpc AND
          sbgrp IN sbgrp.
  IF sy-subrc = 0.
    itab-crblb = knkk-crblb.
    itab-ctlpc = knkk-ctlpc.
    itab-sbgrp = knkk-sbgrp.
    itab-kraus = knkk-kraus.
    itab-revdb = knkk-revdb.
    itab-zcredit_exp = knkk-klimk - knkk-skfor.
    IF knkk-dbmon = '00000000'.
      itab-dbmon = knkk-erdat.
    ELSE.
      itab-dbmon = knkk-dbmon.
    ENDIF.
    itab-lastpayd = knkk-cashd.
    WRITE knkk-casha TO itab-lastpaya.
    IF knkk-cashd NOT BETWEEN date AND sy-datum.
      itab-new = 'Y'.
    ELSE.
      itab-new = 'N'.
    ENDIF.
    MODIFY itab.
  ELSE.
    DELETE itab.

  ENDIF.
  CLEAR: knkk, itab, knvv.
ENDLOOP.

SORT itab[]. " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575
***** if blocked selection is chosen, get rid of blocked customers
LOOP AT itab.
  IF blocked = 'X'.
    IF itab-crblb = 'X'.
      DELETE itab.
    ENDIF.
  ENDIF.
  CLEAR itab.
ENDLOOP.

SORT itab[]. " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575
***** IF WANT ONLY NEW CUSTOMERS, DELETE OTHERS
LOOP AT itab.
  IF new = 'X'.
    IF itab-new = 'N'.
      DELETE itab.
    ENDIF.
  ENDIF.
  CLEAR itab.
ENDLOOP.

SORT itab[] BY kunnr. " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575
*** pick up terms from knvv
LOOP AT itab.
  SELECT SINGLE * FROM knvv
     WHERE kunnr = itab-kunnr.
  IF sy-subrc = 0.
    itab-zterm = knvv-zterm.
    MODIFY itab.
  ENDIF.
  CLEAR: itab, knvv.
ENDLOOP.


****** FILTER OUT BASED ON SELECTION CRITERIA
*  LOOP AT ITAB.
*    IF ITAB-CTLPC IN CTLPC AND
*       ITAB-SBGRP IN SBGRP.
*    ELSE.
*      DELETE ITAB.
*    ENDIF.*

*    CLEAR: ITAB.
*  ENDLOOP.


******  MOVE ITAB TO ITABD
******    separate into aging, get last pay date > 45 indicator, get invoices over 60 days indicator, get sales last 30 days indicator
* Begin of changes by KKAKARLA PMB-439
*  IF report = 'D' OR
*     report = 'H'.
itab2[] = itab[].
itab3[] = itab[].
*    itab_temp[] = itab[].
* RV is main document type and logic is based on it
* Some documents will be posted without reference number
DELETE itab2 WHERE blart <> 'RV' .
*    DELETE itab3 WHERE vbeln IS NOT INITIAL.
DELETE itab3 WHERE blart = 'RV'.
*    APPEND LINES OF itab3 TO itab2.

SORT itab2 BY vbeln.
SORT itab BY vbeln.
LOOP AT itab2 INTO wa_tab2.
  MOVE-CORRESPONDING wa_tab2 TO itabd.
* Begin of changes by KKAKARLA for SDC-262
*      SELECT SINGLE name1 FROM kna1
*        INTO itabd-name1 WHERE kunnr = itabd-kunnr.

  SELECT SINGLE name1 FROM kna1
    INTO itabd-name1 WHERE kunnr = itabd-kunnr
                       AND ktokd IN ktokd.
  IF sy-subrc IS NOT INITIAL.
    CLEAR kna1.
    CONTINUE.
  ENDIF.
* End of changes by KKAKARLA for SDC-262
***  SELECT SINGLE name1 regio zbonding_comp_1 zinfo_sheet_recd znoticesent zdatenoticesent FROM kna1
***    INTO (itabd-jobname, itabd-jobstate, itabd-jobbond, itabd-zinfo_sheet_recd, itabd-znoticesent, itabd-zdatenoticesent)
***       WHERE kunnr = itabd-jobnumb.
  CLEAR kna1.

  SELECT SINGLE name1 FROM kna1
    INTO itabd-jobbondn
       WHERE kunnr = itabd-jobbond.
  CLEAR kna1.

  IF wa_tab2-vbeln IS NOT INITIAL.
*        LOOP AT itab WHERE vbeln = wa_tab2-vbeln
*                     AND blart NE 'RV'.
*          wa_tab2-dmbtr = wa_tab2-dmbtr + itab-dmbtr.
*        ENDLOOP.
    LOOP AT itab3 ASSIGNING FIELD-SYMBOL(<fs_itab3>) WHERE rebzg = wa_tab2-vbeln.
      wa_tab2-dmbtr = wa_tab2-dmbtr + <fs_itab3>-dmbtr.
      CLEAR <fs_itab3>-belnr.
    ENDLOOP.
  ENDIF.

  IF wa_tab2-days <= 0.
    MOVE wa_tab2-dmbtr TO itabd-col1.
  ENDIF.

  IF wa_tab2-days BETWEEN 1 AND 15.
    MOVE wa_tab2-dmbtr TO itabd-col2a.
    MOVE wa_tab2-days TO itabd-days.
  ENDIF.

  IF wa_tab2-days BETWEEN 16 AND 30.
    MOVE wa_tab2-dmbtr TO itabd-col2b.
    MOVE wa_tab2-days TO itabd-days.
  ENDIF.

* Begin of changes by KKAKARLA PMB-981
  IF wa_tab2-days > 30.
    MOVE wa_tab2-dmbtr TO itabd-col2c.
    MOVE wa_tab2-days TO itabd-days.
  ENDIF.
* End of changes by KKAKARLA PMB-981

  IF wa_tab2-days BETWEEN 1 AND 30.
    MOVE wa_tab2-dmbtr TO itabd-col2.
    MOVE wa_tab2-days TO itabd-days.
  ENDIF.

  IF wa_tab2-days BETWEEN 31 AND 60.
    MOVE wa_tab2-dmbtr TO itabd-col3.
    MOVE wa_tab2-days TO itabd-days.
  ENDIF.

* Begin of changes by KKAKARLA PMB-981
  IF wa_tab2-days > 60.
    MOVE wa_tab2-dmbtr TO itabd-col3a.
    MOVE wa_tab2-days TO itabd-days.
  ENDIF.
* End of changes by KKAKARLA PMB-981

  IF wa_tab2-days > 90.
    MOVE wa_tab2-days TO itabd-days.
    MOVE wa_tab2-dmbtr TO itabd-col5a.
  ENDIF.

  IF wa_tab2-days BETWEEN 61 AND 90.
    MOVE wa_tab2-days TO itabd-days.
    MOVE wa_tab2-dmbtr TO itabd-col4.
  ENDIF.

  IF wa_tab2-days BETWEEN 91 AND 120.
    MOVE wa_tab2-days TO itabd-days.
    MOVE wa_tab2-dmbtr TO itabd-col5.
  ENDIF.

  IF wa_tab2-days > 120.
    MOVE wa_tab2-days TO itabd-days.
    MOVE wa_tab2-dmbtr TO itabd-col6.
  ENDIF.

  45days = sy-datum - 45.
  30days = sy-datum - 31.

  IF wa_tab2-lastpayd < 45days.
    itabd-nopay = 'Y'.
  ENDIF.

  IF wa_tab2-blart = 'RV' AND
     wa_tab2-bschl = '01'.
    IF wa_tab2-days   > 60.
      MOVE 'Y' TO itabd-over60.
    ENDIF.

    IF wa_tab2-bldat >= 30days.
      MOVE 'Y' TO itabd-last30.
    ENDIF.
  ENDIF.
  APPEND itabd.
  CLEAR: itabd, kna1.
* Deleting itab table to capture records with reference number and type is not RV
*      IF wa_tab2-vbeln IS NOT INITIAL.
*        DELETE itab[] WHERE vbeln = wa_tab2-vbeln.
*      ELSE.
*        DELETE itab[] WHERE belnr = wa_tab2-belnr
*                      AND vbeln IS INITIAL.
*      ENDIF.
  DELETE itab3[] WHERE belnr IS INITIAL.
ENDLOOP.
*  ENDIF.
* Begin of changes by KKAKARLA RTIT-26778
itab_temp[] = itab3.

* Delete items with reference number
LOOP AT itab3 ASSIGNING <fs_itab3>.
  IF <fs_itab3>-belnr <> <fs_itab3>-rebzg AND
     <fs_itab3>-rebzg <> ' '.
    CLEAR <fs_itab3>-belnr.
  ENDIF.
ENDLOOP.
DELETE itab3[] WHERE belnr IS INITIAL.

* Delete item without reference number
LOOP AT itab_temp ASSIGNING FIELD-SYMBOL(<fs_temp>).
  IF <fs_temp>-belnr = <fs_temp>-rebzg OR
     <fs_temp>-rebzg = ' '.
    CLEAR <fs_temp>-belnr.
  ENDIF.
ENDLOOP.
DELETE itab_temp[] WHERE belnr IS INITIAL.

LOOP AT itab3 ASSIGNING <fs_itab3>.
  LOOP AT itab_temp ASSIGNING <fs_temp> WHERE kunnr = <fs_itab3>-kunnr
                                          AND rebzg = <fs_itab3>-belnr.
    <fs_itab3>-dmbtr = <fs_itab3>-dmbtr + <fs_temp>-dmbtr.
    CLEAR <fs_temp>-belnr.
  ENDLOOP.
ENDLOOP.
DELETE itab_temp WHERE belnr IS INITIAL.
APPEND LINES OF itab_temp TO itab3.
*  SORT itab[]. " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575
*  IF report NE 'I' AND     " Header Dirty  " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575
*     report NE 'J'.        " Header Clean  " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575

* Process left over records with document type is not RV and with inv reference number
* also for reports other than item detail and dirty
SORT itab3[].
*    LOOP AT itab.
LOOP AT itab3 INTO wa_tab3.
*      MOVE-CORRESPONDING itab TO itabd.
  MOVE-CORRESPONDING wa_tab3 TO itabd.
* Begin of changes by KKAKARLA for SDC-262
*      SELECT SINGLE name1 FROM kna1
*        INTO itabd-name1 WHERE kunnr = itabd-kunnr.

  SELECT SINGLE name1 FROM kna1
    INTO itabd-name1 WHERE kunnr = itabd-kunnr
                       AND ktokd IN ktokd.
  IF sy-subrc IS NOT INITIAL.
    CLEAR kna1.
    CONTINUE.
  ENDIF.
* End of changes by KKAKARLA for SDC-262

***  SELECT SINGLE name1 regio zbonding_comp_1 zinfo_sheet_recd znoticesent zdatenoticesent FROM kna1
***    INTO (itabd-jobname, itabd-jobstate, itabd-jobbond, itabd-zinfo_sheet_recd, itabd-znoticesent, itabd-zdatenoticesent)
***       WHERE kunnr = itabd-jobnumb.
  CLEAR kna1.

  SELECT SINGLE name1 FROM kna1
    INTO itabd-jobbondn
       WHERE kunnr = itabd-jobbond.
  CLEAR kna1.

  IF wa_tab3-days <= 0.
    MOVE wa_tab3-dmbtr TO itabd-col1.
  ENDIF.

  IF wa_tab3-days BETWEEN 1 AND 15.
    MOVE wa_tab3-dmbtr TO itabd-col2a.
    MOVE wa_tab3-days TO itabd-days.
  ENDIF.

  IF wa_tab3-days BETWEEN 16 AND 30.
    MOVE wa_tab3-dmbtr TO itabd-col2b.
    MOVE wa_tab3-days TO itabd-days.
  ENDIF.

  IF wa_tab3-days BETWEEN 1 AND 30.
    MOVE wa_tab3-dmbtr TO itabd-col2.
    MOVE wa_tab3-days TO itabd-days.
  ENDIF.

* Begin of changes by KKAKARLA PMB-981
  IF wa_tab3-days > 30.
    MOVE wa_tab3-dmbtr TO itabd-col2c.
    MOVE wa_tab3-days TO itabd-days.
  ENDIF.
* End of changes by KKAKARLA PMB-981

  IF wa_tab3-days BETWEEN 31 AND 60.
    MOVE wa_tab3-dmbtr TO itabd-col3.
    MOVE wa_tab3-days TO itabd-days.
  ENDIF.

* Begin of changes by KKAKARLA PMB-981
  IF wa_tab3-days > 60.
    MOVE wa_tab3-dmbtr TO itabd-col3a.
    MOVE wa_tab3-days TO itabd-days.
  ENDIF.
* End of changes by KKAKARLA PMB-981

  IF wa_tab3-days > 90.
    MOVE wa_tab3-days TO itabd-days.
    MOVE wa_tab3-dmbtr TO itabd-col5a.
  ENDIF.

  IF wa_tab3-days BETWEEN 61 AND 90.
    MOVE wa_tab3-days TO itabd-days.
    MOVE wa_tab3-dmbtr TO itabd-col4.
  ENDIF.

  IF wa_tab3-days BETWEEN 91 AND 120.
    MOVE wa_tab3-days TO itabd-days.
    MOVE wa_tab3-dmbtr TO itabd-col5.
  ENDIF.

  IF wa_tab3-days > 120.
    MOVE wa_tab3-days TO itabd-days.
    MOVE wa_tab3-dmbtr TO itabd-col6.
  ENDIF.

  45days = sy-datum - 45.
  30days = sy-datum - 31.

  IF wa_tab3-lastpayd < 45days.
    itabd-nopay = 'Y'.
  ENDIF.

  IF wa_tab3-blart = 'RV' AND
     wa_tab3-bschl = '01'.
    IF wa_tab3-days   > 60.
      MOVE 'Y' TO itabd-over60.
    ENDIF.

    IF wa_tab3-bldat >= 30days.
      MOVE 'Y' TO itabd-last30.
    ENDIF.
  ENDIF.

*     select single * from ZCE1BP01_SUMM3
*        where kndnr = itab-kunnr and
*            ERLOS > 0.
*         if sy-subrc = 0.
*            else.
*              itabd-last30 = 'Y'.
*         endif.
*
*       clear: zce1bp01_summ3.

  APPEND itabd.
  CLEAR: itabd, kna1.
ENDLOOP.

IF report = 'D' OR
   report = 'G' OR
   report = 'H'.
  IF shipto[] IS NOT INITIAL.
    DELETE itabd[] WHERE jobnumb NOT IN shipto.
  ENDIF.
ENDIF.
* End of changes by KKAKARLA PMB-439

LOOP AT itabd.
  itabd-sum = itabd-col1 + itabd-col2 + itabd-col3 + itabd-col4 + itabd-col5 + itabd-col6.
  MODIFY itabd.
  CLEAR: itabd.
ENDLOOP.

LOOP AT itabd.
  MOVE-CORRESPONDING itabd TO itabh.
  CLEAR itabh-over60.
  CLEAR itabh-last30.
  COLLECT itabh.
  CLEAR: itabd, itabh.
ENDLOOP.

LOOP AT itabh.
  READ TABLE itabd WITH KEY kunnr = itabh-kunnr
                        over60 = 'Y'.
  IF sy-subrc = 0.
    itabh-over60 = 'Y'.
    MODIFY itabh.
  ENDIF.
  CLEAR: itabd.

  READ TABLE itabh WITH KEY kunnr = itabh-kunnr
                         last30 = 'Y'.
  IF sy-subrc = 0.
    itabh-last30 = 'Y'.
    MODIFY itabh.
  ENDIF.
  CLEAR: itabh, itabd.
ENDLOOP.
*  ENDIF. " Added by Sakthi on 03/01/2018 - PMB 599 - DE2K904575

" Begin Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575
IF reasoncode NE ' '.
  IF report = 'A' OR      " Header All
     report = 'I' OR      " Header Dirty
     report = 'J'.        " Header Clean

    " Sort and Assign the ITAB values to local internal table LT_ITAB
    SORT itab[].
    lt_itab[] = itab[].
    SORT lt_itab[] BY kunnr rebzg.

    " Summing the values(DMBTR) using the Accounting Doc Number(BELNR) and
    "   comparing with Invoice Ref Number(REBZG)
    LOOP AT itab.
      lv_index = sy-tabix.
      READ TABLE lt_itab TRANSPORTING NO FIELDS
        WITH KEY kunnr = itab-kunnr
                 rebzg = itab-belnr BINARY SEARCH.

      CHECK sy-subrc EQ 0.

      LOOP AT lt_itab ASSIGNING <fs_itab> FROM sy-tabix. "WHERE rebzg = itab-belnr.
        IF <fs_itab>-rebzg = itab-belnr.
          itab-dmbtr = <fs_itab>-dmbtr + itab-dmbtr.
        ENDIF.
      ENDLOOP.
      MODIFY itab INDEX lv_index.
      CLEAR: lv_index.
    ENDLOOP.

    " Unassign Field Symbol
    IF <fs_itab> IS ASSIGNED.
      UNASSIGN <fs_itab>.
    ENDIF.

    SORT itab[].
    " Delete the Intenral table records using the Invoice Ref Number(REBZG)
    "   comparing with the Accounting Doc Number(BELNR)
    LOOP AT itab.
      READ TABLE lt_itab TRANSPORTING NO FIELDS
        WITH KEY kunnr = itab-kunnr
                 rebzg = itab-belnr BINARY SEARCH.

      CHECK sy-subrc EQ 0.

      LOOP AT lt_itab ASSIGNING <fs_itab> FROM sy-tabix.
        IF <fs_itab>-rebzg = itab-belnr AND
           <fs_itab>-kunnr = itab-kunnr AND
           <fs_itab>-sbgrp = itab-sbgrp.
          DELETE itab WHERE kunnr EQ <fs_itab>-kunnr
                        AND belnr EQ <fs_itab>-belnr.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    SORT itab[].
    CLEAR: itabd[], itabh[], itab.
    LOOP AT itab.
      MOVE-CORRESPONDING itab TO itabd.
      SELECT SINGLE name1 FROM kna1
        INTO itabd-name1 WHERE kunnr EQ itabd-kunnr
                           AND ktokd IN ktokd.
      IF sy-subrc IS NOT INITIAL.
        CLEAR kna1.
        CONTINUE.
      ENDIF.

      IF itab-days <= 0.
        MOVE itab-dmbtr TO itabd-col1.
      ENDIF.

      IF itab-days BETWEEN 1 AND 15.
        MOVE itab-dmbtr TO itabd-col2a.
        MOVE itab-days TO itabd-days.
      ENDIF.

      IF itab-days BETWEEN 16 AND 30.
        MOVE itab-dmbtr TO itabd-col2b.
        MOVE itab-days TO itabd-days.
      ENDIF.

      IF itab-days BETWEEN 1 AND 30.
        MOVE itab-dmbtr TO itabd-col2.
        MOVE itab-days TO itabd-days.
      ENDIF.

* Begin of changes by KKAKARLA PMB-981
      IF itab-days > 30.
        MOVE itab-dmbtr TO itabd-col2c.
        MOVE itab-days TO itabd-days.
      ENDIF.
* End of changes by KKAKARLA PMB-981

      IF itab-days BETWEEN 31 AND 60.
        MOVE itab-dmbtr TO itabd-col3.
        MOVE itab-days TO itabd-days.
      ENDIF.

* Begin of changes by KKAKARLA PMB-981
      IF itab-days > 60.
        MOVE itab-dmbtr TO itabd-col3a.
        MOVE itab-days TO itabd-days.
      ENDIF.
* End of changes by KKAKARLA PMB-981

      IF itab-days BETWEEN 61 AND 90.
        MOVE itab-days TO itabd-days.
        MOVE itab-dmbtr TO itabd-col4.
      ENDIF.

      IF itab-days BETWEEN 91 AND 120.
        MOVE itab-days TO itabd-days.
        MOVE itab-dmbtr TO itabd-col5.
      ENDIF.

      IF itab-days > 90.
        MOVE itab-days TO itabd-days.
        MOVE itab-dmbtr TO itabd-col5a.
      ENDIF.

      IF itab-days > 120.
        MOVE itab-days TO itabd-days.
        MOVE itab-dmbtr TO itabd-col6.
      ENDIF.

      45days = sy-datum - 45.
      30days = sy-datum - 31.

      IF itab-lastpayd < 45days.
        itabd-nopay = 'Y'.
      ENDIF.

      IF itab-blart = 'RV' AND
         itab-bschl = '01'.
        IF itab-days   > 60.
          MOVE 'Y' TO itabd-over60.
        ENDIF.

        IF itab-bldat >= 30days.
          MOVE 'Y' TO itabd-last30.
        ENDIF.
      ENDIF.

      APPEND itabd.
      CLEAR: itabd, kna1.
    ENDLOOP.

    SORT itabd[].
    LOOP AT itabd.
      itabd-sum = itabd-col1 + itabd-col2 + itabd-col3 + itabd-col4 + itabd-col5 + itabd-col6.
      MODIFY itabd.
      CLEAR: itabd.
    ENDLOOP.

    LOOP AT itabd.
      MOVE-CORRESPONDING itabd TO itabh.
      CLEAR itabh-over60.
      CLEAR itabh-last30.
      COLLECT itabh.
      CLEAR: itabd, itabh.
    ENDLOOP.

    LOOP AT itabh.
      READ TABLE itabd WITH KEY kunnr = itabh-kunnr
                                over60 = 'Y'.
      IF sy-subrc = 0.
        itabh-over60 = 'Y'.
        MODIFY itabh.
      ENDIF.
      CLEAR: itabd.

      READ TABLE itabh WITH KEY kunnr = itabh-kunnr
                                last30 = 'Y'.
      IF sy-subrc = 0.
        itabh-last30 = 'Y'.
        MODIFY itabh.
      ENDIF.
      CLEAR: itabh, itabd.
    ENDLOOP.

    CLEAR: lt_itab[].
  ENDIF.
ENDIF.
" End Of Change: Sakthi on 03/01/2018 - PMB 599 - DE2K904575

IF zero = 'X'.
  LOOP AT itabh.
    IF itabh-col2 = 0 AND
       itabh-col3 = 0 AND
       itabh-col4 = 0 AND
       itabh-col5 = 0 AND
       itabh-col6 = 0.
      DELETE itabh.
    ENDIF.
    CLEAR: itabh.
  ENDLOOP.
ENDIF.

" Credit Limit Logic
LOOP AT itabh.
  SELECT SINGLE klimk FROM knkk
    INTO itabh-klimk
     WHERE kunnr = itabh-kunnr AND
           kkber = 'BP01'.

  SELECT SINGLE * FROM knvv
     WHERE kunnr = itabh-kunnr.
  IF sy-subrc = 0.

    IF itabh-klimk < itabh-sum.
      sum2 = itabh-klimk - itabh-sum.
      IF sum2 <> 0 AND itabh-klimk <> 0.
        itabh-percover = ( sum2 / itabh-klimk ) * 100.
        IF itabh-percover < 0.
          itabh-percover = itabh-percover * -1.
        ENDIF.
      ENDIF.
    ENDIF.
    MODIFY itabh.
  ELSE.
    DELETE itabh.
  ENDIF.
  CLEAR: knkk, itabh, sum2.
ENDLOOP.

SORT itabh BY kunnr.

" Last Invoice Date
IF itabh[] IS NOT INITIAL.
  lv_date_prev_yr = sy-datum - 365.
  SELECT kunde,
         fkdat
    FROM vrkpa
    INTO TABLE @DATA(lt_inv_dates)
    FOR ALL ENTRIES IN @itabh
    WHERE kunde = @itabh-kunnr
      AND vbtyp = 'M'
      AND fkdat > @lv_date_prev_yr.
  IF sy-subrc = 0.
    SORT lt_inv_dates BY kunde ASCENDING fkdat DESCENDING.
    LOOP AT itabh.
      READ TABLE lt_inv_dates ASSIGNING FIELD-SYMBOL(<fs_inv_dates>) WITH KEY kunde = itabh-kunnr.
      IF sy-subrc = 0 AND <fs_inv_dates> IS ASSIGNED.
        itabh-last_inv_date = <fs_inv_dates>-fkdat.
      ENDIF.
      MODIFY itabh.
      CLEAR itabh.
    ENDLOOP.
  ENDIF.
ENDIF.

LOOP AT itabh.

*    SUBMIT rfdkli41 WITH kunnr = itabh-kunnr WITH kkber = 'BP01' EXPORTING LIST TO MEMORY AND RETURN.
*    IMPORT gt_knc1ktab TO lt_knc1tab FROM MEMORY ID 'ZKNC1TAB'.
*    IF sy-subrc = 0.
*      READ TABLE lt_knc1tab ASSIGNING FIELD-SYMBOL(<fs_knc1ktab>) WITH KEY knkli = itabh-kunnr.
*      IF sy-subrc = 0 AND <fs_knc1ktab> IS ASSIGNED.
*        itabh-h12sa = <fs_knc1ktab>-h12sa.
*        itabh-ump1u = <fs_knc1ktab>-ump1u.
*        itabh-ump2u = <fs_knc1ktab>-ump2u.
*      ENDIF.
*      FREE MEMORY ID 'ZKNC1TAB'.
*    ENDIF.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
    EXPORTING
      input  = itabh-kunnr
    IMPORTING
      output = itabh-kunnr.

  MODIFY itabh.
  CLEAR: itabh.
ENDLOOP.


" Begin Of Change: Sakthi on 03/22/2018 - DE2K904796
" Logic to add the Credit Limit in the Detail Reports
SORT itabd[].
SORT itabh[] BY kunnr.
LOOP AT itabd.
  SHIFT itabd-kunnr LEFT DELETING LEADING '0'.
  READ TABLE itabh[] INTO DATA(ls_itabh)
    WITH KEY kunnr = itabd-kunnr BINARY SEARCH.
  IF sy-subrc EQ 0.
    itabd-klimk = ls_itabh-klimk.
    MODIFY itabd.
  ENDIF.
  CLEAR: itabd.
ENDLOOP.
" End Of Change: Sakthi on 03/22/2018 - DE2K904796

*  CLEAR itab[].
*  APPEND LINES OF itab_temp[] TO itab[].
