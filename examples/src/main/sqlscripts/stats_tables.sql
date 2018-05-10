-- 
CREATE TABLE "public"."diffvalue_stock_finance_stats_q" (
	"symbol" char(8) COLLATE "default",
	"reportdate" date,
	"weightedroe_1y" float8,
	"weightedroe_3y_avg" float8,
	"roa_1y" float8,
	"roa_3y_avg" float8,
	"netassgrowrate_1y" float8,
	"mainbusiincome_1y" float8,
	"mainbusiprofit_1y" float8,
	"totprofit_1y" float8,
	"netprofit_1y" float8
);
-- 
CREATE INDEX  "idx1_diffvalue_stock_finance_stats_q" ON diffvalue_stock_finance_stats_q(symbol);


-- 日指标统计
CREATE TABLE "public"."diffvalue_stock_stats_d" (
	"symbol" char(8) COLLATE "default",
	"date" date,
	"pb" float8,
	"pe" float8,
	"zongshizhi" float8,
	"liutongshizhi" float8
);
CREATE INDEX  "idx1_diffvalue_stock_stats_d" ON diffvalue_stock_stats_d(symbol);

-- 日指标风险统计
-- "date","symbol","name","hangye","zongshizhi","liutongshizhi","weightedroe1Y","netprofit1Y","cor(C,PE)", "cor(C,PB)", "cor(rC,rPE)", "cor(rC,rPB)","samples","PE","PB","PE.risk","PE.riskMark","PB.risk","PB.riskMark","class"
CREATE TABLE "public"."diffvalue_stock_risk_stats_d" (
	"date" date,
	"symbol" char(8) COLLATE "default",
	"name" varchar(20),
	"hangye" varchar(300),
	"samples" int,
	"zongshizhi" float8,
	"liutongshizhi" float8,
	"weightedroe_1y" float8,
	"netprofit_1y" float8,
	"PE" float8,
	"PB" float8,
	"cor_C_PE" float8, 
	"cor_C_PB" float8, 
	"cor_rC_rPE" float8, 
	"cor_rC_rPB" float8,
	"PE_risk" float8,
	"PE_risk_chg" float8,
	"PB_risk" float8,
	"PB_risk_chg" float8,
	"classify" varchar(10),
	"mark" varchar(10)
);
ALTER TABLE public.diffvalue_stock_risk_stats_d
  OWNER TO diffview;
  