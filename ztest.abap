DATA: lv_vbeln TYPE vbak-vbeln,
      lv_cnt TYPE i.

SELECT-OPTIONS: s_vbeln FOR lv_vbeln.

*INITIALIZATION.
*  s_vbeln-low = '123'.
*  s_vbeln-high = '456'.
*  APPEND s_vbeln TO s_vbeln.
*

AT SELECTION-SCREEN ON s_vbeln.
  SELECT COUNT(*)
    FROM vbak
    INTO lv_cnt
    WHERE vbeln IN s_vbeln.
  IF sy-subrc <> 0.
    MESSAGE 'Invalid sales doc' TYPE 'E'.
  ELSE.
    MESSAGE 'Valid record' TYPE 'S'.
  ENDIF.

START-OF-SELECTION.
  WRITE lv_cnt.
