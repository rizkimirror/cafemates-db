CREATE TABLE Religion (
   id int auto_increment PRIMARY KEY,
   name varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE Favorites (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name varchar(255) NOT NULL,
   description text,
   created_at datetime NOT NULL DEFAULT current_timestamp
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE School (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name varchar(255) NOT NULL,
   country_id smallint(5) unsigned NOT NULL,
   region_id int(11) unsigned,
   city_id int(11) unsigned,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (country_id) REFERENCES countries(id),
   FOREIGN KEY (region_id) REFERENCES regions(id),
   FOREIGN KEY (city_id) REFERENCES cities(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE Company (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name varchar(255) NOT NULL,
   country_id smallint(5) unsigned NOT NULL,
   region_id int(11) unsigned,
   city_id int(11) unsigned,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (country_id) REFERENCES countries(id),
   FOREIGN KEY (region_id) REFERENCES regions(id),
   FOREIGN KEY (city_id) REFERENCES cities(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE Users (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   firstname varchar(25) NOT NULL,
   lastname varchar(25) NOT NULL,
   email varchar(255) NOT NULL,
   username varchar(25) NOT NULL,
   password varchar(60) NOT NULL,
   phonenumber varchar(20),
   avatar_url_thumbnail varchar(255),
   avatar_url_show varchar(255),
   country_id int,
   religion_id int,
   gender ENUM('Male', 'Female', 'Custom'),
   birthdate timestamp,
   quotes varchar(255),
   verification_status bool NOT NULL DEFAULT false,
   instagram varchar(255),
   is_online bool NOT NULL DEFAULT false,
   is_active bool NOT NULL DEFAULT true,
   is_reported bool NOT NULL DEFAULT false,
   is_blocked bool NOT NULL DEFAULT false,
   is_premium bool NOT NULL DEFAULT false,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (religion_id) REFERENCES Religion(id),
   FOREIGN KEY (country_id) REFERENCES countries(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE UsersLived (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   user_id int NOT NULL,
   current_lived_status enum('Hometown', 'Current') NOT NULL,
   country_id smallint(5) unsigned NOT NULL,
   region_id int(11) unsigned NOT NULL,
   city_id int(11) unsigned NOT NULL,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (user_id) REFERENCES Users(id),
   FOREIGN KEY (country_id) REFERENCES countries(id),
   FOREIGN KEY (region_id) REFERENCES regions(id),
   FOREIGN KEY (city_id) REFERENCES cities(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE GenderInterests (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   interested_gender ENUM('Male', 'Female', 'Custom'),
   user_id int NOT NULL,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (user_id) REFERENCES Users(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE UsersFavorites (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   user_id int NOT NULL,
   favorite_id int NOT NULL,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (user_id) REFERENCES Users(id),
   FOREIGN KEY (favorite_id) REFERENCES Favorites(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE UsersEducations (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   user_id int NOT NULL,
   major varchar(255) NOT NULL,
   is_current_education bool DEFAULT false,
   start_date date,
   end_date date,
   school_id int NOT NULL,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (school_id) REFERENCES School(id),
   FOREIGN KEY (user_id) REFERENCES Users(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE UsersJobs (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   user_id int NOT NULL,
   job_name varchar(255) NOT NULL,
   is_current_job bool NOT NULL,
   start_date date,
   end_date date,
   company_id int NOT NULL,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (company_id) REFERENCES Company(id),
   FOREIGN KEY (user_id) REFERENCES Users(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE Friends (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   user_id_1 int NOT NULL,
   user_id_2 int NOT NULL,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   status_friends enum('match', 'open_place', 'manual') NOT NULL,
   FOREIGN KEY (user_id_1) REFERENCES Users(id),
   FOREIGN KEY (user_id_2) REFERENCES Users(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE Posts (
   id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
   user_id int NOT NULL,
   caption text,
   post_status enum('open_place', 'caption_only', 'photos') NOT NULL,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   updated_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Photos (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   post_id int NOT NULL,
   name varchar(25) NOT NULL DEFAULT "cafemates_photos",
   photo_url varchar(255) NOT NULL,
   thumbnail_url varchar(255) NOT NULL,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (post_id) REFERENCES Posts(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE OpenPlace (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   user_is_open int NOT NULL,
   user_is_join int NOT NULL,
   city_id int(11) unsigned NOT NULL,
   region_id int(11) unsigned NOT NULL,
   country_id smallint(5) unsigned NOT NULL,
   latitude decimal(10,8) NOT NULL,
   longitude decimal(11,8) NOT NULL,
   post_id int NOT NULL,
   is_open bool NOT NULL DEFAULT true,
   active_time_until datetime NOT NULL,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   updated_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (post_id) REFERENCES Posts(id),
   FOREIGN KEY (user_is_join) REFERENCES Users(id),
   FOREIGN KEY (user_is_open) REFERENCES Users(id),
   FOREIGN KEY (country_id) REFERENCES countries(id),
   FOREIGN KEY (region_id) REFERENCES regions(id),
   FOREIGN KEY (city_id) REFERENCES cities(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE OpenPlacePremium (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   post_id int NOT NULL,
   city_id int(11) unsigned NOT NULL,
   region_id int(11) unsigned NOT NULL,
   country_id smallint(5) unsigned NOT NULL,
   latitude decimal(10,8) NOT NULL,
   longitude decimal(11,8) NOT NULL,
   is_open bool NOT NULL DEFAULT true,
   active_time_until time NOT NULL,
   created_at datetime NOT NULL DEFAULT current_timestamp,
   updated_at datetime NOT NULL DEFAULT current_timestamp,
   FOREIGN KEY (post_id) REFERENCES Posts(id),
   FOREIGN KEY (country_id) REFERENCES countries(id),
   FOREIGN KEY (region_id) REFERENCES regions(id),
   FOREIGN KEY (city_id) REFERENCES cities(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE Participants (
   id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
   joined_time datetime NOT NULL DEFAULT current_timestamp,
   OpenPlacePremium_id int NOT NULL,
   user_id int NOT NULL,
   FOREIGN KEY (user_id) REFERENCES Users(id),
   FOREIGN KEY (OpenPlacePremium_id) REFERENCES OpenPlacePremium(id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;