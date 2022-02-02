*&---------------------------------------------*
*&  INCLUDE      ZTEILNEHMER13_A_SELEKTIONSBILD*
*&---------------------------------------------*

* Block auf Selektionsbildschirm mit Rahmen und
   " Rahmentext
   SELECTION-SCREEN BEGIN OF BLOCK teilnehmer
                    WITH FRAME TITLE text-001.
   PARAMETERS: par01 AS CHECKBOX,
               par02 AS CHECKBOX,
               par03 AS CHECKBOX,
               par04 AS CHECKBOX,
               execlopr AS CHECKBOX,
               it04down AS CHECKBOX,
               locfile TYPE c length 128
                  default 'C:\TEMP\TEST.XLS'.
   SELECTION-SCREEN END OF BLOCK teilnehmer.