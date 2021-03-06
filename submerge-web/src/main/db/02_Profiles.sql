
CREATE SEQUENCE public.s_subtitle_profile_id;

CREATE TABLE public.SUBTITLE_PROFILE (
                ID INTEGER NOT NULL DEFAULT nextval('public.s_subtitle_profile_id'),
                PRIMARY_COLOR VARCHAR(7) NOT NULL,
                OUTLINE_COLOR VARCHAR(7) NOT NULL,
                OUTLINE_WIDTH INTEGER NOT NULL,
                FONT_NAME VARCHAR(20) NOT NULL,
                FONT_SIZE INTEGER NOT NULL,
                CONSTRAINT pk_profile PRIMARY KEY (ID)
);
COMMENT ON COLUMN public.SUBTITLE_PROFILE.ID IS 'Primary Key';
COMMENT ON COLUMN public.SUBTITLE_PROFILE.PRIMARY_COLOR IS 'Subtitle color';
COMMENT ON COLUMN public.SUBTITLE_PROFILE.OUTLINE_COLOR IS 'Subtitle outline color';
COMMENT ON COLUMN public.SUBTITLE_PROFILE.OUTLINE_WIDTH IS 'Subtitle outline width';
COMMENT ON COLUMN public.SUBTITLE_PROFILE.FONT_NAME IS 'Font name';
COMMENT ON COLUMN public.SUBTITLE_PROFILE.FONT_SIZE IS 'Font size';


ALTER SEQUENCE public.s_subtitle_profile_id OWNED BY public.SUBTITLE_PROFILE.ID;


CREATE SEQUENCE public.s_dual_subtitle_config_id;

CREATE TABLE public.DUAL_SUBTITLE_CONFIG (
                ID INTEGER NOT NULL DEFAULT nextval('public.s_dual_subtitle_config_id'),
                FK_ID_ACCOUNT INTEGER NOT NULL,
                NAME VARCHAR(20),
                CURRENT BOOLEAN NOT NULL,
                FK_ID_PROFILE_ONE INTEGER NOT NULL,
                FK_ID_PROFILE_TWO INTEGER NOT NULL,
                FILENAME VARCHAR(70),
                CONSTRAINT pk_dual_subtitle_config PRIMARY KEY (ID)
);
COMMENT ON COLUMN public.DUAL_SUBTITLE_CONFIG.ID IS 'Primary key';
COMMENT ON COLUMN public.DUAL_SUBTITLE_CONFIG.FK_ID_ACCOUNT IS 'Config owner';
COMMENT ON COLUMN public.DUAL_SUBTITLE_CONFIG.NAME IS 'Profile name';
COMMENT ON COLUMN public.DUAL_SUBTITLE_CONFIG.CURRENT IS 'Defines if the config is used to save the current state';
COMMENT ON COLUMN public.DUAL_SUBTITLE_CONFIG.FK_ID_PROFILE_ONE IS 'Foreign key';
COMMENT ON COLUMN public.DUAL_SUBTITLE_CONFIG.FK_ID_PROFILE_TWO IS 'Foreign Key';
COMMENT ON COLUMN public.DUAL_SUBTITLE_CONFIG.FILENAME IS 'Filename';


ALTER SEQUENCE public.s_dual_subtitle_config_id OWNED BY public.DUAL_SUBTITLE_CONFIG.ID;


ALTER TABLE public.DUAL_SUBTITLE_CONFIG ADD CONSTRAINT subtitle_profile_dual_one_fk
FOREIGN KEY (FK_ID_PROFILE_ONE)
REFERENCES public.SUBTITLE_PROFILE (ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.DUAL_SUBTITLE_CONFIG ADD CONSTRAINT subtitle_profile_dual_two_fk
FOREIGN KEY (FK_ID_PROFILE_TWO)
REFERENCES public.SUBTITLE_PROFILE (ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.DUAL_SUBTITLE_CONFIG ADD CONSTRAINT account_dual_subtitle_config_fk
FOREIGN KEY (FK_ID_ACCOUNT)
REFERENCES public.ACCOUNT (ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

alter table dual_subtitle_config alter column filename TYPE VARCHAR(300); 

alter table SUBTITLE_PROFILE add column language VARCHAR(5);

alter table account add column fk_profile_default INTEGER;
ALTER TABLE account ADD FOREIGN KEY (fk_profile_default) REFERENCES subtitle_profile;

alter table SUBTITLE_PROFILE add column alignment INTEGER NULL;
alter table SUBTITLE_PROFILE add column alignment_offset INTEGER NULL;

alter table dual_subtitle_config add column avoid_switch BOOLEAN NOT NULL DEFAULT true;
alter table dual_subtitle_config add column clean BOOLEAN NOT NULL DEFAULT true;
alter table dual_subtitle_config add column adjust_timecodes BOOLEAN NOT NULL DEFAULT false;
alter table dual_subtitle_config add column one_line BOOLEAN NOT NULL DEFAULT false;