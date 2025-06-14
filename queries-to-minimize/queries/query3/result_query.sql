CREATE TABLE table_0( table_0_c1 REAL);
CREATE TABLE table_2( table_2_c0, table_2_c1, table_2_c2);
CREATE TABLE IF NOT EXISTS table_3( table_3_c0 UNSIGNED BIG INT, table_3_c1 DATETIME);
INSERT INTO table_3( table_3_c0, table_3_c1) VALUES(- 2, NULL);
INSERT INTO table_2( table_2_c0, table_2_c1, table_2_c2) VALUES( 1, 0, 0);
REPLACE INTO table_2( table_2_c0, table_2_c1, table_2_c2) VALUES( 3, 3,- 1);
INSERT INTO table_2( table_2_c0, table_2_c1, table_2_c2) VALUES(- 2,- 0, NULL);
PRAGMA synchronous;
CREATE TRIGGER BEFORE INSERT ON table_0 BEGIN DELETE FROM table_2;
UPDATE table_1 SET table_1_c0 = 0.0 WHERE IFNULL ( 1 , 1 );
END;
SELECT* FROM table_3, table_2 WHERE EXISTS( SELECT table_3_c1 LIMIT NULL);
;