-- Create a TMP table of the victim's latest addresses
SELECT CASE_PERSON_ADDRESS.CASE_PERSON_ADDRESS_ID_NBR, CASE_PERSON_ADDRESS.PERSON_ID_NBR
INTO CFA_TOM_VICTIM_LATEST_ADDRESS
FROM CASE_PERSON_ADDRESS
INNER JOIN (
SELECT CASE_PERSON_ADDRESS.PERSON_ID_NBR, MAX(UPDATE_DATE) AS UPDATE_DATE FROM CASE_PERSON_ADDRESS
INNER JOIN (
  SELECT PERSON_ID_NBR FROM CFA_TOM_VRN
  UNION
  SELECT VICTIM_PERSON_ID_NBR AS PERSON_ID_NBR FROM CFA_TOM_RESTITUTION
  UNION
  SELECT PERSON_ID_NBR FROM CASE_PERSON
  INNER JOIN CFA_TOM_PROBATION ON CFA_TOM_PROBATION.CASE_ID_NBR = CASE_PERSON.CASE_ID_NBR
  AND CASE_PERSON.CASE_PERSON_TYPE IN ('VIC/WIT', 'VICTIM')
) VICTIMS ON VICTIMS.PERSON_ID_NBR = CASE_PERSON_ADDRESS.PERSON_ID_NBR
GROUP BY CASE_PERSON_ADDRESS.PERSON_ID_NBR
) LATEST_ADDRESS ON CASE_PERSON_ADDRESS.PERSON_ID_NBR = LATEST_ADDRESS.PERSON_ID_NBR AND CASE_PERSON_ADDRESS.UPDATE_DATE = LATEST_ADDRESS.UPDATE_DATE;

-- Find all victim info for the probation/VRN/restitution:
SELECT     CASE_PERSON.CASE_ID_NBR, CASE_PERSON.PERSON_ID_NBR, CASE_PERSON.CASE_PERSON_TYPE, CASE_PERSON_INFO.LAST_NAME,
                      CASE_PERSON_INFO.FIRST_NAME, CASE_PERSON_INFO.MIDDLE_NAME, CASE_PERSON_ADDRESS.ADDRESS_NBR,
                      CASE_PERSON_ADDRESS.PREFIX, CASE_PERSON_ADDRESS.ADDRESS, CASE_PERSON_ADDRESS.SUFFIX, CASE_PERSON_ADDRESS.UNIT,
                      CASE_PERSON_ADDRESS.CITY, CASE_PERSON_ADDRESS.STATE, CASE_PERSON_ADDRESS.ZIPCODE, CASE_PERSON_PHONE.AREA_CODE,
                      CASE_PERSON_PHONE.PHONE, CASE_PERSON_PHONE.PHONE_EXT, CASE_PERSON_ADDRESS.EMAIL, CASE_FLAG.FLAG_TYPE AS FLAG_B,
                      CASE_PERSON_INFO.SEX
INTO CFA_TOM_VICTIM_INFO
FROM         CASE_PERSON_ADDRESS INNER JOIN
                      CFA_TOM_VICTIM_LATEST_ADDRESS ON
                      CASE_PERSON_ADDRESS.CASE_PERSON_ADDRESS_ID_NBR = CFA_TOM_VICTIM_LATEST_ADDRESS.CASE_PERSON_ADDRESS_ID_NBR AND
                      CASE_PERSON_ADDRESS.PERSON_ID_NBR = CFA_TOM_VICTIM_LATEST_ADDRESS.PERSON_ID_NBR RIGHT OUTER JOIN
                      CASE_PERSON INNER JOIN
                          (SELECT     CASE_ID_NBR
                            FROM          CFA_TOM_VRN
                            UNION
                            SELECT     CASE_ID_NBR
                            FROM         CFA_TOM_PROBATION
                            UNION
                            SELECT     CASE_ID_NBR
                            FROM         CFA_TOM_RESTITUTION) AS CASES ON CASES.CASE_ID_NBR = CASE_PERSON.CASE_ID_NBR LEFT OUTER JOIN
                      CASE_FLAG ON CASE_PERSON.PERSON_ID_NBR = CASE_FLAG.PERSON_ID_NBR AND
                      CASE_PERSON.CASE_ID_NBR = CASE_FLAG.CASE_ID_NBR AND CASE_FLAG.FLAG_TYPE = 'VICR2' RIGHT OUTER JOIN
                      CASE_PERSON_INFO ON CASE_PERSON.PERSON_ID_NBR = CASE_PERSON_INFO.PERSON_ID_NBR ON
                      CASE_PERSON_ADDRESS.PERSON_ID_NBR = CASE_PERSON_INFO.PERSON_ID_NBR AND CASE_PERSON_ADDRESS.SUB_ONLY = 'T' AND
                      CASE_PERSON_ADDRESS.ALL_DOCS = 'T' LEFT OUTER JOIN
                      CASE_PERSON_PHONE ON CASE_PERSON_INFO.PERSON_ID_NBR = CASE_PERSON_PHONE.PERSON_ID_NBR AND
                      CASE_PERSON_PHONE.DEFAULT_PHONE = 'T'
WHERE     (CASE_PERSON.CASE_PERSON_TYPE IN ('VIC/WIT', 'VICTIM'))