-- Exported from MS Access to PostgreSQL
-- (C) 1997-98 CYNERGI - www.cynergi.net, info@cynergi.net

CREATE TABLE AAA_REQ_HAUTEUR_CRETE_TN_DRAC
     (
     ID_TRONCON_GESTION                                                int8,
     NOM_TRONCON_GESTION                                               varchar(255),
     NOM                                                               varchar(255),
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     CRETE_Z_NGF                                                       float8,
     COTE_TERRE_Z_NGF_PIED_DE_DIGUE                                    float8,
     HAUTEUR_DIGUE_COTE_TERRE                                          float8,
     X                                                                 float8,
     Y                                                                 float8
     );


CREATE TABLE AAA_REQ_Vero_charge_isere_Q10
     (
     Numéro                                                             serial,
     ID_TRONCON_GESTION                                                int8,
     NOM_TRONCON_GESTION                                               varchar(255),
     NOM                                                               varchar(255),
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     CRETE_Z_NGF                                                       float8,
     COTE_TERRE_Z_NGF_PIE                                              float8,
     HAUTEUR_DIGUE_COTE_T                                              float8,
     COTE_EAU_NGF                                                      float8,
     charge                                                            float8,
     NOM_EVENEMENT_HYDRAU                                              varchar(255),
     ID_EVENEMENT_HYDRAU                                               int8,
     PRIMARY KEY (Numéro)
     );


CREATE TABLE AAA_REQ_Vero_charge_isere_Q5
     (
     Numéro                                                             serial,
     ID_TRONCON_GESTION                                                int8,
     NOM_TRONCON_GESTION                                               varchar(255),
     NOM                                                               varchar(255),
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     CRETE_Z_NGF                                                       float8,
     COTE_TERRE_Z_NGF_PIE                                              float8,
     HAUTEUR_DIGUE_COTE_T                                              float8,
     COTE_EAU_NGF                                                      float8,
     charge                                                            float8,
     NOM_EVENEMENT_HYDRAU                                              varchar(255),
     ID_EVENEMENT_HYDRAU                                               int8,
     PRIMARY KEY (Numéro)
     );


CREATE TABLE AAAreqveroPanneauAD
     (
     Numéro                                                             serial,
     ID_TRONCON_GESTION                                                int8,
     NOM                                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     PRIMARY KEY (Numéro)
     );


CREATE TABLE BORNE_DIGUE
     (
     ID_BORNE                                                           serial,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     NOM_BORNE                                                         varchar(255),
     X_POINT                                                           float8,
     Y_POINT                                                           float8,
     Z_POINT                                                           float8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     COMMENTAIRE_BORNE                                                 text,
     FICTIVE                                                           bool,
     X_POINT_ORIGINE                                                   float8,
     Y_POINT_ORIGINE                                                   float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     UNIQUE (ID_BORNE),
     PRIMARY KEY (ID_BORNE)
     );


CREATE TABLE BORNE_PAR_SYSTEME_REP
     (
     ID_BORNE                                                          int8 NOT NULL,
     ID_SYSTEME_REP                                                    int8 NOT NULL,
     VALEUR_PR                                                         float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_BORNE, ID_SYSTEME_REP)
     );


CREATE TABLE COMMUNE
     (
     ID_COMMUNE                                                         serial,
     CODE_INSEE_COMMUNE                                                varchar(6),
     LIBELLE_COMMUNE                                                   varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_COMMUNE)
     );


CREATE TABLE CONVENTION
     (
     ID_CONVENTION                                                      serial,
     LIBELLE_CONVENTION                                                varchar(255),
     ID_TYPE_CONVENTION                                                int8,
     DATE_DEBUT_CONVENTION                                             timestamp,
     DATE_FIN_CONVENTION                                               timestamp,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     COMMENTAIRE                                                       text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_CONVENTION)
     );


CREATE TABLE CONVENTION_SIGNATAIRES_PM
     (
     ID_CONVENTION                                                     int8 NOT NULL,
     ID_ORG_SIGNATAIRE                                                 int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_CONVENTION, ID_ORG_SIGNATAIRE)
     );


CREATE TABLE CONVENTION_SIGNATAIRES_PP
     (
     ID_CONVENTION                                                     int8 NOT NULL,
     ID_INTERV_SIGNATAIRE                                              int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_CONVENTION, ID_INTERV_SIGNATAIRE)
     );


CREATE TABLE DEPARTEMENT
     (
     ID_DEPARTEMENT                                                     serial,
     CODE_INSEE_DEPARTEMENT                                            varchar(4),
     LIBELLE_DEPARTEMENT                                               varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_DEPARTEMENT)
     );


CREATE TABLE DESORDRE
     (
     ID_DESORDRE                                                        serial,
     ID_TYPE_DESORDRE                                                  int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     LIEU_DIT_DESORDRE                                                 varchar(255),
     ID_TYPE_POSITION                                                  int8,
     ID_PRESTATION                                                     int8,
     ID_CRUE                                                           timestamp,
     DESCRIPTION_DESORDRE                                              text,
     DISPARU                                                           bool,
     DEJA_OBSERVE                                                      bool,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_DESORDRE)
     );


CREATE TABLE DESORDRE_ELEMENT_RESEAU
     (
     ID_DESORDRE                                                       int8,
     ID_ELEMENT_RESEAU                                                 int8,
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_DESORDRE, ID_ELEMENT_RESEAU)
     );


CREATE TABLE DESORDRE_ELEMENT_STRUCTURE
     (
     ID_DESORDRE                                                       int8,
     ID_ELEMENT_STRUCTURE                                              int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_DESORDRE, ID_ELEMENT_STRUCTURE)
     );


CREATE TABLE DESORDRE_EVENEMENT_HYDRAU
     (
     ID_DESORDRE                                                       int8,
     ID_EVENEMENT_HYDRAU                                               int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_DESORDRE, ID_EVENEMENT_HYDRAU)
     );


CREATE TABLE DESORDRE_JOURNAL
     (
     ID_ARTICLE_JOURNAL                                                int8 NOT NULL,
     ID_DESORDRE                                                       int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ARTICLE_JOURNAL, ID_DESORDRE)
     );


CREATE TABLE DESORDRE_OBSERVATION
     (
     ID_OBSERVATION                                                     serial,
     ID_DESORDRE                                                       int8 NOT NULL,
     ID_TYPE_URGENCE                                                   int8,
     ID_INTERV_OBSERVATEUR                                             int8,
     DATE_OBSERVATION_DESORDRE                                         timestamp,
     SUITE_A_APPORTER                                                  text,
     EVOLUTIONS                                                        varchar(255),
     NBR_DESORDRE                                                      int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_OBSERVATION)
     );


CREATE TABLE DESORDRE_PRESTATION
     (
     ID_DESORDRE                                                       int8,
     ID_PRESTATION                                                     int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_DESORDRE, ID_PRESTATION)
     );


CREATE TABLE DIGUE
     (
     ID_DIGUE                                                           serial,
     LIBELLE_DIGUE                                                     varchar(255),
     COMMENTAIRE_DIGUE                                                 text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_DIGUE)
     );


CREATE TABLE DOCUMENT
     (
     ID_DOC                                                             serial,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     NOM                                                               varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_PROFIL_EN_LONG                                                 int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     AUTEUR_RAPPORT                                                    varchar(255),
     ID_RAPPORT_ETUDE                                                  int8,
     PRIMARY KEY (ID_DOC)
     );


CREATE TABLE ECOULEMENT
     (
     ID_ECOULEMENT                                                     int8 NOT NULL,
     LIBELLE_ECOULEMENT                                                varchar(255),
     ABREGE_ECOULEMENT                                                 varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ECOULEMENT)
     );


CREATE TABLE ELEMENT_GEOMETRIE
     (
     ID_ELEMENT_GEOMETRIE                                               serial,
     ID_TYPE_ELEMENT_GEOMETRIE                                         int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     ID_TYPE_LARGEUR_FB                                                int8,
     ID_TYPE_PROFIL_FB                                                 int8,
     ID_TYPE_DIST_DIGUE_BERGE                                          int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_GEOMETRIE)
     );


CREATE TABLE ELEMENT_RESEAU
     (
     ID_ELEMENT_RESEAU                                                  serial,
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     NOM                                                               varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     N_SECTEUR                                                         varchar(255),
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     ID_TYPE_POSITION                                                  int8,
     ID_TYPE_POSITION_HAUTE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_OUVRAGE_TELECOM_NRJ                                       int8,
     ID_TYPE_ORIENTATION_OUVRAGE_FRANCHISSEMENT                        int8,
     ID_TYPE_OUVRAGE_FRANCHISSEMENT                                    int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     Z_SEUIL                                                           float8,
     ID_TYPE_SEUIL                                                     int8,
     ID_TYPE_GLISSIERE                                                 int8,
     ID_TYPE_NATURE_BATARDEAUX                                         int8,
     NOMBRE                                                            int8,
     POIDS                                                             float8,
     ID_TYPE_MOYEN_MANIP_BATARDEAUX                                    int8,
     ID_ORG_STOCKAGE_BATARDEAUX                                        int8,
     ID_ORG_MANIP_BATARDEAUX                                           int8,
     ID_INTERV_MANIP_BATARDEAUX                                        int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_NATURE_BAS                                                int8,
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     ID_TYPE_REVETEMENT_BAS                                            int8,
     PRIMARY KEY (ID_ELEMENT_RESEAU)
     );


CREATE TABLE ELEMENT_RESEAU_AUTRE_OUVRAGE_HYDRAU
     (
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     ID_ELEMENT_RESEAU_AUTRE_OUVRAGE_HYDRAU                            int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ELEMENT_RESEAU_AUTRE_OUVRAGE_HYDRAU)
     );


CREATE TABLE ELEMENT_RESEAU_CHEMIN_ACCES
     (
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     ID_ELEMENT_RESEAU_CHEMIN_ACCES                                    int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ELEMENT_RESEAU_CHEMIN_ACCES)
     );


CREATE TABLE ELEMENT_RESEAU_CONDUITE_FERMEE
     (
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     ID_ELEMENT_RESEAU_CONDUITE_FERMEE                                 int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ELEMENT_RESEAU_CONDUITE_FERMEE)
     );


CREATE TABLE ELEMENT_RESEAU_CONVENTION
     (
     ID_ELEMENT_RESEAU                                                 int8,
     ID_CONVENTION                                                     int8,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_CONVENTION)
     );


CREATE TABLE ELEMENT_RESEAU_EVENEMENT_HYDRAU
     (
     ID_ELEMENT_RESEAU                                                 int8,
     ID_EVENEMENT_HYDRAU                                               int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_EVENEMENT_HYDRAU)
     );


CREATE TABLE ELEMENT_RESEAU_GARDIEN
     (
     ID_ELEMENT_RESEAU                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_INTERV_GARDIEN, DATE_DEBUT_GARDIEN)
     );


CREATE TABLE ELEMENT_RESEAU_GESTIONNAIRE
     (
     ID_ELEMENT_RESEAU                                                 int8,
     ID_ORG_GESTION                                                    int8,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ORG_GESTION, DATE_DEBUT_GESTION)
     );


CREATE TABLE ELEMENT_RESEAU_OUVERTURE_BATARDABLE
     (
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     ID_ELEMENT_RESEAU_OUVERTURE_BATARDABLE                            int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ELEMENT_RESEAU_OUVERTURE_BATARDABLE)
     );


CREATE TABLE ELEMENT_RESEAU_OUVRAGE_TEL_NRJ
     (
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     ID_ELEMENT_RESEAU_OUVRAGE_TEL_NRJ                                 int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ELEMENT_RESEAU_OUVRAGE_TEL_NRJ)
     );


CREATE TABLE ELEMENT_RESEAU_OUVRAGE_VOIRIE
     (
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     ID_ELEMENT_RESEAU_OUVRAGE_VOIRIE                                  int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ELEMENT_RESEAU_OUVRAGE_VOIRIE)
     );


CREATE TABLE ELEMENT_RESEAU_OUVRAGE_VOIRIE_POINT_ACCES
     (
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     ID_ELEMENT_RESEAU_OUVRAGE_VOIRIE                                  int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ELEMENT_RESEAU_OUVRAGE_VOIRIE)
     );


CREATE TABLE ELEMENT_RESEAU_POINT_ACCES
     (
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     ID_ELEMENT_RESEAU_POINT_ACCES                                     int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ELEMENT_RESEAU_POINT_ACCES)
     );


CREATE TABLE ELEMENT_RESEAU_POMPE
     (
     ID_POMPE                                                           serial,
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     NOM_POMPE                                                         varchar(255),
     PUISSANCE_POMPE                                                   float8,
     DEBIT_POMPE                                                       float8,
     HAUTEUR_REFOUL                                                    float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_POMPE)
     );


CREATE TABLE ELEMENT_RESEAU_PROPRIETAIRE
     (
     ID_ELEMENT_RESEAU                                                 int8,
     DATE_DEBUT_PROPRIO                                                timestamp,
     DATE_FIN_PROPRIO                                                  timestamp,
     ID_ORG_PROPRIO                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, DATE_DEBUT_PROPRIO)
     );


CREATE TABLE ELEMENT_RESEAU_RESEAU_EAU
     (
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     ID_ELEMENT_RESEAU_RESEAU_EAU                                      int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     GESTION_SYNCHRO                                                   text,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ELEMENT_RESEAU_RESEAU_EAU)
     );


CREATE TABLE ELEMENT_RESEAU_SERVITUDE
     (
     ID_ELEMENT_RESEAU                                                 int8,
     ID_PARCELLE                                                       int8 NOT NULL,
     ID_TYPE_SERVITUDE                                                 int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_PARCELLE, ID_TYPE_SERVITUDE)
     );


CREATE TABLE ELEMENT_RESEAU_STRUCTURE
     (
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     ID_ELEMENT_STRUCTURE                                              int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ELEMENT_STRUCTURE)
     );


CREATE TABLE ELEMENT_RESEAU_VOIE_SUR_DIGUE
     (
     ID_ELEMENT_RESEAU                                                 int8 NOT NULL,
     ID_ELEMENT_RESEAU_VOIE_SUR_DIGUE                                  int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_RESEAU, ID_ELEMENT_RESEAU_VOIE_SUR_DIGUE)
     );


CREATE TABLE ELEMENT_STRUCTURE
     (
     ID_ELEMENT_STRUCTURE                                               serial,
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8 DEFAULT 1,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_TYPE_VEGETATION_ESSENCE_1                                      int8,
     ID_TYPE_VEGETATION_ESSENCE_2                                      int8,
     ID_TYPE_VEGETATION_ESSENCE_3                                      int8,
     ID_TYPE_VEGETATION_ESSENCE_4                                      int8,
     NUMERO_PARCELLE                                                   int8,
     DISTANCE_AXE_M                                                    float8,
     PENTE_PCT                                                         float8,
     ID_CONTACT_EAU_ON                                                 int8,
     NUMERO_FORMATION_VEGETALE                                         int8,
     RECOUVREMENT_STRATE_1                                             float8,
     RECOUVREMENT_STRATE_2                                             float8,
     RECOUVREMENT_STRATE_3                                             float8,
     RECOUVREMENT_STRATE_4                                             float8,
     RECOUVREMENT_STRATE_5                                             float8,
     ID_TYPE_VEGETATION_ABONDANCE                                      int8,
     ID_TYPE_VEGETATION_STRATE_DIAMETRE                                int8,
     ID_TYPE_VEGETATION_STRATE_HAUTEUR                                 int8,
     DENSITE_STRATE_DOMINANTE                                          float8,
     ID_TYPE_VEGETATION_ETAT_SANITAIRE                                 int8,
     ID_ABONDANCE_BRAUN_BLANQUET_RENOUE                                int8,
     ID_ABONDANCE_BRAUN_BLANQUET_BUDLEIA                               int8,
     ID_ABONDANCE_BRAUN_BLANQUET_SOLIDAGE                              int8,
     ID_ABONDANCE_BRAUN_BLANQUET_VIGNE_VIERGE                          int8,
     ID_ABONDANCE_BRAUN_BLANQUET_S_YEBLE                               int8,
     ID_ABONDANCE_BRAUN_BLANQUET_E_NEGUN                               int8,
     ID_ABONDANCE_BRAUN_BLANQUET_IMPA_GLANDUL                          int8,
     ID_ABONDANCE_BRAUN_BLANQUET_GLOBAL                                int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     LARGEUR                                                           float8,
     PRIMARY KEY (ID_ELEMENT_STRUCTURE)
     );


CREATE TABLE ELEMENT_STRUCTURE_ABONDANCE_ESSENCE
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     ID_TYPE_VEGETATION_ESSENCE                                        int8,
     PRIMARY KEY (ID_ELEMENT_STRUCTURE, ID_TYPE_VEGETATION_ESSENCE)
     );


CREATE TABLE ELEMENT_STRUCTURE_GARDIEN
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_STRUCTURE, ID_INTERV_GARDIEN, DATE_DEBUT_GARDIEN)
     );


CREATE TABLE ELEMENT_STRUCTURE_GESTIONNAIRE
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     ID_ORG_GESTION                                                    int8,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_STRUCTURE, ID_ORG_GESTION, DATE_DEBUT_GESTION)
     );


CREATE TABLE ELEMENT_STRUCTURE_PROPRIETAIRE
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     DATE_DEBUT_PROPRIO                                                timestamp,
     DATE_FIN_PROPRIO                                                  timestamp,
     ID_ORG_PROPRIO                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ELEMENT_STRUCTURE, DATE_DEBUT_PROPRIO)
     );


CREATE TABLE EVENEMENT_HYDRAU
     (
     ID_EVENEMENT_HYDRAU                                                serial,
     NOM_EVENEMENT_HYDRAU                                              varchar(255),
     ID_TYPE_EVENEMENT_HYDRAU                                          int8,
     ID_TYPE_FREQUENCE_EVENEMENT_HYDRAU                                int8,
     VITESSE_MOYENNE                                                   float8,
     DEBIT_MOYEN                                                       float8,
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     COMMENTAIRE                                                       text,
     NOM_MODELEUR_HYDRAU                                               varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_EVENEMENT_HYDRAU)
     );


CREATE TABLE Export_Output
     (
     OBJECTID                                                           serial,
     SHAPE                                                             text,
     OBJECTID_old                                                      int8,
     SHAPE_Leng                                                        float8,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     LONGUEUR                                                          float8,
     SHAPE_Length                                                      float8,
     UNIQUE (OBJECTID)
     );


CREATE TABLE Export_Output_SHAPE_Index
     (
     IndexedObjectId                                                   int8 NOT NULL,
     MinGX                                                             int8 NOT NULL,
     MinGY                                                             int8 NOT NULL,
     MaxGX                                                             int8 NOT NULL,
     MaxGY                                                             int8 NOT NULL
     );


CREATE TABLE GARDIEN_TRONCON_GESTION
     (
     ID_GARDIEN_TRONCON_GESTION                                         serial,
     ID_INTERVENANT                                                    int8 NOT NULL,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_DEBUT                                                           float8,
     Y_FIN                                                             float8,
     ID_BORNEREF_DEBUT                                                 float8,
     ID_BORNEREF_FIN                                                   float8,
     ID_SYSTEME_REP                                                    int8,
     DIST_BORNEREF_DEBUT                                               float8,
     DIST_BORNEREF_FIN                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     AMONT_AVAL_FIN                                                    bool,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_GARDIEN_TRONCON_GESTION)
     );


CREATE TABLE GDB_AnnoSymbols
     (
     ID                                                                 serial,
     Symbol                                                            text,
     UNIQUE (ID)
     );


CREATE TABLE GDB_AttrRules
     (
     RuleID                                                            int8 NOT NULL,
     Subtype                                                           int8 NOT NULL,
     FieldName                                                         varchar(255) NOT NULL,
     DomainName                                                        varchar(255) NOT NULL,
     UNIQUE (RuleID)
     );


CREATE TABLE GDB_CodedDomains
     (
     DomainID                                                          int8 NOT NULL,
     CodedValues                                                       text NOT NULL,
     UNIQUE (DomainID)
     );


CREATE TABLE GDB_DatabaseLocks
     (
     LockID                                                             serial,
     LockType                                                          int8 NOT NULL,
     UserName                                                          text NOT NULL,
     MachineName                                                       text NOT NULL
     );


CREATE TABLE GDB_DefaultValues
     (
     ClassID                                                           int8 NOT NULL,
     FieldName                                                         varchar(255) NOT NULL,
     Subtype                                                           int8 NOT NULL,
     DefaultNumber                                                     float8,
     DefaultString                                                     varchar(255)
     );


CREATE TABLE GDB_Domains
     (
     ID                                                                 serial,
     Owner                                                             varchar(255),
     DomainName                                                        varchar(255) NOT NULL,
     DomainType                                                        int8 NOT NULL,
     Description                                                       varchar(255),
     FieldType                                                         int8 NOT NULL,
     MergePolicy                                                       int8 NOT NULL,
     SplitPolicy                                                       int8 NOT NULL,
     UNIQUE (DomainName, Owner),
     UNIQUE (ID)
     );


CREATE TABLE GDB_EdgeConnRules
     (
     RuleID                                                            int8 NOT NULL,
     FromClassID                                                       int8 NOT NULL,
     FromSubtype                                                       int8 NOT NULL,
     ToClassID                                                         int8 NOT NULL,
     ToSubtype                                                         int8 NOT NULL,
     Junctions                                                         text NOT NULL,
     UNIQUE (RuleID)
     );


CREATE TABLE GDB_Extensions
     (
     ID                                                                 serial,
     Name                                                              varchar(255) NOT NULL,
     CLSID                                                             varchar(255) NOT NULL,
     UNIQUE (CLSID),
     UNIQUE (Name),
     UNIQUE (ID)
     );


CREATE TABLE GDB_FeatureClasses
     (
     ObjectClassID                                                     int8 NOT NULL,
     FeatureType                                                       int8 NOT NULL,
     GeometryType                                                      int8 NOT NULL,
     ShapeField                                                        varchar(255) NOT NULL,
     GeomNetworkID                                                     int8,
     GraphID                                                           int8,
     UNIQUE (ObjectClassID)
     );


CREATE TABLE GDB_FeatureDataset
     (
     ID                                                                 serial,
     DatabaseName                                                      varchar(255),
     Owner                                                             varchar(255),
     Name                                                              varchar(255) NOT NULL,
     SRID                                                              int8 NOT NULL,
     UNIQUE (ID),
     UNIQUE (Name, Owner, DatabaseName)
     );


CREATE TABLE GDB_FieldInfo
     (
     ClassID                                                           int8 NOT NULL,
     FieldName                                                         varchar(255) NOT NULL,
     AliasName                                                         varchar(255),
     ModelName                                                         varchar(255),
     DefaultDomainName                                                 varchar(255),
     DefaultValueString                                                varchar(255),
     DefaultValueNumber                                                float8,
     IsRequired                                                        int8,
     IsSubtypeFixed                                                    int8,
     IsEditable                                                        int8
     );


CREATE TABLE GDB_GeomColumns
     (
     TableName                                                         varchar(255) NOT NULL,
     FieldName                                                         varchar(255) NOT NULL,
     ShapeType                                                         int8 NOT NULL,
     ExtentLeft                                                        float8,
     ExtentBottom                                                      float8,
     ExtentRight                                                       float8,
     ExtentTop                                                         float8,
     IdxOriginX                                                        float8,
     IdxOriginY                                                        float8,
     IdxGridSize                                                       float8,
     SRID                                                              int8 NOT NULL,
     HasZ                                                              bool NOT NULL,
     HasM                                                              bool NOT NULL
     );


CREATE TABLE GDB_JnConnRules
     (
     RuleID                                                            int8 NOT NULL,
     EdgeClassID                                                       int8 NOT NULL,
     EdgeSubtype                                                       int8 NOT NULL,
     JunctionClassID                                                   int8 NOT NULL,
     JunctionSubtype                                                   int8 NOT NULL,
     EdgeMinCard                                                       int8 NOT NULL,
     EdgeMaxCard                                                       int8 NOT NULL,
     JunctionMinCard                                                   int8 NOT NULL,
     JunctionMaxCard                                                   int8 NOT NULL,
     IsDefault                                                         int8,
     UNIQUE (RuleID)
     );


CREATE TABLE GDB_ObjectClasses
     (
     ID                                                                 serial,
     DatabaseName                                                      varchar(255),
     Owner                                                             varchar(255),
     Name                                                              varchar(255) NOT NULL,
     AliasName                                                         varchar(255),
     ModelName                                                         varchar(255),
     CLSID                                                             varchar(255) NOT NULL,
     EXTCLSID                                                          varchar(255),
     EXTPROPS                                                          text,
     DatasetID                                                         int8,
     SubtypeField                                                      varchar(255),
     UNIQUE (ID),
     UNIQUE (Name, Owner, DatabaseName)
     );


CREATE TABLE GDB_RangeDomains
     (
     DomainID                                                          int8 NOT NULL,
     MinValue                                                          float8 NOT NULL,
     MaxValue                                                          float8 NOT NULL,
     UNIQUE (DomainID)
     );


CREATE TABLE GDB_RelClasses
     (
     ID                                                                 serial,
     DatabaseName                                                      varchar(255),
     Owner                                                             varchar(255),
     Name                                                              varchar(255) NOT NULL,
     OriginClassID                                                     int8 NOT NULL,
     DestClassID                                                       int8 NOT NULL,
     ForwardLabel                                                      varchar(255),
     BackwardLabel                                                     varchar(255),
     Cardinality                                                       int8 NOT NULL,
     Notification                                                      int8 NOT NULL,
     IsComposite                                                       int8 NOT NULL,
     IsAttributed                                                      int8 NOT NULL,
     OriginPrimaryKey                                                  varchar(255) NOT NULL,
     DestPrimaryKey                                                    varchar(255) NOT NULL,
     OriginForeignKey                                                  varchar(255) NOT NULL,
     DestForeignKey                                                    varchar(255) NOT NULL,
     DatasetID                                                         int8,
     UNIQUE (ID),
     UNIQUE (Name, Owner, DatabaseName)
     );


CREATE TABLE GDB_ReleaseInfo
     (
     Major                                                             int8 NOT NULL,
     Minor                                                             int8 NOT NULL,
     Bugfix                                                            int8 NOT NULL
     );


CREATE TABLE GDB_RelRules
     (
     RuleID                                                            int8 NOT NULL,
     OriginSubtype                                                     int8 NOT NULL,
     OriginMinCard                                                     int8 NOT NULL,
     OriginMaxCard                                                     int8 NOT NULL,
     DestSubtype                                                       int8 NOT NULL,
     DestMinCard                                                       int8 NOT NULL,
     DestMaxCard                                                       int8 NOT NULL,
     UNIQUE (RuleID)
     );


CREATE TABLE GDB_ReplicaDatasets
     (
     ID                                                                 serial,
     ReplicaID                                                         int8 NOT NULL,
     DatasetType                                                       int8 NOT NULL,
     DatasetID                                                         int8 NOT NULL,
     ParentOwner                                                       varchar(255) NOT NULL,
     ParentDB                                                          varchar(255),
     UNIQUE (ID)
     );


CREATE TABLE GDB_Replicas
     (
     ID                                                                 serial,
     Name                                                              varchar(255) NOT NULL,
     Owner                                                             varchar(255),
     Version                                                           varchar(255) NOT NULL,
     ParentID                                                          int8 NOT NULL,
     RepDate                                                           timestamp NOT NULL,
     DefQuery                                                          text NOT NULL,
     RepGuid                                                           varchar(255) NOT NULL,
     RepCInfo                                                          varchar(255) NOT NULL,
     Role                                                              int8 NOT NULL,
     UNIQUE (ID),
     UNIQUE (Name)
     );


CREATE TABLE GDB_SpatialRefs
     (
     SRID                                                               serial,
     SRTEXT                                                            text NOT NULL,
     FalseX                                                            float8,
     FalseY                                                            float8,
     XYUnits                                                           float8,
     FalseZ                                                            float8,
     ZUnits                                                            float8,
     FalseM                                                            float8,
     MUnits                                                            float8
     );


CREATE TABLE GDB_StringDomains
     (
     DomainID                                                          int8 NOT NULL,
     Format                                                            varchar(255) NOT NULL,
     UNIQUE (DomainID)
     );


CREATE TABLE GDB_Subtypes
     (
     ID                                                                 serial,
     ClassID                                                           int8 NOT NULL,
     SubtypeCode                                                       int8 NOT NULL,
     SubtypeName                                                       varchar(255) NOT NULL,
     UNIQUE (ID)
     );


CREATE TABLE GDB_TopoClasses
     (
     ClassID                                                           int8 NOT NULL,
     TopologyID                                                        int8 NOT NULL,
     Weight                                                            float8 NOT NULL,
     XYRank                                                            int8 NOT NULL,
     ZRank                                                             int8 NOT NULL,
     EventsOnAnalyze                                                   int8 NOT NULL,
     UNIQUE (ClassID)
     );


CREATE TABLE GDB_Topologies
     (
     ID                                                                 serial,
     DatabaseName                                                      varchar(255),
     Owner                                                             varchar(255),
     Name                                                              varchar(255) NOT NULL,
     DatasetID                                                         int8 NOT NULL,
     Properties                                                        text,
     UNIQUE (ID),
     UNIQUE (ID),
     UNIQUE (Name)
     );


CREATE TABLE GDB_TopoRules
     (
     RuleID                                                            int8 NOT NULL,
     OriginClassID                                                     int8 NOT NULL,
     OriginSubtype                                                     int8 NOT NULL,
     AllOriginSubtypes                                                 int8 NOT NULL,
     DestClassID                                                       int8 NOT NULL,
     DestSubtype                                                       int8 NOT NULL,
     AllDestSubtypes                                                   int8 NOT NULL,
     TopologyRuleType                                                  int8 NOT NULL,
     Name                                                              varchar(255),
     RuleGUID                                                          varchar(255) NOT NULL,
     UNIQUE (RuleGUID),
     UNIQUE (RuleID)
     );


CREATE TABLE GDB_UserMetadata
     (
     ID                                                                 serial,
     DatabaseName                                                      varchar(255),
     Owner                                                             varchar(255),
     Name                                                              varchar(255) NOT NULL,
     DatasetType                                                       int8 NOT NULL,
     Xml                                                               text NOT NULL,
     UNIQUE (ID),
     UNIQUE (Name, Owner, DatabaseName, DatasetType)
     );


CREATE TABLE GDB_ValidRules
     (
     ID                                                                 serial,
     RuleType                                                          int8 NOT NULL,
     ClassID                                                           int8 NOT NULL,
     RuleCategory                                                      int8 NOT NULL,
     HelpString                                                        varchar(255),
     UNIQUE (ID)
     );


CREATE TABLE ILE_BANC
     (
     ID_ILE_BANC                                                       int8,
     NOM_ILE_BANC                                                      varchar(255),
     ID_ORG_GESTIONNAIRE                                               int8,
     ENGRAVEMENT_MATERIAUX                                             int8,
     DVPT_VEGETATION                                                   int8,
     COMMENTAIRE                                                       text,
     SURFACE                                                           float8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ILE_BANC)
     );


CREATE TABLE ILE_TRONCON
     (
     ID_ILE_TRONCON                                                     serial,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     ID_ILE_BANC                                                       int8 NOT NULL,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     DETACHE                                                           bool,
     ID_SOURCE                                                         int8,
     ID_BORNEREF_DEBUT                                                 float8,
     ID_BORNEREF_FIN                                                   float8,
     ID_SYSTEME_REP                                                    int8,
     DIST_BORNEREF_DEBUT                                               float8,
     DIST_BORNEREF_FIN                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     AMONT_AVAL_FIN                                                    bool,
     X_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_DEBUT                                                           float8,
     Y_FIN                                                             float8,
     COMMENTAIRE                                                       text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ILE_TRONCON)
     );


CREATE TABLE IMPLANTATION
     (
     ID_IMPLANTATION                                                   int8 NOT NULL,
     LIBELLE_IMPLANTATION                                              varchar(255),
     ABREGE_TYPE_IMPLANTATION                                          varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_IMPLANTATION)
     );


CREATE TABLE INTERVENANT
     (
     ID_INTERVENANT                                                     serial,
     NOM_INTERVENANT                                                   varchar(255),
     PRENOM_INTERVENANT                                                varchar(255),
     ADRESSE_PERSO_INTERV                                              varchar(255),
     ADRESSE_L1_PERSO_INTERV                                           varchar(255),
     ADRESSE_L2_PERSO_INTERV                                           varchar(255),
     ADRESSE_L3_PERSO_INTERV                                           varchar(255),
     ADRESSE_CODE_POSTAL_PERSO_INTERV                                  int8,
     ADRESSE_NOM_COMMUNE_PERSO_INTERV                                  varchar(255),
     TEL_PERSO_INTERV                                                  varchar(255),
     FAX_PERSO_INTERV                                                  varchar(255),
     MAIL_INTERV                                                       varchar(255),
     SERVICE_INTERV                                                    varchar(255),
     FONCTION_INTERV                                                   varchar(255),
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          DECIMAL(20,4),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_INTERVENANT)
     );


CREATE TABLE JOURNAL
     (
     ID_JOURNAL                                                         serial,
     NOM_JOURNAL                                                       varchar(255),
     DATE_JOURNAL                                                      timestamp,
     ID_CRUE                                                           int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_JOURNAL)
     );


CREATE TABLE JOURNAL_ARTICLE
     (
     ID_ARTICLE_JOURNAL                                                 serial,
     ID_JOURNAL                                                        int8,
     INTITULE_ARTICLE                                                  varchar(255),
     DATE_ARTICLE                                                      timestamp,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     COMMENTAIRE                                                       text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ARTICLE_JOURNAL)
     );


CREATE TABLE LAISSE_CRUE
     (
     ID_LAISSE_CRUE                                                     serial,
     ID_EVENEMENT_HYDRAU                                               int8,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     DATE                                                              timestamp,
     ID_TYPE_REF_HEAU                                                  int8,
     HAUTEUR_EAU                                                       float8,
     ID_INTERV_OBSERVATEUR                                             int8,
     ID_SOURCE                                                         int8,
     POSITION                                                          varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_LAISSE_CRUE)
     );


CREATE TABLE LAISSE_CRUE_JOURNAL
     (
     ID_ARTICLE_JOURNAL                                                int8 NOT NULL,
     ID_LAISSE_CRUE                                                    int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ARTICLE_JOURNAL, ID_LAISSE_CRUE)
     );


CREATE TABLE LIGNE_EAU
     (
     ID_LIGNE_EAU                                                       serial,
     ID_EVENEMENT_HYDRAU                                               int8,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     ID_TYPE_REF_HEAU                                                  int8,
     ID_SYSTEME_REP_PRZ                                                int8,
     DATE                                                              timestamp,
     COMMENTAIRE                                                       text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_LIGNE_EAU)
     );


CREATE TABLE LIGNE_EAU_JOURNAL
     (
     ID_ARTICLE_JOURNAL                                                int8 NOT NULL,
     ID_LIGNE_EAU                                                      int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ARTICLE_JOURNAL, ID_LIGNE_EAU)
     );


CREATE TABLE LIGNE_EAU_MESURES_PRZ
     (
     ID_LIGNE_EAU                                                      int8,
     PR_SAISI                                                          float8,
     HAUTEUR_EAU                                                       float8,
     PR_CALCULE                                                        float8,
     ID_POINT                                                          int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_LIGNE_EAU, PR_SAISI, HAUTEUR_EAU)
     );


CREATE TABLE LIGNE_EAU_MESURES_XYZ
     (
     ID_LIGNE_EAU                                                      int8,
     X                                                                 float8,
     Y                                                                 float8,
     HAUTEUR_EAU                                                       float8,
     PR_CALCULE                                                        float8,
     ID_POINT                                                          int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_LIGNE_EAU, X, Y, HAUTEUR_EAU)
     );


CREATE TABLE MARCHE
     (
     ID_MARCHE                                                          serial,
     LIBELLE_MARCHE                                                    varchar(255),
     ID_MAITRE_OUVRAGE                                                 int8 NOT NULL,
     DATE_DEBUT_MARCHE                                                 timestamp,
     DATE_FIN_MARCHE                                                   timestamp,
     MONTANT_MARCHE                                                    float8,
     N_OPERATION                                                       int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_MARCHE)
     );


CREATE TABLE MARCHE_FINANCEUR
     (
     ID_ORGANISME                                                      int8 NOT NULL,
     ID_MARCHE                                                         int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ORGANISME, ID_MARCHE)
     );


CREATE TABLE MARCHE_MAITRE_OEUVRE
     (
     ID_MARCHE                                                         int8 NOT NULL,
     ID_ORGANISME                                                      int8 NOT NULL,
     ID_FONCTION_MO                                                    int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ORGANISME, ID_MARCHE, ID_FONCTION_MO)
     );


CREATE TABLE METEO
     (
     ID_EVENEMENT_HYDRAU                                               int8,
     DATE_DEBUT_METEO                                                  timestamp,
     DATE_FIN_METEO                                                    timestamp,
     VITESSE_VENT                                                      float8,
     ID_TYPE_ORIENTATION_VENT                                          int8,
     PRESSION_ATMOSPHERIQUE                                            float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_EVENEMENT_HYDRAU, DATE_DEBUT_METEO, DATE_FIN_METEO)
     );


CREATE TABLE MONTEE_DES_EAUX
     (
     ID_MONTEE_DES_EAUX                                                 serial,
     ID_EVENEMENT_HYDRAU                                               int8,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     PR_CALCULE                                                        float8,
     X                                                                 float8,
     Y                                                                 float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF                                                       float8,
     AMONT_AVAL                                                        bool,
     DIST_BORNEREF                                                     float8,
     COMMENTAIRE                                                       text,
     ID_ECHELLE_LIMNI                                                  int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_MONTEE_DES_EAUX)
     );


CREATE TABLE MONTEE_DES_EAUX_JOURNAL
     (
     ID_ARTICLE_JOURNAL                                                int8 NOT NULL,
     ID_MONTEE_DES_EAUX                                                int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ARTICLE_JOURNAL, ID_MONTEE_DES_EAUX)
     );


CREATE TABLE MONTEE_DES_EAUX_MESURES
     (
     ID_MONTEE_DES_EAUX                                                int8,
     DATE                                                              timestamp,
     ID_TYPE_REF_HEAU                                                  int8,
     HAUTEUR_EAU                                                       float8,
     DEBIT_MAX                                                         float8,
     ID_INTERV_OBSERVATEUR                                             int8,
     ID_SOURCE                                                         int8,
     COMMENTAIRE                                                       text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_MONTEE_DES_EAUX, DATE)
     );


CREATE TABLE observation_urgence_carto
     (
     ID_DESORDRE                                                        serial,
     ID_TRONCON_GESTION                                                int8,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     ID_SYSTEME_REP                                                    int8,
     ID_TYPE_POSITION                                                  int8,
     ID_TYPE_COTE                                                      int8,
     MaxDeDATE_OBSERVATION_DESORDRE                                    timestamp,
     LIBELLE_TYPE_URGENCE                                              varchar(255)
     );


CREATE TABLE ORGANISME
     (
     ID_ORGANISME                                                       serial,
     RAISON_SOCIALE                                                    varchar(255),
     STATUT_JURIDIQUE                                                  varchar(255),
     ADRESSE_L1_ORG                                                    varchar(255),
     ADRESSE_L2_ORG                                                    varchar(255),
     ADRESSE_L3_ORG                                                    varchar(255),
     ADRESSE_CODE_POSTAL_ORG                                           int8,
     ADRESSE_NOM_COMMUNE_ORG                                           varchar(255),
     TEL_ORG                                                           varchar(255),
     MAIL_ORG                                                          varchar(255),
     FAX_ORG                                                           varchar(255),
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ORGANISME)
     );


CREATE TABLE ORGANISME_DISPOSE_INTERVENANT
     (
     ID_ORGANISME                                                      int8 NOT NULL,
     ID_INTERVENANT                                                    int8 NOT NULL,
     DATE_DEBUT_INTERV_ORG                                             timestamp,
     DATE_FIN_INTERV_ORG                                               timestamp,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ORGANISME, ID_INTERVENANT)
     );


CREATE TABLE ORIENTATION
     (
     ID_ORIENTATION                                                    int8 NOT NULL,
     LIBELLE_ORIENTATION                                               varchar(50),
     ABREGE_TYPE_ORIENTATION                                           varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_ORIENTATION)
     );


CREATE TABLE PARCELLE_CADASTRE
     (
     ID_PARCELLE                                                       int8 NOT NULL,
     ID_INTERV_PROPRIO                                                 int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_TYPE_EMPRISE_PARCELLE                                          int8,
     ID_COMMUNE                                                        int8,
     ID_SECTION                                                        varchar(255),
     NO_PARCELLE                                                       varchar(255),
     PR_DEBUT_PARC                                                     float8,
     PR_FIN_PARC                                                       float8,
     X_DEBUT_PARC                                                      float8,
     X_FIN_PARC                                                        float8,
     Y_DEBUT_PARC                                                      float8,
     Y_FIN_PARC                                                        float8,
     ID_BORNEREF_DEBUT_PARC                                            float8,
     ID_BORNEREF_FIN_PARC                                              float8,
     ID_SYSTEME_REP                                                    int8,
     DIST_BORNEREF_DEBUT_PARC                                          float8,
     DIST_BORNEREF_FIN_PARC                                            float8,
     AMONT_AVAL_DEBUT                                                  bool,
     AMONT_AVAL_FIN                                                    bool,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PARCELLE)
     );


CREATE TABLE PARCELLE_LONGE_DIGUE
     (
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     ID_PARCELLE                                                       int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TRONCON_GESTION, ID_PARCELLE)
     );


CREATE TABLE PHOTO_LAISSE
     (
     ID_PHOTO                                                          int8 NOT NULL,
     ID_LAISSE_CRUE                                                    int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PHOTO)
     );


CREATE TABLE PHOTO_LOCALISEE_EN_PR
     (
     ID_PHOTO                                                           serial,
     ID_ELEMENT_SOUS_GROUPE                                            int8 NOT NULL,
     ID_TRONCON_GESTION                                                int8,
     ID_GROUPE_DONNEES                                                 int8 NOT NULL,
     ID_SOUS_GROUPE_DONNEES                                            int8 NOT NULL,
     ID_ORIENTATION                                                    int8,
     ID_INTERV_PHOTOGRAPH                                              int8,
     ID_DOC                                                            int8,
     REF_PHOTO                                                         varchar(255),
     DESCRIPTION_PHOTO                                                 text,
     NOM_FICHIER_PHOTO                                                 varchar(255),
     ID_TYPE_COTE                                                      int8,
     DATE_PHOTO                                                        timestamp,
     PR_PHOTO                                                          float8,
     ID_SYSTEME_REP                                                    int8,
     X_PHOTO                                                           float8,
     Y_PHOTO                                                           float8,
     ID_BORNEREF                                                       float8,
     AMONT_AVAL                                                        bool,
     DIST_BORNEREF                                                     float8,
     AVANT_APRES                                                       bool,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PHOTO)
     );


CREATE TABLE PHOTO_LOCALISEE_EN_XY
     (
     ID_PHOTO                                                           serial,
     ID_TRONCON_GESTION                                                int8,
     ID_GROUPE_DONNEES                                                 int8 NOT NULL,
     ID_SOUS_GROUPE_DONNEES                                            int8 NOT NULL,
     ID_ORIENTATION                                                    int8,
     ID_INTERV_PHOTOGRAPH                                              int8,
     ID_DOC                                                            int8,
     REF_PHOTO                                                         varchar(255),
     DESCRIPTION_PHOTO                                                 text,
     NOM_FICHIER_PHOTO                                                 varchar(255),
     ID_TYPE_COTE                                                      int8,
     DATE_PHOTO                                                        timestamp,
     X_PHOTO                                                           float8,
     Y_PHOTO                                                           float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PHOTO)
     );


CREATE TABLE PRESTATION
     (
     ID_PRESTATION                                                      serial,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     LIBELLE_PRESTATION                                                varchar(255),
     ID_MARCHE                                                         int8,
     REALISATION_INTERNE                                               bool,
     ID_TYPE_PRESTATION                                                int8 NOT NULL,
     COUT_AU_METRE                                                     float8,
     COUT_GLOBAL                                                       float8,
     ID_TYPE_COTE                                                      int8,
     ID_TYPE_POSITION                                                  int8,
     ID_INTERV_REALISATEUR                                             int8,
     DESCRIPTION_PRESTATION                                            text,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     ID_SOURCE                                                         int8,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_BORNEREF_DEBUT                                                 float8,
     ID_BORNEREF_FIN                                                   float8,
     ID_SYSTEME_REP                                                    int8,
     DIST_BORNEREF_DEBUT                                               float8,
     DIST_BORNEREF_FIN                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     AMONT_AVAL_FIN                                                    bool,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PRESTATION)
     );


CREATE TABLE PRESTATION_DOCUMENT
     (
     ID_PRESTATION                                                     int8 NOT NULL,
     ID_DOC                                                            int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_DOC, ID_PRESTATION)
     );


CREATE TABLE PRESTATION_EVENEMENT_HYDRAU
     (
     ID_PRESTATION                                                     int8 NOT NULL,
     ID_EVENEMENT_HYDRAU                                               int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_EVENEMENT_HYDRAU, ID_PRESTATION)
     );


CREATE TABLE PRESTATION_INTERVENANT
     (
     ID_PRESTATION                                                     int8 NOT NULL,
     ID_INTERVENANT                                                    int8 NOT NULL,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_INTERVENANT, ID_PRESTATION)
     );


CREATE TABLE PROFIL_EN_LONG
     (
     ID_PROFIL_EN_LONG                                                 int8,
     NOM                                                               varchar(255),
     DATE_LEVE                                                         timestamp,
     ID_ORG_CREATEUR                                                   int8,
     ID_TYPE_SYSTEME_RELEVE_PROFIL                                     int8,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     ID_TYPE_POSITION_PROFIL_EN_LONG                                   int8,
     ID_TYPE_ORIGINE_PROFIL_EN_LONG                                    int8,
     ID_DOC_RAPPORT_ETUDES                                             int8,
     COMMENTAIRE                                                       text,
     ID_SYSTEME_REP_DZ                                                 int8,
     NOM_FICHIER_PLAN_ENSEMBLE                                         varchar(255),
     NOM_FICHIER_COUPE_IMAGE                                           varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     UNIQUE (ID_PROFIL_EN_LONG),
     PRIMARY KEY (ID_PROFIL_EN_LONG)
     );


CREATE TABLE PROFIL_EN_LONG_DZ
     (
     ID_PROFIL_EN_LONG                                                 int8 NOT NULL,
     ID_POINT                                                          int8,
     PR_SAISI                                                          float8,
     Z                                                                 float8,
     PR_CALCULE                                                        float8,
     DATE_DERNIERE_MAJ                                                 timestamp
     );


CREATE TABLE PROFIL_EN_LONG_EVT_HYDRAU
     (
     ID_PROFIL_EN_LONG                                                 int8 NOT NULL,
     ID_EVENEMENT_HYDRAU                                               int8 NOT NULL,
     PR_DEBUT_SAISI                                                    float8,
     PR_FIN_SAISI                                                      float8,
     PREMIER_DEBORDEMENT_DEBIT_M3S                                     float8,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PROFIL_EN_LONG, ID_EVENEMENT_HYDRAU, PR_DEBUT_SAISI, PR_FIN_SAISI)
     );


CREATE TABLE PROFIL_EN_LONG_XYZ
     (
     ID_PROFIL_EN_LONG                                                 int8 NOT NULL,
     ID_POINT                                                          int8,
     X                                                                 float8,
     Y                                                                 float8,
     Z                                                                 float8,
     PR_CALCULE                                                        float8,
     DATE_DERNIERE_MAJ                                                 timestamp
     );


CREATE TABLE PROFIL_EN_TRAVERS
     (
     ID_PROFIL_EN_TRAVERS                                               serial,
     NOM                                                               varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PROFIL_EN_TRAVERS)
     );


CREATE TABLE PROFIL_EN_TRAVERS_DESCRIPTION
     (
     ID_PROFIL_EN_TRAVERS_LEVE                                          serial,
     ID_PROFIL_EN_TRAVERS                                              int8,
     DATE_LEVE                                                         timestamp,
     ID_ORG_CREATEUR                                                   int8,
     ID_TYPE_SYSTEME_RELEVE_PROFIL                                     int8,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     ID_TYPE_PROFIL_EN_TRAVERS                                         int8,
     ID_TYPE_ORIGINE_PROFIL_EN_TRAVERS                                 int8,
     ID_DOC_RAPPORT_ETUDES                                             int8,
     COMMENTAIRE                                                       text,
     NOM_FICHIER_PLAN_ENSEMBLE                                         varchar(255),
     NOM_FICHIER_COUPE_IMAGE                                           varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PROFIL_EN_TRAVERS_LEVE)
     );


CREATE TABLE PROFIL_EN_TRAVERS_DZ
     (
     ID_PROFIL_EN_TRAVERS_LEVE                                         int8 NOT NULL,
     ID_POINT                                                          int8 NOT NULL,
     DISTANCE                                                          float8,
     Z                                                                 float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PROFIL_EN_TRAVERS_LEVE, ID_POINT)
     );


CREATE TABLE PROFIL_EN_TRAVERS_EVT_HYDRAU
     (
     ID_PROFIL_EN_TRAVERS_LEVE                                         int8 NOT NULL,
     ID_EVENEMENT_HYDRAU                                               int8 NOT NULL,
     DEBIT_DE_POINTE_M3S                                               float8,
     VITESSE_DE_POINTE_MS                                              float8,
     COTE_EAU_NGF                                                      float8,
     COMMENTAIRE                                                       text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PROFIL_EN_TRAVERS_LEVE, ID_EVENEMENT_HYDRAU)
     );


CREATE TABLE PROFIL_EN_TRAVERS_STRUCTUREL
     (
     ID_PROFIL_EN_TRAVERS_LEVE                                         int8 NOT NULL,
     COTE_RIVIERE_LARGEUR_FRANC_BORD                                   float8,
     COTE_RIVIERE_PENTE_FRANC_BORD                                     float8,
     COTE_RIVIERE_LONG_RAMP_RISBERME                                   float8,
     COTE_RIVIERE_PENTE_RISBERME                                       float8,
     COTE_RIVIERE_LARG_SOMM_RISBERME                                   float8,
     COTE_RIVIERE_LONG_RAMP_TALUS                                      float8,
     COTE_RIVIERE_PENTE_TALUS                                          float8,
     CRETE_LARG                                                        float8,
     CRETE_TYPE_DEVERS                                                 int8,
     COTE_TERRE_LONG_RAMP_TALUS                                        float8,
     COTE_TERRE_PENTE_TALUS                                            float8,
     COTE_TERRE_LONG_RAMP_RISBERME                                     float8,
     COTE_TERRE_PENTE_RISBERME                                         float8,
     COTE_TERRE_LARG_SOMM_RISBERME                                     float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PROFIL_EN_TRAVERS_LEVE),
     UNIQUE (ID_PROFIL_EN_TRAVERS_LEVE)
     );


CREATE TABLE PROFIL_EN_TRAVERS_TRONCON
     (
     ID_PROFIL_EN_TRAVERS_LEVE                                         int8 NOT NULL,
     ID_DOC                                                            int8 NOT NULL,
     COTE_RIVIERE_Z_NGF_PIED_DE_DIGUE                                  float8,
     COTE_RIVIERE_Z_NGF_SOMMET_RISBERME                                float8,
     CRETE_Z_NGF                                                       float8,
     COTE_TERRE_Z_NGF_SOMMET_RISBERME                                  float8,
     COTE_TERRE_Z_NGF_PIED_DE_DIGUE                                    float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     CRETE_LARGEUR                                                     float8,
     PRIMARY KEY (ID_PROFIL_EN_TRAVERS_LEVE, ID_DOC)
     );


CREATE TABLE PROFIL_EN_TRAVERS_XYZ
     (
     ID_PROFIL_EN_TRAVERS_LEVE                                         int8 NOT NULL,
     ID_POINT                                                          int8 NOT NULL,
     X                                                                 float8,
     Y                                                                 float8,
     Z                                                                 float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PROFIL_EN_TRAVERS_LEVE, ID_POINT)
     );


CREATE TABLE PROPRIETAIRE_TRONCON_GESTION
     (
     ID_PROPRIETAIRE_TRONCON_GESTION                                    serial,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     ID_TYPE_PROPRIETAIRE                                              int8,
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     ID_ORGANISME                                                      int8 NOT NULL,
     ID_INTERVENANT                                                    int8,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_DEBUT                                                           float8,
     Y_FIN                                                             float8,
     ID_BORNEREF_DEBUT                                                 float8,
     ID_BORNEREF_FIN                                                   float8,
     ID_SYSTEME_REP                                                    int8,
     DIST_BORNEREF_DEBUT                                               float8,
     DIST_BORNEREF_FIN                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     AMONT_AVAL_FIN                                                    bool,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_PROPRIETAIRE_TRONCON_GESTION)
     );


CREATE TABLE rampes_Isere_riviere_crete
     (
     ID_ELEMENT_RESEAU                                                  serial,
     ID_TRONCON_GESTION                                                int8,
     NOM_TRONCON_GESTION                                               varchar(255),
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     COMMENTAIRE                                                       text,
     NOM                                                               varchar(255),
     LARGEUR                                                           float8,
     LIBELLE_TYPE_ORIENTATION_OUVRAGE_FRANCHISSEMENT                   varchar(255),
     ID_TYPE_OUVRAGE_FRANCHISSEMENT                                    int8,
     LIBELLE_TYPE_OUVRAGE_FRANCHISSEMENT                               varchar(255),
     ID_TYPE_COTE                                                      int8
     );


CREATE TABLE RAPPORT_ETUDE
     (
     ID_RAPPORT_ETUDE                                                   serial,
     TITRE_RAPPORT_ETUDE                                               varchar(255),
     ID_TYPE_RAPPORT_ETUDE                                             int8,
     AUTEUR_RAPPORT                                                    varchar(255),
     DATE_RAPPORT                                                      timestamp,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     COMMENTAIRE                                                       text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_RAPPORT_ETUDE)
     );


CREATE TABLE REQ_ADIDR_CREATION
     (
     Nom_requête                                                       varchar(50),
     Type_requête                                                      varchar(50),
     Date                                                              timestamp,
     Nom_créateur                                                      varchar(50),
     Commentaire                                                       varchar(255),
     SQL                                                               text,
     PRIMARY KEY (Nom_requête)
     );


CREATE TABLE REQ_CC_BORNE_5_EN_5_RD
     (
     NOM_BORNE                                                         varchar(255),
     ID_BORNE                                                           serial,
     ID_TRONCON_GESTION                                                int8,
     X_POINT                                                           float8,
     Y_POINT                                                           float8,
     Z_POINT                                                           float8,
     X_POINT_ORIGINE                                                   float8,
     Y_POINT_ORIGINE                                                   float8,
     VALEUR_PR                                                         float8
     );


CREATE TABLE REQ_CC_HAUTEUR_DIGUE_SUR_TN_TMP
     (
     ID_PROFIL_EN_TRAVERS                                               serial,
     NOM                                                               varchar(255),
     ID_TRONCON_GESTION                                                int8,
     PR_DEBUT_CALCULE                                                  float8,
     CRETE_Z_NGF                                                       float8,
     COTE_TERRE_Z_NGF_PIED_DE_DIGUE                                    float8,
     Hauteur_de_digue                                                  float8,
     ID_PROFIL_EN_TRAVERS_LEVE                                         int8
     );


CREATE TABLE REQ_CC_LOCALISATION_TMP
     (
     ID_PROFIL_EN_TRAVERS                                               serial,
     NOM                                                               varchar(255),
     ID_TRONCON_GESTION                                                int8,
     PR_DEBUT_CALCULE                                                  float8
     );


CREATE TABLE REQ_CC_RAMPES_ACCES
     (
     NOM                                                               varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     ID_TRONCON_GESTION                                                int8,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     COMMENTAIRE                                                       text
     );


CREATE TABLE REQ_CC_TMP
     (
     ID_TRONCON_GESTION                                                int8,
     ID_ELEMENT_STRUCTURE                                               serial,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     NOM_BORNE                                                         varchar(255),
     DIST_BORNEREF_DEBUT                                               float8,
     LIBELLE_TYPE_POSITION                                             varchar(255),
     COMMENTAIRE                                                       text,
     SONDAGES                                                          float8 DEFAULT 0
     );


CREATE TABLE REQ_CEMAGREF_SENSIBILITE_EVT_HYDRAU
     (
     NOM                                                               varchar(255),
     ID_PROFIL_EN_TRAVERS_LEVE                                          serial,
     ID_PROFIL_EN_TRAVERS                                              int8,
     NOM_EVENEMENT_HYDRAU                                              varchar(255),
     ID_EVENEMENT_HYDRAU                                               int8,
     COTE_EAU_NGF                                                      float8,
     ID_DOC                                                            int8,
     PR_DEBUT_CALCULE                                                  float8,
     CRETE_Z_NGF                                                       float8,
     COTE_TERRE_Z_NGF_PIED_DE_DIGUE                                    float8,
     ID_TRONCON_GESTION                                                int8,
     DEBIT_DE_POINTE_M3S                                               float8,
     VITESSE_DE_POINTE_MS                                              float8,
     Hauteur_digue                                                     float8 DEFAULT 0,
     Hauteur_charge                                                    float8 DEFAULT 0,
     Revanche_digue_evt_hydro                                          float8 DEFAULT 0
     );


CREATE TABLE REQ_SOGREAH_SENSIBILITE_EVT_HYDRAU
     (
     ID_TRONCON_GESTION                                                int8,
     NOM                                                               varchar(255),
     PR_DEBUT_CALCULE                                                  float8,
     CRETE_Z_NGF                                                       float8,
     COTE_TERRE_Z_NGF_PIED_DE_DIGUE                                    float8,
     CRETE_LARG                                                        float8,
     COTE_EAU_NGF                                                      float8,
     DEBIT_DE_POINTE_M3S                                               float8,
     VITESSE_DE_POINTE_MS                                              float8,
     HAUTEUR_DIGUE                                                     float8 DEFAULT 0,
     HAUTEUR_CHARGE                                                    float8 DEFAULT 0,
     HAUTEUR_REVANCHE                                                  float8 DEFAULT 0
     );


CREATE TABLE RQ_CC_SONDAGES
     (
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     NOM_TRONCON_GESTION                                               varchar(255),
     PR_DEBUT_CALCULE                                                  float8,
     N_COUCHE                                                          int8,
     COMMENTAIRE                                                       text,
     TYPE_MATERIAU_LIBELLE_TYPE_MATERIAU                               varchar(255),
     LONG_RAMP_HAUT                                                    float8,
     TYPE_MATERIAU_1_LIBELLE_TYPE_MATERIAU                             varchar(255),
     LONG_RAMP_BAS                                                     float8,
     ID_ELEMENT_STRUCTURE                                               serial,
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_ELEMENT_STRUCTURE                                         int8
     );


CREATE TABLE SelectedObjects
     (
     SelectionID                                                       int8 NOT NULL,
     ObjectID                                                          int8 NOT NULL
     );


CREATE TABLE Selections
     (
     SelectionID                                                        serial,
     TargetName                                                        varchar(255) NOT NULL,
     UNIQUE (SelectionID)
     );


CREATE TABLE SOURCE_INFO
     (
     ID_SOURCE                                                         int8 NOT NULL,
     LIBELLE_SOURCE                                                    varchar(255),
     ABREGE_TYPE_SOURCE_INFO                                           varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_SOURCE)
     );


CREATE TABLE SYNCHRO_BD_COURANTE
     (
     ID_BD                                                             varchar(20),
     ID_ORGANISME_BD                                                   int8,
     NOM_BD                                                            text,
     VERSION_BD                                                        varchar(10),
     DATE_GENERATION                                                   timestamp,
     DATE_INTEGRATION                                                  timestamp,
     ID_BD_PARENTE                                                     varchar(20),
     REPERTOIRE_RACINE_BD_ENFANTS                                      varchar(100)
     );


CREATE TABLE SYNCHRO_BD_GENEREE
     (
     ID_BD                                                             varchar(20) NOT NULL,
     ID_ORGANISME_BD                                                   int8,
     NOM_BD                                                            text,
     DATE_DERNIERE_GENERATION                                          timestamp,
     DATE_DERNIERE_INTEGRATION                                         timestamp,
     PRIMARY KEY (ID_BD)
     );


CREATE TABLE SYNCHRO_BD_TABLE
     (
     ID_BD                                                             varchar(20) NOT NULL,
     DATE_GENERATION                                                   timestamp NOT NULL,
     NOM_TABLE                                                         varchar(100) NOT NULL,
     CLE_PRIMAIRE_DERNIERE_VALEUR                                      int8,
     PRIMARY KEY (ID_BD, DATE_GENERATION, NOM_TABLE)
     );


CREATE TABLE SYNCHRO_FILTRE_TRONCON
     (
     ID_BD                                                             varchar(20) NOT NULL,
     DATE_GENERATION                                                   timestamp NOT NULL,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     PRIMARY KEY (ID_BD, DATE_GENERATION, ID_TRONCON_GESTION)
     );


CREATE TABLE SYNCHRO_JOURNAL
     (
     ID_BD                                                             varchar(20),
     DATE_GENERATION                                                   timestamp,
     ID_LIGNE                                                           serial,
     ACCEPTATION_MAJ                                                   bool,
     NOM_TABLE                                                         varchar(100),
     DIFFERENCE_CONSTATEE                                              varchar(20),
     VALEUR_CHAMP_CLE1                                                 int8,
     VALEUR_CHAMP_CLE2                                                 int8,
     VALEUR_CHAMP_CLE3                                                 int8,
     VALEUR_CHAMP_CLE4                                                 int8,
     VALEUR_CHAMP_CLE5                                                 int8,
     ORDRE_MAJ                                                         int8,
     MESSAGE_MAJ                                                       text,
     VALEURS_CHAMPS_CLES                                               text,
     CHAMPS_ENREG_BD_PARENTE                                           text,
     CHAMPS_ENREG_BD_ENFANT                                            text
     -- PRIMARY KEY (ID_BD, DATE_GENERATION, ID_LIGNE)
     );


CREATE TABLE SYNCHRO_ORGANISME_BD
     (
     ID_ORGANISME_BD                                                    serial,
     NOM_ORGANISME_BD                                                  varchar(100),
     PRIMARY KEY (ID_ORGANISME_BD)
     );


CREATE TABLE SYNCHRO_SUIVI_BD
     (
     ID_BD                                                             varchar(20) NOT NULL,
     DATE_GENERATION                                                   timestamp NOT NULL,
     DATE_INTEGRATION                                                  timestamp,
     PRIMARY KEY (ID_BD, DATE_GENERATION)
     );


CREATE TABLE SYNDICAT
     (
     ID_SYNDICAT                                                        serial,
     LIBELLE_SYNDICAT                                                  varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_SYNDICAT)
     );


CREATE TABLE SYS_DONNEES_LOCALISEES_EN_PR
     (
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DONNEE                                                    int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8
     );


CREATE TABLE SYS_EVT_AUTRE_OUVRAGE_HYDRAULIQUE
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_BRISE_LAME
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_CHEMIN_ACCES
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_CONDUITE_FERMEE
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_CONVENTION
     (
     ID_DOC                                                            int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_DOCUMENT                                             varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_PROFIL_EN_TRAVERS                                             varchar(255),
     LIBELLE_MARCHE                                                    varchar(255),
     INTITULE_ARTICLE                                                  varchar(255),
     TITRE_RAPPORT_ETUDE                                               varchar(255),
     ID_TYPE_RAPPORT_ETUDE                                             int8,
     TE16_AUTEUR_RAPPORT                                               varchar(255),
     DATE_RAPPORT                                                      timestamp,
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     NOM                                                               varchar(255),
     TM_AUTEUR_RAPPORT                                                 varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     ID_RAPPORT_ETUDE                                                  int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_CRETE
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_DESORDRE
     (
     ID_DESORDRE                                                       int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     ID_TYPE_DESORDRE                                                  int8,
     LIBELLE_TYPE_DESORDRE                                             varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     ID_PRESTATION                                                     int8,
     LIBELLE_PRESTATION                                                varchar(255),
     DISPARU_OUI_NON                                                   varchar(10),
     DEJA_OBSERVE_OUI_NON                                              varchar(10),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     ID_TYPE_COTE                                                      int8,
     ID_TYPE_POSITION                                                  int8,
     ID_TRONCON_GESTION                                                int8,
     ID_SOURCE                                                         int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     LIEU_DIT_DESORDRE                                                 varchar(255),
     DESCRIPTION_DESORDRE                                              text,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_DISTANCE_PIED_DE_DIGUE_TRONCON
     (
     ID_ELEMENT_GEOMETRIE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_GEOMETRIE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_LARGEUR_FB                                           varchar(255),
     LIBELLE_TYPE_PROFIL_FB                                            varchar(255),
     LIBELLE_TYPE_DIST_DIGUE_BERGE                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_ELEMENT_GEOMETRIE                                         int8,
     ID_SOURCE                                                         int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     ID_TYPE_LARGEUR_FB                                                int8,
     ID_TYPE_PROFIL_FB                                                 int8,
     ID_TYPE_DIST_DIGUE_BERGE                                          int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_DOCUMENT_A_GRANDE_ECHELLE
     (
     ID_DOC                                                            int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_DOCUMENT                                             varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_PROFIL_EN_TRAVERS                                             varchar(255),
     LIBELLE_MARCHE                                                    varchar(255),
     INTITULE_ARTICLE                                                  varchar(255),
     TITRE_RAPPORT_ETUDE                                               varchar(255),
     ID_TYPE_RAPPORT_ETUDE                                             int8,
     TE16_AUTEUR_RAPPORT                                               varchar(255),
     DATE_RAPPORT                                                      timestamp,
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     NOM                                                               varchar(255),
     TM_AUTEUR_RAPPORT                                                 varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     ID_RAPPORT_ETUDE                                                  int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_DOCUMENT_MARCHE
     (
     ID_DOC                                                            int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_DOCUMENT                                             varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_PROFIL_EN_TRAVERS                                             varchar(255),
     LIBELLE_MARCHE                                                    varchar(255),
     INTITULE_ARTICLE                                                  varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     NOM                                                               varchar(255),
     AUTEUR_RAPPORT                                                    varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_EMPRISE_COMMUNALE
     (
     ID_TRONCON_COMMUNE                                                int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     ID_COMMUNE                                                        int8,
     LIBELLE_COMMUNE                                                   varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_COTE                                                      int8,
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_EMPRISE_SYNDICAT
     (
     ID_TRONCON_SYNDICAT                                               int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     ID_SYNDICAT                                                       int8,
     LIBELLE_SYNDICAT                                                  varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_COTE                                                      int8,
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_EPIS
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_FICHE_INSPECTION_VISUELLE
     (
     ID_DOC                                                            int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_DOCUMENT                                             varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_PROFIL_EN_TRAVERS                                             varchar(255),
     LIBELLE_MARCHE                                                    varchar(255),
     INTITULE_ARTICLE                                                  varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     NOM                                                               varchar(255),
     AUTEUR_RAPPORT                                                    varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_FONDATION
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_GARDIEN_TRONCON
     (
     ID_GARDIEN_TRONCON_GESTION                                        int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     ID_INTERVENANT                                                    int8,
     NOM_INTERVENANT_GARDIEN                                           varchar(255),
     PRENOM_INTERVENANT_GARDIEN                                        varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_ILE_TRONCON
     (
     ID_ILE_TRONCON                                                    int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_ILE_BANC                                                      varchar(255),
     ENGRAVEMENT_MATERIAUX                                             int8,
     DVPT_VEGETATION                                                   int8,
     DETACHE_OUI_NON                                                   varchar(10),
     ID_TRONCON_GESTION                                                int8,
     ID_SOURCE                                                         int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     ID_ILE_BANC                                                       int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_JOURNAL
     (
     ID_DOC                                                            int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_DOCUMENT                                             varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_PROFIL_EN_TRAVERS                                             varchar(255),
     LIBELLE_MARCHE                                                    varchar(255),
     INTITULE_ARTICLE                                                  varchar(255),
     TITRE_RAPPORT_ETUDE                                               varchar(255),
     ID_TYPE_RAPPORT_ETUDE                                             int8,
     TE16_AUTEUR_RAPPORT                                               varchar(255),
     DATE_RAPPORT                                                      timestamp,
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     NOM                                                               varchar(255),
     TM_AUTEUR_RAPPORT                                                 varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     ID_RAPPORT_ETUDE                                                  int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_LAISSE_CRUE
     (
     ID_LAISSE_CRUE                                                    int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_EVENEMENT_HYDRAU                                              varchar(255),
     TypeRefHEau                                                       varchar(255),
     NomPrenomObservateur                                              varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_SOURCE                                                         int8,
     ID_EVENEMENT_HYDRAU                                               int8,
     DATE                                                              timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     ID_TYPE_REF_HEAU                                                  int8,
     HAUTEUR_EAU                                                       float8,
     ID_INTERV_OBSERVATEUR                                             int8,
     POSITION                                                          varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_LARGEUR_FRANC_BORD
     (
     ID_ELEMENT_GEOMETRIE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_GEOMETRIE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_LARGEUR_FB                                           varchar(255),
     LIBELLE_TYPE_PROFIL_FB                                            varchar(255),
     LIBELLE_TYPE_DIST_DIGUE_BERGE                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_ELEMENT_GEOMETRIE                                         int8,
     ID_SOURCE                                                         int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     ID_TYPE_LARGEUR_FB                                                int8,
     ID_TYPE_PROFIL_FB                                                 int8,
     ID_TYPE_DIST_DIGUE_BERGE                                          int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_LIGNE_EAU
     (
     ID_LIGNE_EAU                                                      int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_EVENEMENT_HYDRAU                                              varchar(255),
     TypeRefHEau                                                       varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_EVENEMENT_HYDRAU                                               int8,
     DATE                                                              timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     ID_TYPE_REF_HEAU                                                  int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_MARCHE
     (
     ID_DOC                                                            int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_DOCUMENT                                             varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_PROFIL_EN_TRAVERS                                             varchar(255),
     LIBELLE_MARCHE                                                    varchar(255),
     INTITULE_ARTICLE                                                  varchar(255),
     TITRE_RAPPORT_ETUDE                                               varchar(255),
     ID_TYPE_RAPPORT_ETUDE                                             int8,
     TE16_AUTEUR_RAPPORT                                               varchar(255),
     DATE_RAPPORT                                                      timestamp,
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     NOM                                                               varchar(255),
     TM_AUTEUR_RAPPORT                                                 varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     ID_RAPPORT_ETUDE                                                  int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_MONTEE_DES_EAUX_HYDRO
     (
     ID_MONTEE_DES_EAUX                                                int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE                                                         varchar(255),
     NOM_EVENEMENT_HYDRAU                                              varchar(255),
     NomEtIDEchelleLimni                                               varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_EVENEMENT_HYDRAU                                               int8,
     PR_CALCULE                                                        float8,
     X                                                                 float8,
     Y                                                                 float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF                                                       float8,
     AMONT_AVAL                                                        bool,
     DIST_BORNEREF                                                     float8,
     COMMENTAIRE                                                       text,
     ID_ECHELLE_LIMNI                                                  int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_OUVERTURE_BATARDABLE
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_OUVRAGE_PARTICULIER
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_OUVRAGE_REVANCHE
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_OUVRAGE_TELECOMMUNICATION
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_OUVRAGE_VOIRIE
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_PHOTO_LOCALISEE_EN_PR
     (
     ID_PHOTO                                                          int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     PR_CALCULE                                                        float8,
     X                                                                 float8,
     Y                                                                 float8,
     ID_SYSTEME_REP                                                    int8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     ID_BORNEREF                                                       float8,
     NOM_BORNE                                                         varchar(255),
     AMONT_AVAL                                                        bool,
     DIST_BORNEREF                                                     float8,
     ID_TRONCON_GESTION                                                int8,
     ID_DOC                                                            int8,
     ID_ELEMENT_SOUS_GROUPE                                            int8,
     DATE_PHOTO                                                        timestamp,
     ID_ORIENTATION                                                    int8,
     OrientationPhoto                                                  varchar(255),
     NomPrenomPhotographe                                              varchar(255),
     REF_PHOTO                                                         varchar(255),
     DESCRIPTION_PHOTO                                                 text,
     NOM_FICHIER_PHOTO                                                 varchar(255),
     ID_INTERV_PHOTOGRAPH                                              int8,
     ID_TYPE_COTE                                                      int8,
     TypeCote                                                          varchar(255),
     ID_TYPE_DONNEE                                                    int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_PIED_DE_DIGUE
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_PIED_FRONT_FRANC_BORD
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_PLAN_TOPO
     (
     ID_DOC                                                            int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_DOCUMENT                                             varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_PROFIL_EN_TRAVERS                                             varchar(255),
     LIBELLE_MARCHE                                                    varchar(255),
     INTITULE_ARTICLE                                                  varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     NOM                                                               varchar(255),
     AUTEUR_RAPPORT                                                    varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_POINT_ACCES
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_PRESTATION
     (
     ID_PRESTATION                                                     int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     ID_TYPE_PRESTATION                                                int8,
     LIBELLE_TYPE_PRESTATION                                           varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     ID_MARCHE                                                         int8,
     LIBELLE_MARCHE                                                    varchar(255),
     REALISATION_INTERNE_OUI_NON                                       varchar(10),
     ID_INTERV_REALISATEUR                                             int8,
     NOM_INTERVENANT_REALISATEUR                                       varchar(255),
     PRENOM_INTERVENANT_REALISATEUR                                    varchar(255),
     ID_TYPE_POSITION                                                  int8,
     LIBELLE_TYPE_POSITION                                             varchar(255),
     ID_TYPE_COTE                                                      int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     LIBELLE_PRESTATION                                                varchar(255),
     DESCRIPTION_PRESTATION                                            text,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_PROFIL_EN_LONG
     (
     ID_DOC                                                            int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_DOCUMENT                                             varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_PROFIL_EN_TRAVERS                                             varchar(255),
     LIBELLE_MARCHE                                                    varchar(255),
     INTITULE_ARTICLE                                                  varchar(255),
     TITRE_RAPPORT_ETUDE                                               varchar(255),
     ID_TYPE_RAPPORT_ETUDE                                             int8,
     TE16_AUTEUR_RAPPORT                                               varchar(255),
     DATE_RAPPORT                                                      timestamp,
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     NOM                                                               varchar(255),
     TM_AUTEUR_RAPPORT                                                 varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     ID_RAPPORT_ETUDE                                                  int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_PROFIL_EN_TRAVERS
     (
     ID_DOC                                                            int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_DOCUMENT                                             varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_PROFIL_EN_TRAVERS                                             varchar(255),
     LIBELLE_MARCHE                                                    varchar(255),
     INTITULE_ARTICLE                                                  varchar(255),
     TITRE_RAPPORT_ETUDE                                               varchar(255),
     ID_TYPE_RAPPORT_ETUDE                                             int8,
     TE16_AUTEUR_RAPPORT                                               varchar(255),
     DATE_RAPPORT                                                      timestamp,
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     NOM                                                               varchar(255),
     TM_AUTEUR_RAPPORT                                                 varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     ID_RAPPORT_ETUDE                                                  int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_PROFIL_FRONT_FRANC_BORD
     (
     ID_ELEMENT_GEOMETRIE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_GEOMETRIE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_LARGEUR_FB                                           varchar(255),
     LIBELLE_TYPE_PROFIL_FB                                            varchar(255),
     LIBELLE_TYPE_DIST_DIGUE_BERGE                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_ELEMENT_GEOMETRIE                                         int8,
     ID_SOURCE                                                         int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     ID_TYPE_LARGEUR_FB                                                int8,
     ID_TYPE_PROFIL_FB                                                 int8,
     ID_TYPE_DIST_DIGUE_BERGE                                          int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_PROPRIETAIRE_TRONCON
     (
     ID_PROPRIETAIRE_TRONCON_GESTION                                   int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     ID_ORGANISME                                                      int8,
     NOM_ORGANISME_PROPRIETAIRE                                        varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_PROPRIETAIRE                                              int8,
     LIBELLE_TYPE_PROPRIETAIRE                                         varchar(255),
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_RAPPORT_ETUDES
     (
     ID_DOC                                                            int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_DOCUMENT                                             varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     NOM_PROFIL_EN_TRAVERS                                             varchar(255),
     LIBELLE_MARCHE                                                    varchar(255),
     INTITULE_ARTICLE                                                  varchar(255),
     TITRE_RAPPORT_ETUDE                                               varchar(255),
     ID_TYPE_RAPPORT_ETUDE                                             int8,
     TE16_AUTEUR_RAPPORT                                               varchar(255),
     DATE_RAPPORT                                                      timestamp,
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     NOM                                                               varchar(255),
     TM_AUTEUR_RAPPORT                                                 varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     ID_RAPPORT_ETUDE                                                  int8,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_RESEAU_EAU
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_RESEAU_TELECOMMUNICATION
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_SITUATION_FONCIERE
     (
     ID_TRONCON_SITUATION_FONCIERE                                     int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_SITUATION_FONCIERE                                   varchar(255),
     ID_TRONCON_GESTION                                                int8,
     ID_SOURCE                                                         int8,
     ID_TYPE_COTE                                                      int8,
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 int8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   int8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_SOMMET_RISBERME
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_STATION_DE_POMPAGE
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_TALUS_DIGUE
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_TALUS_FRANC_BORD
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_TALUS_RISBERME
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_VEGETATION
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     LIBELLE_TYPE_MATERIAU_HAUT                                        varchar(255),
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     LIBELLE_TYPE_MATERIAU_BAS                                         varchar(255),
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     RAISON_SOCIALE_ORG_PROPRIO                                        varchar(255),
     RAISON_SOCIALE_ORG_GESTION                                        varchar(255),
     INTERV_PROPRIO                                                    varchar(255),
     INTERV_GARDIEN                                                    varchar(255),
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_EVT_VOIE_SUR_DIGUE
     (
     ID_ELEMENT_RESEAU                                                 int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_ECOULEMENT                                                varchar(255),
     LIBELLE_IMPLANTATION                                              varchar(255),
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     NOM_OUVRAGE_VOIRIE                                                varchar(255),
     LIBELLE_TYPE_POSITION                                             varchar(255),
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     NOM                                                               varchar(255),
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_SECTEUR                                                         varchar(255),
     ID_ECOULEMENT                                                     int8,
     ID_IMPLANTATION                                                   int8,
     ID_UTILISATION_CONDUITE                                           int8,
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     AUTORISE                                                          bool,
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8,
     ID_TYPE_RESEAU_COMMUNICATION                                      int8,
     ID_OUVRAGE_COMM_NRJ                                               int8,
     ID_TYPE_VOIE_SUR_DIGUE                                            int8,
     ID_OUVRAGE_VOIRIE                                                 int8,
     ID_TYPE_REVETEMENT                                                int8,
     ID_TYPE_USAGE_VOIE                                                int8,
     ID_TYPE_POSITION                                                  int8,
     LARGEUR                                                           float8,
     ID_TYPE_OUVRAGE_VOIRIE                                            int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          float8,
     ID_TYPE_RESEAU_EAU                                                int8,
     ID_TYPE_NATURE                                                    int8,
     LIBELLE_TYPE_NATURE                                               varchar(255),
     ID_TYPE_NATURE_HAUT                                               int8,
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_NATURE_BAS                                                int8,
     LIBELLE_TYPE_NATURE_BAS                                           varchar(255),
     ID_TYPE_REVETEMENT_HAUT                                           int8,
     LIBELLE_TYPE_REVETEMENT_HAUT                                      varchar(255),
     ID_TYPE_REVETEMENT_BAS                                            int8,
     LIBELLE_TYPE_REVETEMENT_BAS                                       varchar(255),
     ID_AUTO                                                            serial
     );


CREATE TABLE SYS_IMPORT_POINTS
     (
     DATE_RELEVE                                                       timestamp,
     ID_POINT                                                          int8,
     X                                                                 float8,
     Y                                                                 float8,
     Z                                                                 float8,
     PRIMARY KEY (DATE_RELEVE, ID_POINT)
     );


CREATE TABLE SYS_INDEFINI
     (
     ID_INDEFINI                                                       int8,
     L_INDEFINI                                                        varchar(10)
     );


CREATE TABLE SYS_OPTIONS
     (
     SECTION                                                           varchar(255),
     PARAMETRE                                                         varchar(255),
     VALEUR_PARAMETRE                                                  varchar(255),
     PARAMETRE_EN_CLAIR                                                varchar(255),
     PRIMARY KEY (SECTION, PARAMETRE)
     );


CREATE TABLE SYS_OPTIONS_ETATS
     (
     NOM_ETAT                                                          varchar(100),
     DATE_DEBUT_1                                                      timestamp,
     DATE_FIN_1                                                        timestamp,
     ID_OUI_NON_1                                                      bool,
     ID_OUI_NON_2                                                      bool,
     ID_OUI_NON_3                                                      bool,
     ID_OUI_NON_4                                                      bool,
     ID_OUI_NON_5                                                      bool,
     ID_OUI_NON_6                                                      bool,
     ID_OUI_NON_7                                                      bool,
     TEXTE_1                                                           varchar(255),
     TEXTE_2                                                           varchar(255),
     TEXTE_3                                                           varchar(255),
     PRIMARY KEY (NOM_ETAT)
     );


CREATE TABLE SYS_OPTIONS_REQUETES
     (
     NOM_REQUETE                                                       varchar(100),
     DATE_DEBUT_1                                                      timestamp,
     DATE_FIN_1                                                        timestamp,
     ID_OUI_NON_1                                                      bool,
     ID_OUI_NON_2                                                      bool,
     ID_OUI_NON_3                                                      bool,
     ID_OUI_NON_4                                                      bool,
     ID_OUI_NON_5                                                      bool,
     ID_OUI_NON_6                                                      bool,
     ID_OUI_NON_7                                                      bool,
     TEXTE_1                                                           varchar(255),
     TEXTE_2                                                           varchar(255),
     TEXTE_3                                                           varchar(255),
     REEL_DOUBLE_1                                                     float8,
     REEL_DOUBLE_2                                                     float8,
     REEL_DOUBLE_3                                                     float8,
     REEL_DOUBLE_4                                                     float8,
     PRIMARY KEY (NOM_REQUETE)
     );


CREATE TABLE SYS_OUI_NON
     (
     ID_OUI_NON                                                        bool,
     L_OUI_NON                                                         varchar(10),
     L_AMONT_AVAL                                                      varchar(10),
     L_AVANT_APRES                                                     varchar(10),
     PRIMARY KEY (ID_OUI_NON)
     );


CREATE TABLE SYS_OUI_NON_INDEFINI
     (
     ID_OUI_NON_INDEFINI                                               int8,
     L_OUI_NON_INDEFINI                                                varchar(10),
     L_AMONT_AVAL_INDEFINI                                             varchar(10),
     L_AVANT_APRES_INDEFINI                                            varchar(10),
     PRIMARY KEY (ID_OUI_NON_INDEFINI)
     );


CREATE TABLE SYS_PHOTO_OPTIONS
     (
     ID_TYPE_PHOTO                                                     int8 NOT NULL,
     DOMAINE                                                           varchar(255),
     SOUS_DOMAINE                                                      varchar(255),
     NOM_TABLE_REFERENCE                                               varchar(255),
     ADRESSE_INFORMATIQUE                                              varchar(255),
     PRIMARY KEY (ID_TYPE_PHOTO)
     );


CREATE TABLE SYS_RECHERCHE_MIN_MAX_PR_CALCULE
     (
     ID_TRONCON_GESTION                                                int8,
     PR_MIN_CALCULE                                                    float8,
     PR_MAX_CALCULE                                                    float8
     );


CREATE TABLE SYS_REQ_Temp
     (
     ID_BORNE                                                          float8,
     ID_TRONCON_GESTION                                                float8,
     NOM_BORNE                                                         varchar(255),
     X_POINT                                                           float8,
     Y_POINT                                                           float8,
     Z_POINT                                                           float8,
     FICTIVE                                                           bool,
     X_POINT_ORIGINE                                                   float8,
     Y_POINT_ORIGINE                                                   float8,
     PRIMARY KEY (ID_BORNE)
     );


CREATE TABLE SYS_REQUETES
     (
     CODE_REQUETE                                                       serial,
     NOM_REQUETE                                                       varchar(100),
     TEXTE_REQUETE                                                     text,
     PRIMARY KEY (CODE_REQUETE)
     );


CREATE TABLE SYS_REQUETES_INTERNES
     (
     CODE_REQUETE                                                       serial,
     NOM_REQUETE                                                       varchar(100),
     TEXTE_REQUETE                                                     text,
     PRIMARY KEY (CODE_REQUETE)
     );


CREATE TABLE SYS_REQUETES_PREPROGRAMMEES
     (
     NOM_TABLE_RESULTAT                                                varchar(255) NOT NULL,
     LIBELLE_REQUETE                                                   text,
     DESCRIPTION_RESULTAT                                              text,
     DATE_RESULTAT                                                     timestamp,
     PRIMARY KEY (NOM_TABLE_RESULTAT)
     );


CREATE TABLE SYS_RQ_EXTRAIT_DESORDRE_TGD
     (
     ID_DIGUE                                                          int8,
     LIBELLE_DIGUE                                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     NOM_TRONCON_GESTION                                               varchar(255),
     ID_DESORDRE                                                       int8,
     DESCRIPTION_DESORDRE                                              text,
     ID_TYPE_DESORDRE                                                  int8,
     LIBELLE_TYPE_DESORDRE                                             varchar(255),
     ID_TYPE_COTE                                                      int8,
     LIBELLE_TYPE_COTE                                                 varchar(255),
     ID_TYPE_POSITION                                                  int8,
     LIBELLE_TYPE_POSITION                                             varchar(255),
     ID_SOURCE                                                         int8,
     LIBELLE_SOURCE                                                    varchar(255),
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     DECALAGE                                                          float8,
     DECALAGE_DEFAUT                                                   float8,
     LIEU_DIT_DESORDRE                                                 varchar(255),
     ID_OBSERVATION                                                    int8,
     ID_TYPE_URGENCE                                                   int8,
     LIBELLE_TYPE_URGENCE                                              varchar(255),
     ID_INTERV_OBSERVATEUR                                             int8,
     Nom_Prenom_Observateur                                            varchar(255),
     DATE_OBSERVATION_DESORDRE                                         timestamp,
     SUITE_A_APPORTER                                                  text,
     EVOLUTIONS                                                        varchar(255),
     NBR_DESORDRE                                                      int8,
     DATE_DEBUT_SELECTIONNEE                                           timestamp,
     DATE_FIN_SELECTIONNEE                                             timestamp,
     PR_DEBUT_SELECTIONNE                                              float8,
     PR_FIN_SELECTIONNE                                                float8
     );


CREATE TABLE SYS_RQ_MONTANT_PRESTATION_TGD
     (
     ID_DIGUE                                                          int8,
     LIBELLE_DIGUE                                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     NOM_TRONCON_GESTION                                               varchar(255),
     ID_TYPE_PRESTATION                                                int8,
     LIBELLE_TYPE_PRESTATION                                           varchar(255),
     DATE_DEBUT_SELECTIONNEE                                           timestamp,
     DATE_FIN_SELECTIONNEE                                             timestamp,
     PR_DEBUT_SELECTIONNE                                              float8,
     PR_FIN_SELECTIONNE                                                float8,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     DECALAGE                                                          float8,
     DECALAGE_DEFAUT                                                   float8,
     Nbre_Prestation                                                   int8,
     Somme_Montant_Prestation                                          float8
     );


CREATE TABLE SYS_RQ_PROPRIETAIRE_TRAVERSEE_TGD
     (
     Nom_Proprietaire                                                  varchar(255),
     Type_proprietaire                                                 varchar(255),
     ID_PROPRIETAIRE                                                   int8,
     ID_DIGUE                                                          int8,
     LIBELLE_DIGUE                                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     NOM_TRONCON_GESTION                                               varchar(255),
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     DECALAGE                                                          float8,
     DECALAGE_DEFAUT                                                   float8,
     ID_ELEMENT_RESEAU                                                 int8,
     NOM                                                               varchar(255),
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     ID_TYPE_COTE                                                      int8,
     LIBELLE_TYPE_COTE                                                 varchar(255),
     ID_TYPE_POSITION                                                  int8,
     LIBELLE_TYPE_POSITION                                             varchar(255),
     DIAMETRE                                                          float8,
     ID_IMPLANTATION                                                   int8,
     LIBELLE_IMPLANTATION                                              varchar(255),
     ID_ECOULEMENT                                                     int8,
     LIBELLE_ECOULEMENT                                                varchar(255),
     ID_UTILISATION_CONDUITE                                           int8,
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     Autorise                                                          varchar(10),
     ID_SOURCE                                                         int8,
     LIBELLE_SOURCE                                                    varchar(255),
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     ID_CONVENTION                                                     int8,
     LIBELLE_CONVENTION                                                varchar(255)
     );


CREATE TABLE SYS_RQ_PROPRIETAIRE_TRAVERSEE_TMP
     (
     Nom_Proprietaire                                                  varchar(255),
     Type_proprietaire                                                 varchar(255),
     ID_PROPRIETAIRE                                                   int8,
     ID_DIGUE                                                          int8,
     LIBELLE_DIGUE                                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     NOM_TRONCON_GESTION                                               varchar(255),
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     DECALAGE                                                          float8,
     DECALAGE_DEFAUT                                                   float8,
     ID_ELEMENT_RESEAU                                                 int8,
     NOM                                                               varchar(255),
     ID_TYPE_CONDUITE_FERMEE                                           int8,
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     ID_TYPE_COTE                                                      int8,
     LIBELLE_TYPE_COTE                                                 varchar(255),
     ID_TYPE_POSITION                                                  int8,
     LIBELLE_TYPE_POSITION                                             varchar(255),
     DIAMETRE                                                          float8,
     ID_IMPLANTATION                                                   int8,
     LIBELLE_IMPLANTATION                                              varchar(255),
     ID_ECOULEMENT                                                     int8,
     LIBELLE_ECOULEMENT                                                varchar(255),
     ID_UTILISATION_CONDUITE                                           int8,
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     Autorise                                                          varchar(10),
     ID_SOURCE                                                         int8,
     LIBELLE_SOURCE                                                    varchar(255),
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     ID_CONVENTION                                                     int8,
     LIBELLE_CONVENTION                                                varchar(255)
     );


CREATE TABLE SYS_RQ_SENSIBILITE_EVT_HYDRAU_TGD
     (
     ID_DIGUE                                                          int8,
     LIBELLE_DIGUE                                                     varchar(255),
     ID_TRONCON_GESTION                                                int8,
     NOM_TRONCON_GESTION                                               varchar(255),
     ID_DOC                                                            int8,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     DECALAGE                                                          float8,
     DECALAGE_DEFAUT                                                   float8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_PROFIL_EN_TRAVERS_LEVE                                         int8,
     DATE_LEVE                                                         timestamp,
     CRETE_LARGEUR                                                     float8,
     CRETE_Z_NGF                                                       float8,
     COTE_TERRE_Z_NGF_PIED_DE_DIGUE                                    float8,
     ID_EVENEMENT_HYDRAU                                               int8,
     NOM_EVENEMENT_HYDRAU                                              varchar(255),
     COTE_EAU_NGF                                                      float8,
     hauteur_de_charge                                                 float8,
     hauteur_digue_sur_TN                                              float8,
     revanche_digue_sur_evt_hydrau                                     float8
     );


CREATE TABLE SYS_SEL_FE_FICHE_SUIVI_DESORDRE_TRONCON
     (
     SELECTIONNE                                                       bool,
     ID_TRONCON_GESTION                                                int8,
     PR_MIN_CALCULE                                                    float8,
     PR_MAX_CALCULE                                                    float8,
     PR_DEBUT_SELECTIONNE                                              float8,
     PR_FIN_SELECTIONNE                                                float8
     );


CREATE TABLE SYS_SEL_FE_FICHE_SUIVI_DESORDRE_TYPE_DESORDRE
     (
     ID_TYPE_DESORDRE                                                  int8,
     SELECTIONNE                                                       bool
     );


CREATE TABLE SYS_SEL_FE_RAPPORT_SYNTHE_GRAPHIQUE_LIGNE_EAU
     (
     ID_LIGNE_EAU                                                       serial,
     ID_EVENEMENT_HYDRAU                                               int8,
     ID_TRONCON_GESTION                                                int8,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     ID_TYPE_REF_HEAU                                                  int8,
     ID_SYSTEME_REP_PRZ                                                int8,
     DATE                                                              timestamp,
     COMMENTAIRE                                                       text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     ID_LIGNE_EAU_PRZ                                                  int8,
     ID_LIGNE_EAU_XYZ                                                  int8
     );


CREATE TABLE SYS_SEL_FE_RAPPORT_SYNTHE_GRAPHIQUE_PROFIL_EN_LONG
     (
     ID_DOC                                                             serial,
     ID_TRONCON_GESTION                                                int8,
     ID_TYPE_DOCUMENT                                                  int8,
     ID_DOSSIER                                                        int8,
     REFERENCE_PAPIER                                                  varchar(255),
     REFERENCE_NUMERIQUE                                               varchar(255),
     REFERENCE_CALQUE                                                  varchar(255),
     DATE_DOCUMENT                                                     timestamp,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     NOM                                                               varchar(255),
     ID_MARCHE                                                         int8,
     ID_INTERV_CREATEUR                                                int8,
     ID_ORG_CREATEUR                                                   int8,
     ID_ARTICLE_JOURNAL                                                int8,
     ID_PROFIL_EN_TRAVERS                                              int8,
     ID_PROFIL_EN_LONG                                                 int8,
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8,
     ID_CONVENTION                                                     int8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     AUTEUR_RAPPORT                                                    varchar(255),
     ID_RAPPORT_ETUDE                                                  int8,
     ID_PROFIL_EN_LONG_DZ                                              int8,
     ID_PROFIL_EN_LONG_XYZ                                             int8
     );


CREATE TABLE SYS_SEL_FE_RAPPORT_SYNTHE_GRAPHIQUE_TRONCON
     (
     SELECTIONNE                                                       bool,
     ID_TRONCON_GESTION                                                int8,
     PR_MIN_CALCULE                                                    float8,
     PR_MAX_CALCULE                                                    float8,
     PR_DEBUT_SELECTIONNE                                              float8,
     PR_FIN_SELECTIONNE                                                float8
     );


CREATE TABLE SYS_SEL_FE_RAPPORT_SYNTHE_GRAPHIQUE_TYPE_ATTRIBUT
     (
     ID_TYPE_DONNEE                                                    int8,
     ID_TYPE_COTE                                                      int8 NOT NULL,
     ID_TYPE_ATTRIBUT                                                  int8,
     SELECTIONNE                                                       bool,
     PRIMARY KEY (ID_TYPE_DONNEE, ID_TYPE_COTE, ID_TYPE_ATTRIBUT)
     );


CREATE TABLE SYS_SEL_FE_RAPPORT_SYNTHE_GRAPHIQUE_TYPE_DONNEE
     (
     ID_TYPE_DONNEE                                                    int8,
     ID_TYPE_DONNEE_2                                                  int8,
     LIBELLE_SELECTION_TYPE_DONNEE                                     varchar(255),
     SELECTIONNE                                                       bool,
     ID_OUI_NON_1                                                      bool,
     ID_OUI_NON_2                                                      bool,
     ID_OUI_NON_3                                                      bool,
     ID_OUI_NON_4                                                      bool,
     ID_OUI_NON_5                                                      bool
     );


CREATE TABLE SYS_SEL_RQ_EXTRAIT_DESORDRE_TRONCON
     (
     SELECTIONNE                                                       bool,
     ID_TRONCON_GESTION                                                int8,
     PR_MIN_CALCULE                                                    float8,
     PR_MAX_CALCULE                                                    float8,
     PR_DEBUT_SELECTIONNE                                              float8,
     PR_FIN_SELECTIONNE                                                float8
     );


CREATE TABLE SYS_SEL_RQ_EXTRAIT_DESORDRE_TYPE_DESORDRE
     (
     SELECTIONNE                                                       bool,
     ID_TYPE_DESORDRE                                                  int8
     );


CREATE TABLE SYS_SEL_RQ_MONTANT_PRESTATION_TRONCON
     (
     SELECTIONNE                                                       bool,
     ID_TRONCON_GESTION                                                int8,
     PR_MIN_CALCULE                                                    float8,
     PR_MAX_CALCULE                                                    float8,
     PR_DEBUT_SELECTIONNE                                              float8,
     PR_FIN_SELECTIONNE                                                float8
     );


CREATE TABLE SYS_SEL_RQ_MONTANT_PRESTATION_TYPE_PRESTATION
     (
     SELECTIONNE                                                       bool,
     ID_TYPE_PRESTATION                                                int8
     );


CREATE TABLE SYS_SEL_RQ_SENSIBILITE_EVT_HYDRAU_EVT_HYDRAU
     (
     SELECTIONNE                                                       bool,
     ID_EVENEMENT_HYDRAU                                                serial
     );


CREATE TABLE SYS_SEL_RQ_SENSIBILITE_EVT_HYDRAU_TRONCON
     (
     SELECTIONNE                                                       bool,
     ID_TRONCON_GESTION                                                int8,
     PR_MIN_CALCULE                                                    float8,
     PR_MAX_CALCULE                                                    float8,
     PR_DEBUT_SELECTIONNE                                              float8,
     PR_FIN_SELECTIONNE                                                float8
     );


CREATE TABLE SYS_SEL_TRONCON_GESTION_DIGUE
     (
     SELECTIONNE                                                       bool,
     ID_TRONCON_GESTION                                                int8,
     PR_MIN_CALCULE                                                    float8,
     PR_MAX_CALCULE                                                    float8,
     PR_DEBUT_SELECTIONNE                                              float8,
     PR_FIN_SELECTIONNE                                                float8
     );


CREATE TABLE SYS_SEL_TRONCON_GESTION_DIGUE_TMP
     (
     SELECTIONNE                                                       bool,
     ID_TRONCON_GESTION                                                int8,
     PR_MIN_CALCULE                                                    float8,
     PR_MAX_CALCULE                                                    float8,
     PR_DEBUT_SELECTIONNE                                              float8,
     PR_FIN_SELECTIONNE                                                float8
     );


CREATE TABLE SYS_SEL_TYPE_DONNEES_SOUS_GROUPE
     (
     ID_GROUPE_DONNEES                                                 int8,
     ID_SOUS_GROUPE_DONNEES                                            int8,
     SELECTIONNE                                                       bool
     );


CREATE TABLE SYS_VEGETATION_TMP
     (
     ID_ELEMENT_STRUCTURE                                              int8,
     id_nom_element                                                    varchar(255),
     ID_SOUS_GROUPE_DONNEES                                            int8,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     DECALAGE_DEFAUT                                                   float8,
     DECALAGE                                                          float8,
     LIBELLE_SOURCE                                                    varchar(255),
     LIBELLE_TYPE_COTE                                                 varchar(255),
     LIBELLE_SYSTEME_REP                                               varchar(255),
     NOM_BORNE_DEBUT                                                   varchar(255),
     NOM_BORNE_FIN                                                     varchar(255),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     LIBELLE_TYPE_NATURE_HAUT                                          varchar(255),
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     ID_TRONCON_GESTION                                                int8,
     DATE_DEBUT_VAL                                                    timestamp,
     DATE_FIN_VAL                                                      timestamp,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     Y_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_FIN                                                             float8,
     ID_SYSTEME_REP                                                    int8,
     ID_BORNEREF_DEBUT                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     DIST_BORNEREF_DEBUT                                               float8,
     ID_BORNEREF_FIN                                                   float8,
     AMONT_AVAL_FIN                                                    bool,
     DIST_BORNEREF_FIN                                                 float8,
     COMMENTAIRE                                                       text,
     N_COUCHE                                                          int8,
     ID_TYPE_MATERIAU                                                  int8,
     ID_TYPE_NATURE                                                    int8,
     ID_TYPE_FONCTION                                                  int8,
     EPAISSEUR                                                         float8,
     TALUS_INTERCEPTE_CRETE                                            int8,
     ID_TYPE_NATURE_HAUT                                               int8,
     ID_TYPE_MATERIAU_HAUT                                             int8,
     ID_TYPE_MATERIAU_BAS                                              int8,
     ID_TYPE_NATURE_BAS                                                int8,
     LONG_RAMP_HAUT                                                    float8,
     LONG_RAMP_BAS                                                     float8,
     PENTE_INTERIEURE                                                  float8,
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8,
     ID_TYPE_POSITION                                                  int8,
     ID_ORG_PROPRIO                                                    int8,
     ID_ORG_GESTION                                                    int8,
     ID_INTERV_PROPRIO                                                 int8,
     ID_INTERV_GARDIEN                                                 int8,
     DATE_DEBUT_ORGPROPRIO                                             timestamp,
     DATE_FIN_ORGPROPRIO                                               timestamp,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DEBUT_INTERVPROPRIO                                          timestamp,
     DATE_FIN_INTERVPROPRIO                                            timestamp,
     ID_TYPE_COMPOSITION                                               int8,
     DISTANCE_TRONCON                                                  float8,
     LONGUEUR                                                          float8,
     DATE_DEBUT_GARDIEN                                                timestamp,
     DATE_FIN_GARDIEN                                                  timestamp,
     LONGUEUR_PERPENDICULAIRE                                          float8,
     LONGUEUR_PARALLELE                                                float8,
     COTE_AXE                                                          int8,
     ID_TYPE_VEGETATION                                                int8,
     HAUTEUR                                                           float8,
     DIAMETRE                                                          varchar(10),
     DENSITE                                                           varchar(10),
     EPAISSEUR_Y11                                                     varchar(10),
     EPAISSEUR_Y12                                                     varchar(10),
     EPAISSEUR_Y21                                                     varchar(10),
     EPAISSEUR_Y22                                                     varchar(10)
     );


CREATE TABLE SYSTEME_REP_LINEAIRE
     (
     ID_SYSTEME_REP                                                     serial,
     ID_TRONCON_GESTION                                                int8,
     LIBELLE_SYSTEME_REP                                               varchar(255),
     COMMENTAIRE_SYSTEME_REP                                           text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_SYSTEME_REP)
     );


CREATE TABLE TRONCON_GESTION_DIGUE
     (
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     ID_ORG_GESTIONNAIRE                                               int8,
     ID_DIGUE                                                          int8,
     ID_TYPE_RIVE                                                      int8 NOT NULL,
     DATE_DEBUT_VAL_TRONCON                                            timestamp,
     DATE_FIN_VAL_TRONCON                                              timestamp,
     NOM_TRONCON_GESTION                                               varchar(255),
     COMMENTAIRE_TRONCON                                               text,
     DATE_DEBUT_VAL_GESTIONNAIRE_D                                     timestamp,
     DATE_FIN_VAL_GESTIONNAIRE_D                                       timestamp,
     ID_SYSTEME_REP_DEFAUT                                             int8,
     LIBELLE_TRONCON_GESTION                                           varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TRONCON_GESTION)
     );


CREATE TABLE TRONCON_GESTION_DIGUE_COMMUNE
     (
     ID_TRONCON_COMMUNE                                                 serial,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     ID_COMMUNE                                                        int8 NOT NULL,
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     ID_TYPE_COTE                                                      int8,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_DEBUT                                                           float8,
     Y_FIN                                                             float8,
     ID_BORNEREF_DEBUT                                                 float8,
     ID_BORNEREF_FIN                                                   float8,
     ID_SYSTEME_REP                                                    int8,
     DIST_BORNEREF_DEBUT                                               float8,
     DIST_BORNEREF_FIN                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     AMONT_AVAL_FIN                                                    bool,
     COMMENTAIRE                                                       text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TRONCON_COMMUNE)
     );


CREATE TABLE TRONCON_GESTION_DIGUE_GESTIONNAIRE
     (
     ID_TRONCON_GESTION                                                int8,
     ID_ORG_GESTION                                                    int8,
     DATE_DEBUT_GESTION                                                timestamp,
     DATE_FIN_GESTION                                                  timestamp,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TRONCON_GESTION, ID_ORG_GESTION, DATE_DEBUT_GESTION)
     );


CREATE TABLE TRONCON_GESTION_DIGUE_SITUATION_FONCIERE
     (
     ID_TRONCON_SITUATION_FONCIERE                                      serial,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     ID_TYPE_SITUATION_FONCIERE                                        int8 NOT NULL,
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     ID_TYPE_COTE                                                      int8,
     ID_SOURCE                                                         int8,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_DEBUT                                                           float8,
     Y_FIN                                                             float8,
     ID_BORNEREF_DEBUT                                                 int8,
     ID_BORNEREF_FIN                                                   int8,
     ID_SYSTEME_REP                                                    int8,
     DIST_BORNEREF_DEBUT                                               float8,
     DIST_BORNEREF_FIN                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     AMONT_AVAL_FIN                                                    bool,
     COMMENTAIRE                                                       text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TRONCON_SITUATION_FONCIERE)
     );


CREATE TABLE TRONCON_GESTION_DIGUE_SYNDICAT
     (
     ID_TRONCON_SYNDICAT                                                serial,
     ID_TRONCON_GESTION                                                int8 NOT NULL,
     ID_SYNDICAT                                                       int8 NOT NULL,
     DATE_DEBUT                                                        timestamp,
     DATE_FIN                                                          timestamp,
     ID_TYPE_COTE                                                      int8,
     PR_DEBUT_CALCULE                                                  float8,
     PR_FIN_CALCULE                                                    float8,
     X_DEBUT                                                           float8,
     X_FIN                                                             float8,
     Y_DEBUT                                                           float8,
     Y_FIN                                                             float8,
     ID_BORNEREF_DEBUT                                                 float8,
     ID_BORNEREF_FIN                                                   float8,
     ID_SYSTEME_REP                                                    int8,
     DIST_BORNEREF_DEBUT                                               float8,
     DIST_BORNEREF_FIN                                                 float8,
     AMONT_AVAL_DEBUT                                                  bool,
     AMONT_AVAL_FIN                                                    bool,
     COMMENTAIRE                                                       text,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TRONCON_SYNDICAT)
     );


CREATE TABLE TYPE_COMPOSITION
     (
     ID_TYPE_COMPOSITION                                               int8 NOT NULL,
     LIBELLE_TYPE_COMPOSITION                                          varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_COMPOSITION)
     );


CREATE TABLE TYPE_CONDUITE_FERMEE
     (
     ID_TYPE_CONDUITE_FERMEE                                           int8 NOT NULL,
     LIBELLE_TYPE_CONDUITE_FERMEE                                      varchar(255),
     ABREGE_TYPE_CONDUITE_FERMEE                                       varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_CONDUITE_FERMEE)
     );


CREATE TABLE TYPE_CONVENTION
     (
     ID_TYPE_CONVENTION                                                int8 NOT NULL,
     LIBELLE_TYPE_CONVENTION                                           varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_CONVENTION)
     );


CREATE TABLE TYPE_COTE
     (
     ID_TYPE_COTE                                                      int8 NOT NULL,
     LIBELLE_TYPE_COTE                                                 varchar(255),
     ABREGE_TYPE_COTE                                                  varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_COTE)
     );


CREATE TABLE TYPE_DESORDRE
     (
     ID_TYPE_DESORDRE                                                  int8 NOT NULL,
     LIBELLE_TYPE_DESORDRE                                             varchar(255),
     ABREGE_TYPE_DESORDRE                                              varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_DESORDRE)
     );


CREATE TABLE TYPE_DEVERS
     (
     ID_TYPE_DEVERS                                                    int8 NOT NULL,
     LIBELLE_TYPE_DEVERS                                               varchar(255),
     ABREGE_TYPE_DEVERS                                                varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_DEVERS)
     );


CREATE TABLE TYPE_DISTANCE_DIGUE_BERGE
     (
     ID_TYPE_DIST_DIGUE_BERGE                                          int8 NOT NULL,
     ABREGE_TYPE_DIST_DIGUE_BERGE                                      varchar(10),
     LIBELLE_TYPE_DIST_DIGUE_BERGE                                     varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_DIST_DIGUE_BERGE)
     );


CREATE TABLE TYPE_DOCUMENT
     (
     ID_TYPE_DOCUMENT                                                  int8 NOT NULL,
     LIBELLE_TYPE_DOCUMENT                                             varchar(255),
     ID_TYPE_GENERAL_DOCUMENT                                          int8,
     NOM_TABLE_EVT                                                     varchar(50),
     ID_TYPE_OBJET_CARTO                                               int4 DEFAULT 0,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_DOCUMENT)
     );


CREATE TABLE TYPE_DOCUMENT_A_GRANDE_ECHELLE
     (
     ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE                                 int8 NOT NULL,
     LIBELLE_TYPE_DOCUMENT_A_GRANDE_ECHELLE                            varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_DOCUMENT_A_GRANDE_ECHELLE)
     );


CREATE TABLE TYPE_DOCUMENT_DECALAGE
     (
     ID_TYPE_DOCUMENT                                                  int8,
     SIGNE                                                             varchar(1),
     DECALAGE                                                          float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_DOCUMENT)
     );


CREATE TABLE TYPE_DONNEES_GROUPE
     (
     ID_GROUPE_DONNEES                                                 int8 NOT NULL,
     LIBELLE_GROUPE_DONNEES                                            varchar(255),
     NOM_TABLE_DONNEES                                                 varchar(100),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_GROUPE_DONNEES)
     );


CREATE TABLE TYPE_DONNEES_SOUS_GROUPE
     (
     ID_GROUPE_DONNEES                                                 int8,
     ID_SOUS_GROUPE_DONNEES                                            int8 NOT NULL,
     ID_TYPE_DONNEE                                                    int8,
     LIBELLE_SOUS_GROUPE_DONNEES                                       varchar(255),
     NOM_TABLE_EVT                                                     varchar(50),
     ID_TYPE_OBJET_CARTO                                               int4,
     DECALAGE                                                          float8,
     DATE_DERNIERE_MAJ                                                 timestamp,
     UNIQUE (ID_TYPE_DONNEE),
     PRIMARY KEY (ID_GROUPE_DONNEES, ID_SOUS_GROUPE_DONNEES)
     );


CREATE TABLE TYPE_DVPT_VEGETATION
     (
     ID_TYPE_VEGETATION                                                int8 NOT NULL,
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ABREGE_TYPE_VEGETATION                                            varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_VEGETATION)
     );


CREATE TABLE TYPE_ELEMENT_GEOMETRIE
     (
     ID_TYPE_ELEMENT_GEOMETRIE                                         int8 NOT NULL,
     LIBELLE_TYPE_ELEMENT_GEOMETRIE                                    varchar(255),
     NOM_TABLE_EVT                                                     varchar(50),
     ID_TYPE_OBJET_CARTO                                               int4 DEFAULT 0,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_ELEMENT_GEOMETRIE)
     );


CREATE TABLE TYPE_ELEMENT_RESEAU
     (
     ID_TYPE_ELEMENT_RESEAU                                            int8 NOT NULL,
     LIBELLE_TYPE_ELEMENT_RESEAU                                       varchar(255),
     NOM_TABLE_EVT                                                     varchar(50),
     ID_TYPE_OBJET_CARTO                                               int4 DEFAULT 0,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_ELEMENT_RESEAU)
     );


CREATE TABLE TYPE_ELEMENT_RESEAU_COTE
     (
     ID_TYPE_ELEMENT_RESEAU                                            int8,
     ID_TYPE_COTE                                                      int8,
     SIGNE                                                             varchar(1),
     DECALAGE                                                          float8,
     DATE_DERNIERE_MAJ                                                 timestamp
     );


CREATE TABLE TYPE_ELEMENT_STRUCTURE
     (
     ID_TYPE_ELEMENT_STRUCTURE                                         int8 NOT NULL,
     LIBELLE_TYPE_ELEMENT_STRUCTURE                                    varchar(255),
     NOM_TABLE_EVT                                                     varchar(50),
     ID_TYPE_OBJET_CARTO                                               int4 DEFAULT 0,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_ELEMENT_STRUCTURE)
     );


CREATE TABLE TYPE_ELEMENT_STRUCTURE_COTE
     (
     ID_TYPE_ELEMENT_STRUCTURE                                         int8,
     ID_TYPE_COTE                                                      int8,
     SIGNE                                                             varchar(1),
     DECALAGE                                                          float8,
     DATE_DERNIERE_MAJ                                                 timestamp
     );


CREATE TABLE TYPE_EMPRISE_PARCELLE
     (
     ID_TYPE_EMPRISE_PARCELLE                                          int8 NOT NULL,
     ABREGE_TYPE_EMPRISE                                               varchar(10),
     LIBELLE_TYPE_EMPRISE                                              varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_EMPRISE_PARCELLE)
     );


CREATE TABLE TYPE_EVENEMENT_HYDRAU
     (
     ID_TYPE_EVENEMENT_HYDRAU                                          int8 NOT NULL,
     ABREGE_TYPE_EVENEMENT_HYDRAU                                      varchar(10),
     LIBELLE_TYPE_EVENEMENT_HYDRAU                                     varchar(255),
     NOM_TABLE_EVT                                                     varchar(50),
     ID_TYPE_OBJET_CARTO                                               int4 DEFAULT 0,
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_EVENEMENT_HYDRAU)
     );


CREATE TABLE TYPE_FONCTION
     (
     ID_TYPE_FONCTION                                                  int8 NOT NULL,
     LIBELLE_TYPE_FONCTION                                             varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_FONCTION)
     );


CREATE TABLE TYPE_FONCTION_MO
     (
     ID_FONCTION_MO                                                    int8 NOT NULL,
     LIBELLE_FONCTION_MO                                               varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_FONCTION_MO)
     );


CREATE TABLE TYPE_FREQUENCE_EVENEMENT_HYDRAU
     (
     ID_TYPE_FREQUENCE_EVENEMENT_HYDRAU                                int8 NOT NULL,
     LIBELLE_TYPE_FREQUENCE_EVENEMENT_HYDRAU                           varchar(255),
     ABREGE_TYPE_FREQUENCE_EVENEMENT_HYDRAU                            varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_FREQUENCE_EVENEMENT_HYDRAU)
     );


CREATE TABLE TYPE_GENERAL_DOCUMENT
     (
     ID_TYPE_GENERAL_DOCUMENT                                          int8 NOT NULL,
     LIBELLE_TYPE_GENERAL_DOCUMENT                                     varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_GENERAL_DOCUMENT)
     );


CREATE TABLE TYPE_GLISSIERE
     (
     ID_TYPE_GLISSIERE                                                 int8 NOT NULL,
     LIBELLE_TYPE_GLISSIERE                                            varchar(255),
     ABREGE_TYPE_GLISSIERE                                             varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_GLISSIERE)
     );


CREATE TABLE TYPE_LARGEUR_FRANC_BORD
     (
     ID_TYPE_LARGEUR_FB                                                int8 NOT NULL,
     ABREGE_TYPE_LARGEUR_FB                                            varchar(10),
     LIBELLE_TYPE_LARGEUR_FB                                           varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_LARGEUR_FB)
     );


CREATE TABLE TYPE_MATERIAU
     (
     ID_TYPE_MATERIAU                                                  int8 NOT NULL,
     ABREGE_TYPE_MATERIAU                                              varchar(10),
     LIBELLE_TYPE_MATERIAU                                             varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_MATERIAU)
     );


CREATE TABLE TYPE_MOYEN_MANIP_BATARDEAUX
     (
     ID_TYPE_MOYEN_MANIP_BATARDEAUX                                    int8 NOT NULL,
     LIBELLE_TYPE_MOYEN_MANIP_BATARDEAUX                               varchar(255),
     ABREGE_TYPE_MOYEN_MANIP_BATARDEAUX                                varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_MOYEN_MANIP_BATARDEAUX)
     );


CREATE TABLE TYPE_NATURE
     (
     ID_TYPE_NATURE                                                    int8 NOT NULL,
     ABREGE_TYPE_NATURE                                                varchar(10),
     LIBELLE_TYPE_NATURE                                               varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_NATURE)
     );


CREATE TABLE TYPE_NATURE_BATARDEAUX
     (
     ID_TYPE_NATURE_BATARDEAUX                                         int8 NOT NULL,
     LIBELLE_TYPE_NATURE_BATARDEAUX                                    varchar(255),
     ABREGE_TYPE_NATURE_BATARDEAUX                                     varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_NATURE_BATARDEAUX)
     );


CREATE TABLE TYPE_ORGANISME
     (
     ID_TYPE_ORGANISME                                                 int8 NOT NULL,
     ID_ORGANISME                                                      int8,
     LIBELLE_TYPE_ORGANISME                                            varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_ORGANISME)
     );


CREATE TABLE TYPE_ORIENTATION_OUVRAGE_FRANCHISSEMENT
     (
     ID_TYPE_ORIENTATION_OUVRAGE_FRANCHISSEMENT                        int8 NOT NULL,
     LIBELLE_TYPE_ORIENTATION_OUVRAGE_FRANCHISSEMENT                   varchar(255),
     ABREGE_TYPE_ORIENTATION_OUVRAGE_FRANCHISSEMENT                    varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_ORIENTATION_OUVRAGE_FRANCHISSEMENT)
     );


CREATE TABLE TYPE_ORIENTATION_VENT
     (
     ID_TYPE_ORIENTATION_VENT                                          int8 NOT NULL,
     LIBELLE_TYPE_ORIENTATION_VENT                                     varchar(255),
     ABREGE_TYPE_ORIENTATION_VENT                                      varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_ORIENTATION_VENT)
     );


CREATE TABLE TYPE_ORIGINE_PROFIL_EN_LONG
     (
     ID_TYPE_ORIGINE_PROFIL_EN_LONG                                    int8 NOT NULL,
     LIBELLE_TYPE_ORIGINE_PROFIL_EN_LONG                               varchar(255),
     ABREGE_TYPE_ORIGINE_PROFIL_EN_LONG                                varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_ORIGINE_PROFIL_EN_LONG)
     );


CREATE TABLE TYPE_ORIGINE_PROFIL_EN_TRAVERS
     (
     ID_TYPE_ORIGINE_PROFIL_EN_TRAVERS                                 int8 NOT NULL,
     LIBELLE_TYPE_ORIGINE_PROFIL_EN_TRAVERS                            varchar(255),
     ABREGE_TYPE_ORIGINE_PROFIL_EN_TRAVERS                             varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_ORIGINE_PROFIL_EN_TRAVERS)
     );


CREATE TABLE TYPE_OUVRAGE_FRANCHISSEMENT
     (
     ID_TYPE_OUVRAGE_FRANCHISSEMENT                                    int8 NOT NULL,
     LIBELLE_TYPE_OUVRAGE_FRANCHISSEMENT                               varchar(255),
     ABREGE_TYPE_OUVRAGE_FRANCHISSEMENT                                varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_OUVRAGE_FRANCHISSEMENT)
     );


CREATE TABLE TYPE_OUVRAGE_HYDRAU_ASSOCIE
     (
     ID_TYPE_OUVR_HYDRAU_ASSOCIE                                       int8 NOT NULL,
     LIBELLE_TYPE_OUVR_HYDRAU_ASSOCIE                                  varchar(255),
     ABREGE_TYPE_OUVR_HYDRAU_ASSOCIE                                   varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_OUVR_HYDRAU_ASSOCIE)
     );


CREATE TABLE TYPE_OUVRAGE_PARTICULIER
     (
     ID_TYPE_OUVRAGE_PARTICULIER                                       int8 NOT NULL,
     LIBELLE_TYPE_OUVRAGE_PARTICULIER                                  varchar(255),
     ABREGE_TYPE_OUVRAGE_PARTICULIER                                   varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_OUVRAGE_PARTICULIER)
     );


CREATE TABLE TYPE_OUVRAGE_TELECOM_NRJ
     (
     ID_TYPE_OUVRAGE_TELECOM_NRJ                                       int8 NOT NULL,
     ABREGE_TYPE_OUVRAGE_TELECOM_NRJ                                   varchar(10),
     LIBELLE_TYPE_OUVRAGE_TELECOM_NRJ                                  varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_OUVRAGE_TELECOM_NRJ)
     );


CREATE TABLE TYPE_OUVRAGE_VOIRIE
     (
     ID_TYPE_OUVRAGE_VOIRIE                                            int8 NOT NULL,
     LIBELLE_TYPE_OUVRAGE_VOIRIE                                       varchar(255),
     ABREGE_TYPE_OUVRAGE_VOIRIE                                        varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_OUVRAGE_VOIRIE)
     );


CREATE TABLE TYPE_POSITION
     (
     ID_TYPE_POSITION                                                  int8 NOT NULL,
     LIBELLE_TYPE_POSITION                                             varchar(255),
     ABREGE_TYPE_POSITION                                              varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_POSITION)
     );


CREATE TABLE TYPE_POSITION_PROFIL_EN_LONG_SUR_DIGUE
     (
     ID_TYPE_POSITION_PROFIL_EN_LONG                                   int8 NOT NULL,
     LIBELLE_TYPE_POSITION_PROFIL_EN_LONG                              varchar(255),
     ABREGE_TYPE_POSITION_PROFIL_EN_LONG                               varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_POSITION_PROFIL_EN_LONG)
     );


CREATE TABLE TYPE_POSITION_SUR_DIGUE
     (
     ID_TYPE_POSITION_SUR_DIGUE                                        int8 NOT NULL,
     LIBELLE_TYPE_POSITION_SUR_DIGUE                                   varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_POSITION_SUR_DIGUE)
     );


CREATE TABLE TYPE_PRESTATION
     (
     ID_TYPE_PRESTATION                                                int8 NOT NULL,
     LIBELLE_TYPE_PRESTATION                                           varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_PRESTATION)
     );


CREATE TABLE TYPE_PROFIL_EN_TRAVERS
     (
     ID_TYPE_PROFIL_EN_TRAVERS                                         int8 NOT NULL,
     LIBELLE_TYPE_PROFIL_EN_TRAVERS                                    varchar(255),
     ABREGE_TYPE_PROFIL_EN_TRAVERS                                     varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_PROFIL_EN_TRAVERS)
     );


CREATE TABLE TYPE_PROFIL_FRANC_BORD
     (
     ID_TYPE_PROFIL_FB                                                 int8 NOT NULL,
     ABREGE_TYPE_PROFIL_FB                                             varchar(10),
     LIBELLE_TYPE_PROFIL_FB                                            varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_PROFIL_FB)
     );


CREATE TABLE TYPE_PROPRIETAIRE
     (
     ID_TYPE_PROPRIETAIRE                                              int8 NOT NULL,
     LIBELLE_TYPE_PROPRIETAIRE                                         varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_PROPRIETAIRE)
     );


CREATE TABLE TYPE_RAPPORT_ETUDE
     (
     ID_TYPE_RAPPORT_ETUDE                                             int8 NOT NULL,
     LIBELLE_TYPE_RAPPORT_ETUDE                                        varchar(255),
     ABREGE_TYPE_RAPPORT_ETUDE                                         varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_RAPPORT_ETUDE)
     );


CREATE TABLE TYPE_REF_HEAU
     (
     ID_TYPE_REF_HEAU                                                  int8 NOT NULL,
     ABREGE_TYPE_REF_HEAU                                              varchar(10),
     LIBELLE_TYPE_REF_HEAU                                             varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_REF_HEAU)
     );


CREATE TABLE TYPE_RESEAU_EAU
     (
     ID_TYPE_RESEAU_EAU                                                int8 NOT NULL,
     LIBELLE_TYPE_RESEAU_EAU                                           varchar(255),
     ABREGE_TYPE_RESEAU_EAU                                            varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_RESEAU_EAU)
     );


CREATE TABLE TYPE_RESEAU_TELECOMMUNIC
     (
     ID_TYPE_RESEAU_COMMUNICATION                                      int8 NOT NULL,
     LIBELLE_TYPE_RESEAU_COMMUNICATION                                 varchar(255),
     ABREGE_TYPE_RESEAU_COMMUNICATION                                  varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_RESEAU_COMMUNICATION)
     );


CREATE TABLE TYPE_REVETEMENT
     (
     ID_TYPE_REVETEMENT                                                int8 NOT NULL,
     LIBELLE_TYPE_REVETEMENT                                           varchar(255),
     ABREGE_TYPE_REVETEMENT                                            varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_REVETEMENT)
     );


CREATE TABLE TYPE_RIVE
     (
     ID_TYPE_RIVE                                                      int8 NOT NULL,
     LIBELLE_TYPE_RIVE                                                 varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_RIVE)
     );


CREATE TABLE TYPE_SERVITUDE
     (
     ID_TYPE_SERVITUDE                                                 int8 NOT NULL,
     LIBELLE_TYPE_SERVITUDE                                            varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_SERVITUDE)
     );


CREATE TABLE TYPE_SEUIL
     (
     ID_TYPE_SEUIL                                                     int8 NOT NULL,
     LIBELLE_TYPE_SEUIL                                                varchar(255),
     ABREGE_TYPE_SEUIL                                                 varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_SEUIL)
     );


CREATE TABLE TYPE_SIGNATAIRE
     (
     ID_TYPE_SIGNATAIRE                                                int8 NOT NULL,
     LIBELLE_TYPE_SIGNATAIRE                                           varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_SIGNATAIRE)
     );


CREATE TABLE TYPE_SITUATION_FONCIERE
     (
     ID_TYPE_SITUATION_FONCIERE                                        int8 NOT NULL,
     LIBELLE_TYPE_SITUATION_FONCIERE                                   varchar(255),
     ABREGE_TYPE_SITUATION_FONCIERE                                    varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_SITUATION_FONCIERE)
     );


CREATE TABLE TYPE_SYSTEME_RELEVE_PROFIL
     (
     ID_TYPE_SYSTEME_RELEVE_PROFIL                                     int8 NOT NULL,
     LIBELLE_TYPE_SYSTEME_RELEVE_PROFIL                                varchar(255),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_SYSTEME_RELEVE_PROFIL)
     );


CREATE TABLE TYPE_URGENCE
     (
     ID_TYPE_URGENCE                                                   int8 NOT NULL,
     LIBELLE_TYPE_URGENCE                                              varchar(255),
     ABREGE_TYPE_URGENCE                                               varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_URGENCE)
     );


CREATE TABLE TYPE_USAGE_VOIE
     (
     ID_TYPE_USAGE_VOIE                                                int8 NOT NULL,
     LIBELLE_TYPE_USAGE_VOIE                                           varchar(255),
     ABREGE_TYPE_USAGE_VOIE                                            varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_USAGE_VOIE)
     );


CREATE TABLE TYPE_VEGETATION
     (
     ID_TYPE_VEGETATION                                                int8 NOT NULL,
     LIBELLE_TYPE_VEGETATION                                           varchar(255),
     ABREGE_TYPE_VEGETATION                                            varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_VEGETATION)
     );


CREATE TABLE TYPE_VEGETATION_ABONDANCE
     (
     ID_TYPE_VEGETATION_ABONDANCE                                      int8 NOT NULL,
     LIBELLE_TYPE_VEGETATION_ABONDANCE                                 varchar(255),
     ABREGE_TYPE_VEGETATION_ABONDANCE                                  varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_VEGETATION_ABONDANCE)
     );


CREATE TABLE TYPE_VEGETATION_ABONDANCE_BRAUN_BLANQUET
     (
     ID_TYPE_VEGETATION_ABONDANCE_BRAUN_BLANQUET                       int8 NOT NULL,
     LIBELLE_TYPE_VEGETATION_ABONDANCE_BRAUN_BLANQUET                  varchar(255),
     ABREGE_TYPE_VEGETATION_ABONDANCE_BRAUN_BLANQUET                   varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_VEGETATION_ABONDANCE_BRAUN_BLANQUET)
     );


CREATE TABLE TYPE_VEGETATION_ESSENCE
     (
     ID_TYPE_VEGETATION_ESSENCE                                        int8 NOT NULL,
     LIBELLE_TYPE_VEGETATION_ESSENCE                                   varchar(255),
     ABREGE_TYPE_VEGETATION_ESSENCE                                    varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_VEGETATION_ESSENCE)
     );


CREATE TABLE TYPE_VEGETATION_ETAT_SANITAIRE
     (
     ID_TYPE_VEGETATION_ETAT_SANITAIRE                                 int8 NOT NULL,
     LIBELLE_TYPE_VEGETATION_ETAT_SANITAIRE                            varchar(255),
     ABREGE_TYPE_VEGETATION_ETAT_SANITAIRE                             varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_VEGETATION_ETAT_SANITAIRE)
     );


CREATE TABLE TYPE_VEGETATION_STRATE_DIAMETRE
     (
     ID_TYPE_VEGETATION_STRATE_DIAMETRE                                int8 NOT NULL,
     LIBELLE_TYPE_VEGETATION_STRATE_DIAMETRE                           varchar(255),
     ABREGE_TYPE_VEGETATION_STRATE_DIAMETRE                            varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_VEGETATION_STRATE_DIAMETRE)
     );


CREATE TABLE TYPE_VEGETATION_STRATE_HAUTEUR
     (
     ID_TYPE_VEGETATION_STRATE_HAUTEUR                                 int8 NOT NULL,
     LIBELLE_TYPE_VEGETATION_STRATE_HAUTEUR                            varchar(255),
     ABREGE_TYPE_VEGETATION_STRATE_HAUTEUR                             varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_VEGETATION_STRATE_HAUTEUR)
     );


CREATE TABLE TYPE_VOIE_SUR_DIGUE
     (
     ID_TYPE_VOIE_SUR_DIGUE                                            int8 NOT NULL,
     LIBELLE_TYPE_VOIE_SUR_DIGUE                                       varchar(255),
     ABREGE_TYPE_VOIE_SUR_DIGUE                                        varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_TYPE_VOIE_SUR_DIGUE)
     );


CREATE TABLE UTILISATION_CONDUITE
     (
     ID_UTILISATION_CONDUITE                                           int8 NOT NULL,
     LIBELLE_UTILISATION_CONDUITE                                      varchar(255),
     ABREGE_UTILISATION_CONDUITE                                       varchar(10),
     DATE_DERNIERE_MAJ                                                 timestamp,
     PRIMARY KEY (ID_UTILISATION_CONDUITE)
     );

