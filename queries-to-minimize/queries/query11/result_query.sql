CREATE TABLE V( BOOLEAN, q BOOLEAN);
INSERT INTO V VALUES( False, False);
INSERT INTO V SELECT* FROM( VALUES( NULL, FALSE),( NULL, NULL)) WHERE( TRUE> FALSE);
SELECT* FROM V AS K;
;