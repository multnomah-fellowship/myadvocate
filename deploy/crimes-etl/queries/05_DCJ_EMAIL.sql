SELECT     CASE_MAIN.CASE_ID_NBR, CASE_MAIN.CASE_NBR, CASE_CHARGE.CHARGE_NBR, CASE_CHARGE.CHARGE_ID_NBR,
                      CHARGE_SENTENCE.SENTENCE_ID_NBR, SENTENCE_IMPRISONMENT.POSTPRISON_QTY, SENTENCE_IMPRISONMENT.POSTPRISON_QTY_UNIT,
                      PROBATION.PROBATION_TYPE AS PROBATION_TYPE_CODE, CODE_TABLE.TABLE_DESC AS PROBATION_TYPE, PROBATION.TOTAL_PROB_QTY,
                      PROBATION.TOTAL_PROB_QTY_UNIT, PROBATION.PROB_JAIL_QTY, PROBATION.PROB_JAIL_QTY_UNIT, PROBATION.JAIL_QTY_SUSP,
                      PROBATION.JAIL_QTY_SUSP_UNIT, CHARGE_SENTENCE.PERSON_ID_NBR, CASE_PERSON_INFO.LAST_NAME, CASE_PERSON_INFO.FIRST_NAME,
                      CASE_PERSON.PROBATION, CASE_PERSON.COURT_NBR, CASE_PERSON_INFO.OREGON_SID_NBR, CASE_CHARGE.FORM_NAME,
                      CASE_PERSON.CASE_PERSON_NBR, CHARGE_SENTENCE.SENTENCE_NBR, CODE_TABLE_1.TABLE_DESC AS SENTENCE_DESC,
                      CASE_MAIN.UPDATE_DATE AS CASE_UPDATE_DATE, PROBATION.CREATE_DATE AS PROBATION_CREATE_DATE,
                      CASE_CHARGE.UPDATE_DATE AS CHARGE_UPDATE_DATE, CASE_CHARGE.UPDATE_DATE, PROBATION.COMMENCE_WHEN,
                      PROBATION.COMMENCE_DATE, PROBATION.PROB_CONSECUTIVE_CHARGE, PROBATION.PROB_CONCURRENT_CHARGE,
                      PROBATION.PROB_CONSECUTIVE_CASE, PROBATION.PROB_CONCURRENT_CASE, PROBATION.JAIL_CONSECUTIVE_CHARGE,
                      PROBATION.JAIL_CONCURRENT_CHARGE, PROBATION.JAIL_CONSECUTIVE_CASE, PROBATION.JAIL_CONCURRENT_CASE,
                      PROBATION.PROB_CREDIT, PROBATION.PROB_CREDIT_VALUE, CASE_PERSON_INFO_1.PERSON_ID_NBR AS VICTIM_PERSON_ID_NBR,
                      CASE_PERSON_1.CASE_PERSON_TYPE AS VICTIM_PERSON_TYPE, CASE_PERSON_INFO_1.LAST_NAME AS VICTIM_LAST_NAME,
                      CASE_PERSON_INFO_1.FIRST_NAME AS VICTIM_FIRST_NAME, CASE_PERSON_ADDRESS.ADDRESS AS VICTIM_ADDRESS,
                      CASE_PERSON_ADDRESS.ADDRESS2 AS VICTIM_ADDRESS_2, CASE_PERSON_ADDRESS.CITY AS VICTIM_ADDRESS_CITY,
                      CASE_PERSON_ADDRESS.STATE AS VICTIM_ADDRESS_STATE, CASE_PERSON_ADDRESS.ZIPCODE AS VICTIM_ADDRESS_ZIPCODE,
                      CASE_PERSON_PHONE.AREA_CODE AS VICTIM_PHONE_AREA_CODE, CASE_PERSON_PHONE.PHONE AS VICTIM_PHONE,
                      CHARGE_SENTENCE.SENTENCE_TYPE, CASE_PERSON_ADDRESS.EMAIL
FROM         CODE_TABLE RIGHT OUTER JOIN
                      CASE_PERSON RIGHT OUTER JOIN
                      CASE_PERSON_INFO INNER JOIN
                      CHARGE_SENTENCE INNER JOIN
                      CASE_CHARGE INNER JOIN
                      CASE_MAIN ON CASE_CHARGE.CASE_ID_NBR = CASE_MAIN.CASE_ID_NBR ON
                      CHARGE_SENTENCE.CHARGE_ID_NBR = CASE_CHARGE.CHARGE_ID_NBR ON
                      CASE_PERSON_INFO.PERSON_ID_NBR = CHARGE_SENTENCE.PERSON_ID_NBR INNER JOIN
                      CASE_PERSON AS CASE_PERSON_1 ON CASE_MAIN.CASE_ID_NBR = CASE_PERSON_1.CASE_ID_NBR INNER JOIN
                      CASE_PERSON_INFO AS CASE_PERSON_INFO_1 ON CASE_PERSON_1.PERSON_ID_NBR = CASE_PERSON_INFO_1.PERSON_ID_NBR INNER JOIN
                      PROBATION ON CHARGE_SENTENCE.SENTENCE_ID_NBR = PROBATION.SENTENCE_ID_NBR ON
                      CASE_PERSON.PERSON_ID_NBR = CHARGE_SENTENCE.PERSON_ID_NBR AND CASE_PERSON.CASE_ID_NBR = CASE_CHARGE.CASE_ID_NBR ON
                      CODE_TABLE.TABLE_CODE = PROBATION.PROBATION_TYPE LEFT OUTER JOIN
                      CODE_TABLE AS CODE_TABLE_1 ON CHARGE_SENTENCE.SENTENCE_TYPE = CODE_TABLE_1.TABLE_CODE LEFT OUTER JOIN
                      CASE_PERSON_ADDRESS ON CASE_PERSON_INFO_1.PERSON_ID_NBR = CASE_PERSON_ADDRESS.PERSON_ID_NBR LEFT OUTER JOIN
                      CASE_PERSON_PHONE ON CASE_PERSON_INFO_1.PERSON_ID_NBR = CASE_PERSON_PHONE.PERSON_ID_NBR LEFT OUTER JOIN
                      SENTENCE_IMPRISONMENT ON CHARGE_SENTENCE.SENTENCE_ID_NBR = SENTENCE_IMPRISONMENT.SENTENCE_ID_NBR
WHERE     (CASE_MAIN.CASE_STATUS = 'CLOSED') AND (CASE_CHARGE.CHARGE_STATE = 'CONVICTED') AND (PROBATION.UPDATE_DATE BETWEEN
                      DATEADD(month, - 2, GETDATE()) AND GETDATE()) AND (CASE_PERSON_1.CASE_PERSON_TYPE IN ('VICTIM', 'VIC/WIT')) AND
                      (CASE_PERSON_ADDRESS.ALL_DOCS = 'T') AND (CASE_PERSON_ADDRESS.SUB_ONLY = 'T') AND (CASE_PERSON_PHONE.DEFAULT_PHONE = 'T')
