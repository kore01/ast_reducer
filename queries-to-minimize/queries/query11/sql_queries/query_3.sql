INSERT INTO V SELECT * FROM (VALUES ((NOT NULL), false), (NULL, NULL)) AS A WHERE ((false <> true) <> (NOT true));
