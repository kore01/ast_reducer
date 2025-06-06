CREATE TABLE t0 (c0, c1);
INSERT INTO t0 (c0) VALUES (-1);
CREATE VIEW IF NOT EXISTS view0(c0,c1) AS SELECT t0.c1 AS kgvprj, t0.c0 FROM ( t0 ) WHERE TRUE;
SELECT svslfg.c1 AS hghlqv, view0.c0 AS ujmumo FROM ( view0 ) svslfg, view0 WHERE TRUE;
CREATE VIEW view1 AS VALUES (0x7067e3cec226b60e % 904.1747253662293);
PRAGMA integrity_check;
SELECT * FROM ( view1 ) AS gwydaz WHERE abs(-6002);
VALUES ( 9535 );
;