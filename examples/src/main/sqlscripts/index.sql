drop index idx1_tdx_stock_day;
drop index idx2_tdx_stock_day;
-- 创建索引的性能很差 （collate default）
create index idx1_tdx_stock_day on tdx_stock_day (symbol);
-- 创建索引的性能提高很多倍，因此英文字段表定义时使用collate "C"
create index idx1_tdx_stock_day on tdx_stock_day (symbol collate "C");


create index idx2_tdx_stock_day on tdx_stock_day (date);


CREATE INDEX  "idx2_diffvalue_stock_stats_d" ON "public"."diffvalue_stock_stats_d" (lower(symbol));
CREATE INDEX  "idx3_diffvalue_stock_stats_d" ON "public"."diffvalue_stock_stats_d" (date);

-- TODO:symbol统一成小写
CREATE INDEX  "idx3_xueqiu_stock_day_fq" ON "public"."xueqiu_stock_day_fq" (upper(symbol));


-- PG的查询优化比较差，以下等价查询性能相差较大，两侧非常量比较索引利用不上
explain ANALYSE 
select s.date, q.close, s.pe, s.pb, s.zongshizhi,s.liutongshizhi 
  	from diffvalue_stock_stats_d s, xueqiu_stock_day_fq q
	where s.symbol = upper(q.symbol) --upper索引无法利用
	and s.symbol = 'SH600000'
	and s.date = q.date
	order by s.date desc;
	
explain ANALYSE 
select s.date, q.close, s.pe, s.pb, s.zongshizhi,s.liutongshizhi 
  	from diffvalue_stock_stats_d s, xueqiu_stock_day_fq q
	where s.symbol = upper(q.symbol)
	and s.symbol = 'SH600000'
	and upper(q.symbol) = 'SH600000' --可利用upper索引
	and s.date = q.date
	order by s.date desc;
	