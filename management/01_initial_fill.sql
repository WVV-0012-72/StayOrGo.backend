-- initial data insertion for ottmar's two piboxes
-- pi-box-02 at NETTO, 50m radius, 10ppl yellow, 15ppl red
INSERT INTO frontend (fe_name, fe_last_time, fe_cputemp) VALUES ('pi-box-02', '', '');
INSERT INTO location VALUES (
	"Netto Kallmünz",
	'pi-box-02',
	"49.1614266",
	"11.9460491",
	50,
	10,
	15
);

-- pi-box-02 at Aldi, 25m radius, 7ppl yellow, 12ppl red
INSERT INTO frontend (fe_name, fe_last_time, fe_cputemp) VALUES ('pi-box-04', '', '');
INSERT INTO location VALUES (
	"Aldi Laaber",
	'pi-box-04',
	"49.3508960",
	"12.2244763",
	25,
	7,
	12
);
