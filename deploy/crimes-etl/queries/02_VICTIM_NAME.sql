SELECT     CFA_TOM_VRN.CASE_ID_NBR, CFA_TOM_VRN.PERSON_ID_NBR, CASE_PERSON_INFO.LAST_NAME, CASE_PERSON_INFO.FIRST_NAME,
                      CASE_PERSON_INFO.MIDDLE_NAME, CASE_PERSON_INFO.SUFFIX_NAME, CASE_PERSON_INFO.SEX, CASE_PERSON_INFO.RACE,
                      CONVERT(VARCHAR, CASE_PERSON_INFO.DOB, 101) AS DOB, CASE_PERSON_INFO.UPDATE_DATE, CASE_PERSON_ADDRESS.ADDRESS_TYPE,
                      CASE_PERSON_ADDRESS.ADDRESS, CASE_PERSON_ADDRESS.UNIT, CASE_PERSON_ADDRESS.SUFFIX, CASE_PERSON_ADDRESS.CITY,
                      CASE_PERSON_ADDRESS.STATE, CASE_PERSON_ADDRESS.ZIPCODE, CASE_PERSON_ADDRESS.COUNTY,
                      CASE_PERSON_ADDRESS.MAIL_INDICATOR, CASE_PERSON_ADDRESS.UPDATE_DATE AS ADDRESS_UPDATE_DATE,
                      CASE_PERSON_ADDRESS.ADDRESS_NBR, CASE_PERSON_PHONE.PHONE_TYPE, CASE_PERSON_PHONE.AREA_CODE,
                      CASE_PERSON_PHONE.PHONE, CASE_PERSON_PHONE.PHONE_EXT, CASE_PERSON_PHONE.UPDATE_DATE AS PHONE_UPDATE_DATE,
                      CASE_PERSON_PHONE.REMARK AS PHONE_REMARK, CASE_PERSON_ADDRESS.REMARK AS ADDRESS_REMARK,
                      CASE_PERSON.COURT_NBR AS COURT_CASE_NBR, CASE_MAIN.CASE_NBR AS DA_CASE_NBR, CASE_MAIN.FIRST_ADVOCATE_CODE,
                      CASE_MAIN.SEC_ADVOCATE_CODE, CASE_PERSON_ADDRESS.EMAIL, CASE_PERSON_ADDRESS.CONFIDENTIAL_INDICATOR,
                      ISSUED_CASES_PRIMARY_CHARGE.court_nbr AS issued_case_court_nbr
FROM         CFA_TOM_VRN LEFT OUTER JOIN
                      ISSUED_CASES_PRIMARY_CHARGE ON CFA_TOM_VRN.CASE_ID_NBR = ISSUED_CASES_PRIMARY_CHARGE.case_id_nbr LEFT OUTER JOIN
                      CASE_MAIN ON CFA_TOM_VRN.CASE_ID_NBR = CASE_MAIN.CASE_ID_NBR LEFT OUTER JOIN
                      CASE_PERSON ON CFA_TOM_VRN.CASE_ID_NBR = CASE_PERSON.CASE_ID_NBR AND
                      CFA_TOM_VRN.PERSON_ID_NBR = CASE_PERSON.PERSON_ID_NBR LEFT OUTER JOIN
                      CASE_PERSON_PHONE ON CFA_TOM_VRN.PERSON_ID_NBR = CASE_PERSON_PHONE.PERSON_ID_NBR AND
                      CASE_PERSON_PHONE.DEFAULT_PHONE = 'T' LEFT OUTER JOIN
                      CASE_PERSON_ADDRESS ON CFA_TOM_VRN.PERSON_ID_NBR = CASE_PERSON_ADDRESS.PERSON_ID_NBR AND
                      (CASE_PERSON_ADDRESS.ALL_DOCS = 'T' AND CASE_PERSON_ADDRESS.SUB_ONLY = 'T' OR
                      CASE_PERSON_ADDRESS.ALL_DOCS IS NULL AND CASE_PERSON_ADDRESS.SUB_ONLY IS NULL) LEFT OUTER JOIN
                      CASE_PERSON_INFO ON CFA_TOM_VRN.PERSON_ID_NBR = CASE_PERSON_INFO.PERSON_ID_NBR
