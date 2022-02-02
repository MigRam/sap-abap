*&----------------------------------------------------*
*&  Include           ZTEILNEHMER13_B_SELEKTIONSBILD
*&----------------------------------------------------*
 SELECTION-SCREEN BEGIN OF BLOCK v13b
                  WITH FRAME TITLE text-001.
 PARAMETERS: rsmw   AS CHECKBOX,  " Report starten mit Wiederkehr
             rsow   AS CHECKBOX,  " Report starten ohne Wiederkehr, mit leerem Selektionsbildschirm
             rsowas AS CHECKBOX,  " Report starten ohne Wiederkehr, mit ausgefülltem Selektionsbildschirm
             rsowih AS CHECKBOX.  " Report starten ohne Wiederkehr, mit dunklem Selektionsbildschirm
 SELECTION-SCREEN END OF BLOCK v13b.