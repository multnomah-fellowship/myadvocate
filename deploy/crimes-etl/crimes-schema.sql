DROP TABLE IF EXISTS advocates;
CREATE TABLE advocates (
    crimes_id character varying(9) NOT NULL,
    last_name character varying(14),
    first_name character varying(9),
    email character varying(31),
    phone_1 character varying(14),
    phone_2 character varying(14)
);

DROP TABLE IF EXISTS victims;
CREATE TABLE victims (
    case_id_nbr numeric NOT NULL,
    person_id_nbr numeric NOT NULL,
    last_name character varying(200) NOT NULL,
    first_name character varying(11),
    middle_name character varying(16),
    suffix_name character varying(3),
    sex character varying(6),
    race character varying(2),
    dob date,
    update_date timestamp without time zone,
    address_type character varying(6) NOT NULL,
    address character varying(22),
    unit character varying(5),
    suffix character varying(4),
    city character varying(14),
    state character varying(2),
    zipcode numeric,
    county boolean,
    mail_indicator boolean NOT NULL,
    address_update_date timestamp without time zone,
    address_nbr numeric,
    phone_type character varying(6) NOT NULL,
    area_code numeric NOT NULL,
    phone numeric NOT NULL,
    phone_ext character varying(4),
    phone_update_date timestamp without time zone,
    phone_remark character varying(51),
    address_remark character varying(86),
    court_case_nbr character varying(9),
    da_case_nbr numeric NOT NULL,
    first_advocate_code character varying(9),
    sec_advocate_code character varying(7),
    email character varying(50),
    confidential_indicator boolean NOT NULL,
    issued_case_court_nbr character varying(9)
);

DROP TABLE IF EXISTS vrns;
CREATE TABLE vrns (
    case_id_nbr numeric NOT NULL,
    person_id_nbr numeric NOT NULL,
    result_desc character varying(34) NOT NULL,
    flag_desc character varying(63) NOT NULL
);
