CREATE INDEX idx1_tdx_stk_day
ON tdx_stk_day (code);

CREATE INDEX idx2_tdx_stk_day
ON tdx_stk_day (txn_date);

create index idx3_tdx_stk_day
on tdx_stk_day (code,txn_date);


CREATE INDEX idx1_tdx_idx_day
ON tdx_idx_day (code);

CREATE INDEX idx2_tdx_idx_day
ON tdx_idx_day (txn_date);

CREATE INDEX idx3_tdx_idx_day
ON tdx_idx_day (code,txn_date);



CREATE INDEX idx1_quant_stk_day_fq
ON quant_stk_day_fq (code);
CREATE INDEX idx2_quant_stk_day_fq
ON quant_stk_day_fq (txn_date);
CREATE INDEX idx3_quant_stk_day_fq
ON quant_stk_day_fq (code,txn_date);


—- 
CREATE INDEX idx1_sina_stk_xq
ON sina_stk_xq (code);

CREATE INDEX idx2_sina_stk_xq
ON sina_stk_xq (code,dj_date);

CREATE INDEX idx1_sina_stk_liutonga
ON sina_stk_liutonga (code);

CREATE INDEX idx2_sina_stk_liutonga
ON sina_stk_liutonga (code,update_date);

-- not used
CREATE INDEX idx1_tdx_stk_day_fq
ON tdx_stk_day_fq (code);

CREATE INDEX idx2_tdx_stk_day_fq
ON tdx_stk_day_fq (txn_date);


CREATE INDEX idx1_quant_wind_stats
ON quant_wind_stats (code,stats_label);


-- 20150901
CREATE INDEX idx1_quant2_stk_day_fq_10y
ON quant2_stk_day_fq_10y (code);
CREATE INDEX idx2_quant2_stk_day_fq_10y
ON quant2_stk_day_fq_10y (txn_date);
CREATE INDEX idx3_quant2_stk_day_fq_10y
ON quant2_stk_day_fq_10y (code,txn_date);


-- 
CREATE INDEX idx1_quant_stk_day_fq_10y
ON quant_stk_day_fq_10y (code);
CREATE INDEX idx2_quant_stk_day_fq_10y
ON quant_stk_day_fq_10y (txn_date);
CREATE INDEX idx3_quant_stk_day_fq_10y
ON quant_stk_day_fq_10y (code,txn_date);


