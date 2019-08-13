-- Library table
CREATE TABLE library (
    id INTEGER NOT NULL,
    name VARCHAR NOT NULL,
    location VARCHAR NOT NULL,
    media_type VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

-- Media table
-- This table contains the template for
-- the movie and tv shows tables minus containing
-- the paths because movies are streamable while
-- tv shows generally arent
-- The Episodes table will also inherit from here
CREATE TABLE media (
    id INTEGER NOT NULL,
    library_id INTEGER NOT NULL,

    name VARCHAR(80) NOT NULL,
    description TEXT,
    rating INTEGER,
    year INTEGER,
    added TEXT,
    poster_path TEXT,
    media_type VARCHAR(50),
    PRIMARY KEY (id),
    CONSTRAINT fk_library FOREIGN KEY (library_id) REFERENCES library(id) ON DELETE CASCADE
);

-- Streamble Media Table
-- This table contains the template for
-- Media that has a file attached to it
-- ie it can be streamed.
-- Currently only movies and episodes inherit from this
CREATE TABLE streamable_media (
    id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY(id) REFERENCES media (id) ON DELETE CASCADE
);

CREATE TABLE movie (
    id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY(id) REFERENCES streamable_media (id) ON DELETE CASCADE
);

CREATE TABLE tv_show (
	id INTEGER NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY(id) REFERENCES media (id) ON DELETE CASCADE
);

CREATE TABLE season (
    id INTEGER NOT NULL,
	season_number INTEGER UNIQUE NOT NULL,
	tvshowid INTEGER NOT NULL,
	added TEXT,
	poster TEXT,
	PRIMARY KEY (id),
	FOREIGN KEY(tvshowid) REFERENCES tv_show (id) ON DELETE CASCADE
);

CREATE TABLE episode (
	id INTEGER NOT NULL,
	seasonid INTEGER NOT NULL,
	episode_ INTEGER NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY(id) REFERENCES streamable_media (id),
	FOREIGN KEY(seasonid) REFERENCES season (id) ON DELETE CASCADE
);

CREATE TABLE mediafile (
	id INTEGER NOT NULL,
	media_id INTEGER,
	target_file TEXT NOT NULL,
	quality VARCHAR(10),
	codec VARCHAR(10),
	audio VARCHAR(10),
	original_resolution VARCHAR(10),
	duration INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY(media_id) REFERENCES streamable_media (id) ON DELETE CASCADE
);
