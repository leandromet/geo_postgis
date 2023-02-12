create table inpe.carbono_inventario4_full as

select  id_0, geom, id, bioma, uf, mun_geocod, mun_nome, cagr_s, cagr_v, c_solo, c_pret, 
c_litter, c_dw, c_agb, c_bgb, c_v_4i, cagrpret, cagr_1994, cagr_2002, cagr_2010, 
cagr_2016, uc_ti, ano_ucti, avref94, avref02, avref10, incref02, incref10, 
incref16, avagr94, avagr02, avagr10, incrag02, incrag10, incrper16, incrsem16, 
avsec, remf, remg, remofl, remfsec1, remfsec2, remfsec3, remfsec4, remgsec, 
remoflsec, fc1994, fc2002, fc2010, fc2016, avap, area_ha, pgsolo9402, 
pgsolo0210, pgsolo1016, cn_veg, cn_rpa, n_min9402, n_min0210, n_min1016, 
n2odir9402, n2odir0210, n2odir1016, pcveg9402, pcveg0210, pcveg1016, gcveg9402, 
gcveg0210, gcveg1016, es_9402, e_9402, r_9402, el_9402, es_0210, e_0210, r_0210, 
el_0210, es_1016, e_1016, r_1016, el_1016, layer, path
from  inpe.carbono_inventario4_cerrado 
union

select  id_0, geom, id, bioma, uf, mun_geocod, mun_nome, cagr_s, cagr_v, c_solo, c_pret, 
c_litter, c_dw, c_agb, c_bgb, c_v_4i, cagrpret, cagr_1994, cagr_2002, cagr_2010, 
cagr_2016, uc_ti, ano_ucti, avref94, avref02, avref10, incref02, incref10, 
incref16, avagr94, avagr02, avagr10, incrag02, incrag10, incrper16, incrsem16, 
avsec, remf, remg, remofl, remfsec1, remfsec2, remfsec3, remfsec4, remgsec, 
remoflsec, fc1994, fc2002, fc2010, fc2016, avap, area_ha, pgsolo9402, 
pgsolo0210, pgsolo1016, cn_veg, cn_rpa, n_min9402, n_min0210, n_min1016, 
n2odir9402, n2odir0210, n2odir1016, pcveg9402, pcveg0210, pcveg1016, gcveg9402, 
gcveg0210, gcveg1016, es_9402, e_9402, r_9402, el_9402, es_0210, e_0210, r_0210, 
el_0210, es_1016, e_1016, r_1016, el_1016, layer, path
from inpe.carbono_inventario4_mtaatl 
union

select  id_0, geom, id, bioma, uf, mun_geocod, mun_nome, cagr_s, cagr_v, c_solo, c_pret, 
c_litter, c_dw, c_agb, c_bgb, c_v_4i, cagrpret, cagr_1994, cagr_2002, cagr_2010, 
cagr_2016, uc_ti, ano_ucti::numeric, avref94, avref02, avref10, incref02, incref10, 
incref16, avagr94, avagr02, avagr10, incrag02, incrag10, incrper16, incrsem16, 
avsec, remf, remg, remofl, remfsec1, remfsec2, remfsec3, remfsec4, remgsec, 
remoflsec, fc1994, fc2002, fc2010, fc2016, avap, area_ha, pgsolo9402, 
pgsolo0210, pgsolo1016, cn_veg, cn_rpa, n_min9402, n_min0210, n_min1016, 
n2odir9402, n2odir0210, n2odir1016, pcveg9402, pcveg0210, pcveg1016, gcveg9402, 
gcveg0210, gcveg1016, es_9402, e_9402, r_9402, el_9402, es_0210, e_0210, r_0210, 
el_0210, es_1016, e_1016, r_1016, el_1016, layer, path
from inpe.carbono_inventario4 
;
