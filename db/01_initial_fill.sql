-- initial data insertion for ottmar's two piboxes
-- pi-box-02 at NETTO, 50m radius, 7ppl yellow, 12ppl red
INSERT INTO frontend (fe_name, fe_last_time, fe_cputemp) VALUES ('pi-box-02', '', '');
INSERT INTO coverage VALUES ('pi-box-02', 'NETTO - Kallmünz', 50, 7, 12);

-- pi-box-02 at Aldi, 25m radius, 3ppl yellow, 5ppl red
INSERT INTO frontend (fe_name, fe_last_time, fe_cputemp) VALUES ('pi-box-04', '', '');
INSERT INTO coverage VALUES ('pi-box-04', 'Aldi Laaber', 25, 3, 5);
