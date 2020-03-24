CREATE TABLE frontend (
	fe_name text not null primary key,
	fe_last_time text not null,
	fe_cputemp text not null
);

CREATE TABLE location (
	l_name text not null,
	fe_name text not null,
	l_latitude text not null,
	l_longitude text not null,
	l_radius integer not null,
	l_threshold_y integer,
	l_threshold_r integer,
	FOREIGN KEY(fe_name) REFERENCES frontends(fe_name),
	PRIMARY KEY(l_name)
);
