create table xueqiu_stock
(
"symbol" char(8) primary key,
"code" char(6),
"name" varchar(20)
);

create table xueqiu_hangye
(
"name" varchar(20)
);

create table xueqiu_hangye_stock
(
"hyname" varchar(20),
"symbol" char(8)
);

-- 
drop table xueqiu_stock_finance;
create table xueqiu_stock_finance
(
"symbol" char(8),
"name" varchar(20),
"reportdate" date,
"basiceps" double precision,
"epsdiluted" double precision,
"epsweighted" double precision,
"naps" double precision,
"opercashpershare" double precision,
"peropecashpershare" double precision,
"netassgrowrate" double precision,
"dilutedroe" double precision,
"weightedroe" double precision,
"mainbusincgrowrate" double precision,
"netincgrowrate" double precision,
"totassgrowrate" double precision,
"salegrossprofitrto" double precision,
"mainbusiincome" double precision,
"mainbusiprofit" double precision,
"totprofit" double precision,
"netprofit" double precision,
"totalassets" double precision,
"totalliab" double precision,
"totsharequi" double precision,
"operrevenue" double precision,
"invnetcashflow" double precision,
"finnetcflow" double precision,
"chgexchgchgs" double precision,
"cashnetr" double precision,
"cashequfinbal" double precision
);
-- 
create index idx1_xueqiu_stock_finance on xueqiu_stock_finance(symbol);
create index idx2_xueqiu_stock_finance on xueqiu_stock_finance(reportdate);

-- 
create table diffvalue_stock_stats
(
"symbol" char(8),
"date" date,
"pb" double precision,
"pe" double precision
);
-- 
create index idx1_diffvalue_stock_stats on diffvalue_stock_stats(symbol);
create index idx2_diffvalue_stock_stats on diffvalue_stock_stats(date);

-- add 20160530
create table xueqiu_stock_shareschg
(
"symbol" char(8),
"publishdate" date,
	"begindate" date,
	"totalshare" double precision,
	"totalsharechg" double precision,
	"skchgexp" varchar(250),
	"fcircskamt" double precision,
	"circskamt" double precision,
	"ncircamt" double precision
	);
create index idx1_xueqiu_stock_shareschg on xueqiu_stock_shareschg(symbol);
create index idx2_xueqiu_stock_shareschg on xueqiu_stock_shareschg(begindate);

