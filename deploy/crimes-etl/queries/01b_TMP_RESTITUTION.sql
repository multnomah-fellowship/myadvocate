-- Find all recently-updated restitution sentences.
SELECT     RESTITUTION_RECIPIENT.CASE_ID_NBR, RESTITUTION_RECIPIENT.PERSON_ID_NBR AS VICTIM_PERSON_ID_NBR,
                      CHARGE_SENTENCE.PERSON_ID_NBR AS OFFENDER_PERSON_ID_NBR, SENTENCE_RESTITUTION.AMOUNT,
                      SENTENCE_RESTITUTION.RESTITUTION_TYPE, SENTENCE_RESTITUTION.CREATE_DATE
INTO            CFA_TOM_RESTITUTION
FROM         SENTENCE_RESTITUTION INNER JOIN
                      RESTITUTION_RECIPIENT ON SENTENCE_RESTITUTION.RECIPIENT_ID_NBR = RESTITUTION_RECIPIENT.RECIPIENT_ID_NBR INNER JOIN
                      CHARGE_SENTENCE ON SENTENCE_RESTITUTION.SENTENCE_ID_NBR = CHARGE_SENTENCE.SENTENCE_ID_NBR INNER JOIN
                      CASE_CHARGE ON CHARGE_SENTENCE.CHARGE_ID_NBR = CASE_CHARGE.CHARGE_ID_NBR
WHERE     (SENTENCE_RESTITUTION.AMOUNT IS NOT NULL) AND (SENTENCE_RESTITUTION.CREATE_DATE BETWEEN DATEADD(month, - 2, GETDATE()) AND
                      GETDATE()) AND (CASE_CHARGE.CHARGE_STATE = 'CONVICTED')
