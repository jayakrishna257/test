CLASS lcl_test DEFINITION.

  PUBLIC SECTION.
    DATA: x TYPE i.              "Instance attribute
    CLASS-DATA: static TYPE i.   "Static attribute
    METHODS: increment_x,
      get_private RETURNING VALUE(rv_private) TYPE i,
      set_private IMPORTING iv_private TYPE i.
    CLASS-METHODS: increment_static.
  PRIVATE SECTION.
    DATA: private TYPE i.
ENDCLASS.


CLASS lcl_test IMPLEMENTATION.
  METHOD increment_x.
    x = x + 1.
  ENDMETHOD.
  METHOD increment_static.
    static = static + 1.
  ENDMETHOD.
  METHOD get_private.
    rv_private = private + 1.
  ENDMETHOD.
  METHOD set_private.
    private = iv_private.
  ENDMETHOD.
ENDCLASS.

DATA: lo_ref1 TYPE REF TO lcl_test.
DATA: lo_ref2 TYPE REF TO lcl_test.

START-OF-SELECTION.
  CREATE OBJECT lo_ref1.
  lo_ref1->x = 1.
  CREATE OBJECT lo_ref2.
  lo_ref2->x = 2.


  lo_ref1->increment_x( ).
  lo_ref1->set_private( 100 ).
  DATA(lv_private) = lo_ref1->get_private( ).

  lo_ref1->increment_static( ).

  lcl_test=>static = 100.     "Accessing static member using class name
  lo_ref1->static = 1000.     "Accessing static member using object

*WRITE: 'Value of x in object1 is:',lo_ref1->x.

  IF 1 = 3.

  ENDIF.
