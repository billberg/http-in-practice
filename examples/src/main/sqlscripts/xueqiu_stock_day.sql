drop table xueqiu_stock_day;
create table xueqiu_stock_day
(
"symbol" char(8),
"date" date,
"open" double precision,
"high" double precision,
"low" double precision,
"close" double precision,
"volume" double precision
);

drop table xueqiu_stock_day_fq;
create table xueqiu_stock_day_fq
(
"symbol" char(8),
"date" date,
"open" double precision,
"high" double precision,
"low" double precision,
"close" double precision,
"volume" double precision
);
