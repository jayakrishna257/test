
TYPES: BEGIN OF ty_vbak,
         vbeln TYPE vbak-vbeln,
         ernam TYPE vbak-ernam,
       END OF ty_vbak.

TYPES: BEGIN OF ty_vbap,
         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
       END OF ty_vbap.

TYPES: BEGIN OF ty_final,
         vbeln TYPE vbak-vbeln,
         ernam TYPE vbak-ernam,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
       END OF ty_final.


DATA: lv_vbeln TYPE vbak-vbeln,
      lv_cnt   TYPE i,
      lt_vbak  TYPE TABLE OF ty_vbak,
      ls_vbak  TYPE ty_vbak,
      lt_vbap  TYPE TABLE OF ty_vbap,
      ls_vbap  TYPE ty_vbap,
      lt_final TYPE TABLE OF ty_final,
      ls_final TYPE ty_final.

SELECT-OPTIONS: s_vbeln FOR lv_vbeln.

*INITIALIZATION.
*  s_vbeln-low = '123'.
*  s_vbeln-high = '456'.
*  APPEND s_vbeln TO s_vbeln.
*

AT SELECTION-SCREEN ON s_vbeln.
  SELECT COUNT(*)
    FROM vbak
    WHERE vbeln IN s_vbeln.
  IF sy-subrc <> 0.
    MESSAGE 'Invalid sales doc' TYPE 'E'.
  ENDIF.

START-OF-SELECTION.
  SELECT vbeln
         ernam
    FROM vbak
    INTO TABLE lt_vbak
    WHERE vbeln IN s_vbeln.
  IF sy-subrc = 0.

    SORT: lt_vbak BY vbeln.

    SELECT vbeln
           posnr
           matnr
      FROM vbap
      INTO TABLE lt_vbap
      FOR ALL ENTRIES IN lt_vbak
      WHERE vbeln = lt_vbak-vbeln.
    IF sy-subrc = 0.

    ENDIF.
  ENDIF.

  LOOP AT lt_vbap INTO ls_vbap.
    ls_final-vbeln = ls_vbap-vbeln.
    ls_final-posnr = ls_vbap-posnr.
    ls_final-matnr = ls_vbap-matnr.
    READ TABLE lt_vbak INTO ls_vbak
                       WITH KEY vbeln = ls_vbap-vbeln
                       BINARY SEARCH.
    IF sy-subrc = 0.
      ls_final-ernam = ls_vbak-ernam.
    ENDIF.
    APPEND ls_final TO lt_final.
    CLEAR: ls_final,
           ls_vbak,
           ls_vbap.
  ENDLOOP.

  DATA: lt_fcat TYPE slis_t_fieldcat_alv,
        ls_fcat TYPE slis_fieldcat_alv.

  ls_fcat-col_pos = 1.
  ls_fcat-hotspot = abap_true.
  ls_fcat-fieldname = 'VBELN'.
  ls_fcat-outputlen = 20.
  ls_fcat-seltext_l = 'Sales Document'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR: ls_fcat.

  ls_fcat-col_pos = 2.
  ls_fcat-fieldname = 'ERNAM'.
  ls_fcat-seltext_l = 'Created By'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR: ls_fcat.

  ls_fcat-col_pos = 3.
  ls_fcat-fieldname = 'POSNR'.
  ls_fcat-seltext_l = 'Sales Item'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR: ls_fcat.

  ls_fcat-col_pos = 4.
  ls_fcat-fieldname = 'MATNR'.
  ls_fcat-seltext_l = 'Material Number'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR: ls_fcat.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program      = sy-repid            " Name of the calling program
      i_callback_user_command = 'USER_COMMAND'            " EXIT routine for command handling
      it_fieldcat             = lt_fcat                 " Field catalog with field descriptions
    TABLES
      t_outtab                = lt_final                 " Table with data to be displayed
    EXCEPTIONS
      program_error           = 1                " Program errors
      OTHERS                  = 2.
  IF sy-subrc <> 0.
* MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*   WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

FORM user_command USING ls_ucomm TYPE sy-ucomm ls_selfield TYPE slis_selfield.
  SET PARAMETER ID 'AUN' FIELD ls_selfield-value.
  CALL TRANSACTION 'VA03' AND SKIP FIRST SCREEN.
ENDFORM.
