CREATE TABLE frontend (
	fe_name text not null primary key,
	last_time text not null,
	cputemp text not null
);

CREATE TABLE measurement (
	fe_name text not null,
	m_time text not null,
	m_num_ap integer not null,
	m_num_devices integer not null,
	primary key(fe_name,m_time)
);
