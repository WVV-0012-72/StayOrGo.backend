CREATE TABLE frontend (
	fe_name text not null primary key,
	fe_last_time text not null,
	fe_cputemp text not null
);

CREATE TABLE coverage (
	fe_name text not null primary key,
	c_position text not null,
	c_radius integer not null,
	c_threshold_y integer,
	c_threshold_r integer
);

CREATE TABLE measurement (
	fe_name text not null,
	m_time text not null,
	m_num_ap integer not null,
	m_num_devices integer not null,
	primary key(fe_name,m_time)
);
