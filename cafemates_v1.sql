# SETUP TIMEZONE

# 1. At the first, see all sql mode
SELECT @@sql_mode;

# 1. At the first, see all GLOBAL sql mode
SELECT @@GLOBAL.sql_mode;

# 3. SET sql mode
SET @@sql_mode='no_engine_substitution';
# OR
SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION';

# 4. SET sql mode GLOBAL
SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';

# IN GCP(GOOGLE CLOUD PLATFORM) => Just open the settings/configuration and set DATABASE FLAGS sections
# to sql_mode = NO_ENGINE_SUBTITUTION
# More information here: https://stackoverflow.com/questions/26492610/change-google-cloud-sql-current-timestamp-time-zone


CREATE TABLE religion (
    id int AUTO_INCREMENT PRIMARY KEY,
    name varchar(50) NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE gender_interests (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    interested_gender ENUM ('Male',
        'Female',
        'Custom'),
    user_id int NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE favorites (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name varchar(255) NOT NULL,
    description text,
    icon_url VARCHAR(255), 
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE companies (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name varchar(255) NOT NULL,
    country_id smallint (5) unsigned NOT NULL,
    region_id int (11) unsigned,
    city_id int (11) unsigned,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES countries (id),
    FOREIGN KEY (region_id) REFERENCES regions (id),
    FOREIGN KEY (city_id) REFERENCES cities (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE school (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name varchar(255) NOT NULL,
    country_id smallint (5) unsigned NOT NULL,
    region_id int (11) unsigned,
    city_id int (11) unsigned,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES countries (id),
    FOREIGN KEY (region_id) REFERENCES regions (id),
    FOREIGN KEY (city_id) REFERENCES cities (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE places (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    latitude DECIMAL (10,
        8) NOT NULL,
    longitude DECIMAL (11,
        8) NOT NULL,
    country_id smallint (5) unsigned NOT NULL,
    region_id int (11) unsigned,
    city_id int (11) unsigned,
    address VARCHAR(255) NOT NULL,
    cross_street VARCHAR(255) NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES countries (id),
    FOREIGN KEY (region_id) REFERENCES regions (id),
    FOREIGN KEY (city_id) REFERENCES cities (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE users (
    id int AUTO_INCREMENT PRIMARY KEY,
    firstname varchar(25) NOT NULL,
    lastname varchar(25) NOT NULL,
    email varchar(100) UNIQUE NOT NULL,
    username varchar(50) UNIQUE NOT NULL,
    phone_number varchar(20),
    password VARCHAR(255) NOT NULL,
    token VARCHAR(255),
    instagram varchar(255),
    facebook VARCHAR(255),
    google VARCHAR(255),
    avatar_url_thumbnail VARCHAR(255),
    avatar_url_show VARCHAR(255),
    birthdate TIMESTAMP,
    language ENUM ('English',
        'Bahasa')
    DEFAULT 'Bahasa',
    country_id smallint (5) unsigned NOT NULL,
    region_id int (11) unsigned,
    city_id int (11) unsigned,
    religion_id int,
    gender ENUM ('Male',
        'Female',
        'Custom'),
    is_verification bool
    DEFAULT FALSE,
    is_active bool
    DEFAULT TRUE,
    is_online bool
    DEFAULT FALSE,
    is_premium bool
    DEFAULT FALSE,
    is_blocked bool
    DEFAULT FALSE,
    created_at datetime
    DEFAULT CURRENT_TIMESTAMP,
    last_login_date datetime
    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (religion_id) REFERENCES religion (id),
    FOREIGN KEY (country_id) REFERENCES countries (id),
    FOREIGN KEY (region_id) REFERENCES regions (id),
    FOREIGN KEY (city_id) REFERENCES cities (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE authentication

CREATE TABLE photos (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id int NOT NULL,
    post_id int NOT NULL,
    photo_url varchar(255) NOT NULL,
    thumbnail_url varchar(255) NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE users_favorites (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id int NOT NULL,
    favorite_id int NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (favorite_id) REFERENCES favorites (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE users_jobs (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id int NOT NULL,
    job_name varchar(255) NOT NULL,
    is_current_job bool NOT NULL,
    start_date date,
    end_date date,
    company_id int NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (company_id) REFERENCES companies (id),
    FOREIGN KEY (user_id) REFERENCES users (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE users_educations (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id int NOT NULL,
    major varchar(255) NOT NULL,
    is_current_education bool DEFAULT FALSE,
    start_date date,
    end_date date,
    school_id int NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (school_id) REFERENCES school (id),
    FOREIGN KEY (user_id) REFERENCES users (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE open_place (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id int NOT NULL,
    latitude DECIMAL (10,
        8) NOT NULL,
    longitude DECIMAL (11,
        8) NOT NULL,
    country_id smallint (5) unsigned NOT NULL,
    region_id int (11) unsigned,
    city_id int (11) unsigned,
    address VARCHAR(255) NOT NULL,
    cross_street VARCHAR(255) NOT NULL,
    quotes VARCHAR(255) NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active_until datetime NOT NULL,
    is_active bool
    DEFAULT TRUE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id), 
    FOREIGN KEY (country_id) REFERENCES countries (id),
    FOREIGN KEY (region_id) REFERENCES regions (id),
    FOREIGN KEY (city_id) REFERENCES cities (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE open_place_photos (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    open_place_id int NOT NULL,
    photo_url varchar(255) NOT NULL,
    thumbnail_url varchar(255) NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (open_place_id) REFERENCES open_place (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

CREATE TABLE users_join (
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id int NOT NULL,
    open_place_id int NOT NULL,
    is_confirmed bool
    DEFAULT false NOT NULL,
    created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (open_place_id) REFERENCES open_place (id)) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;
    