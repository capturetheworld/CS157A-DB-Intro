drop table if exists patient;

create table patient (
  patient_no integer primary key,
  last_name varchar(64) not null,
  first_name varchar(64) not null,
  sex varchar(1) not null,
  date_of_birth varchar(8) not null,
  ward integer not null
);

insert into patient values(454, "Smith",   "John",   "M", "14.08.78", 6);
insert into patient values(223, "Jones",   "Peter",  "M", "07.12.85", 8);
insert into patient values(597, "Brown",   "Brenda", "F", "17.06.61", 3);
insert into patient values(234, "Jenkins", "Alan",   "M", "29.01.72", 7);
insert into patient values(244, "Wells",   "Chris",  "F", "25.02.95", 6);
