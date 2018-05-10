create table sina_stock
(
"symbol" char(8) primary key,
"code" char(6),
"name" varchar(20)
);
-- 
drop table sina_stock_xq_info;
create table sina_stock_xq_info(
symbol char(8),
xq_type int, -- 1-�ֺ� 2-��� 3-����
xq_date date, -- ��Ȩ��
dj_date date, -- ��Ȩ�Ǽ��� ��Sina�ĳ�Ȩ���ݲ���������Ȩ�պܶ�հף������Թ�Ȩ�Ǽ���Ϊ׼��
xq_info varchar(60), -- []
gg_date date -- 公告日期（如果，除权除息日、股权登记日这2个日期都缺失，处理方式：股权登记日＝公告日期＋5）
);

--
create table sina_zjhhangye
(
"code" varchar(20),
"name" varchar(120)
);

drop table sina_zjhhangye_stock;
create table sina_zjhhangye_stock
(
"hycode" varchar(20),
"hyname" varchar(120),
"symbol" char(8),
"name" varchar(20)
);
