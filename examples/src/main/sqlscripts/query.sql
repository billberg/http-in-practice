select symbol,reportdate,netassgrowrate from xueqiu_finance
where netassgrowrate > 150
order by reportdate desc;

select * from xueqiu_stock_stats
where pb > 0
and date = '2016-05-06'
order by pb;

select * from xueqiu_stock_stats
where pe > 0
and date = '2016-05-06'
order by pe;

select * from xueqiu_stock_stats
where symbol = 'SH601939'
order by date desc;

with s as (SELECT symbol,name,string_agg(hyname,',') 
from sina_zjhhangye_stock 
group by symbol,name) 
select * from s
where symbol in ('sz300304');


-- 当前风险水平
with q as
(select s.*, row_number() over(order by s.pe) pos
  	from diffvalue_stock_stats_d s
	where s.symbol = 'SH600089'
	order by s.pe)
select date, pos 
from q where q.date = '2017-02-24';

-- 
select EXTRACT(year FROM q.date) "year", count(*)
  	from "tdx_stock_day_2006-2010" q
	where q.symbol = 'sh600261'
    group by "year"
	order by "year";
	
-- 查询总股本
with x as (select row_number() over (partition by symbol order by begindate desc) rn, symbol, totalshare 
from xueqiu_stock_shareschg)
select symbol,totalshare from x
where rn = 1;

-- 查询最新股价 -- 性能很低
with x as (select row_number() over (partition by symbol order by date desc) rn, symbol, close 
from xueqiu_stock_day)
select symbol,close from x
where rn = 1;

-- 查询最新股价
with x as (select symbol, max(date) lastdate
from xueqiu_stock_day
group by symbol)
select s.symbol,s.close from xueqiu_stock_day s, x
where s.symbol = x.symbol
and s.date = x.lastdate;

-- 查询最新市值
with x as (select row_number() over (partition by symbol order by begindate desc) rn, symbol, totalshare 
from xueqiu_stock_shareschg),
y as (select symbol, max(date) lastdate
from xueqiu_stock_day
group by symbol)
select s.symbol,x.totalshare,s.close, x.totalshare*s.close as marketcap from xueqiu_stock_day s, x, y
where s.symbol = x.symbol
and s.symbol = y.symbol
and s.date = y.lastdate
and x.rn = 1;

-- 查询净利润
with x as (select row_number() over (partition by symbol order by begindate desc) rn, symbol, totalshare 
from xueqiu_stock_finance)
select symbol,totalshare from x
where rn = 1;


-- 财务指标
with qry as (
select *,row_number() over (partition by symbol order by reportdate desc) rn from diffvalue_stock_finance_stats_q
)
select * from qry
where rn = 1
order by netprofit_1y desc;

-- 上年净利润排名
select s.name,q.* from diffvalue_stock_finance_stats_q q left join sina_stock s
on (q.symbol = upper(s.symbol))
where q.reportdate = '2015-12-31'
and q.netprofit_1y > 5e9
order by q.netprofit_1y desc;

-- 净利润/市值排名



-- 
select *
from xueqiu_stock_finance s
where s.symbol = 'SZ002230'
order by reportdate desc;



-- 剔除停牌
select * 
from xueqiu_stock_day s
where s.symbol = 'SH600633'
and (cast(s.open*100 as integer) > 0 or cast(s.volume as integer) > 0)
order by s.date desc;

-- 
select *
from diffvalue_stock_finance_stats_q s
where s.symbol = 'SZ000893'
order by reportdate desc;



select * 
from (select *,row_number() over (partition by symbol order by reportdate desc) rn from xueqiu_stock_finance) f 
where rn=1;


select f.reportdate, b.pilu_date
    from xueqiu_stock_finance f left join eastmoney_stock_bbsj b
	on(substr(f.symbol, 3, 6) = b.code and f.reportdate = b.finance_date)
    where f.symbol = 'sz300255'
    order by f.reportdate desc
