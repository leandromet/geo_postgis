---find duplicates

select o.gid from sfb_topo.mt_iru o
 where exists ( select 'x' 
                  from sfb_topo.mt_iru  i
                 where 
                   i.idt_imovel = o.idt_imovel and
                   i.gid < o.gid
             );

--remove duplicates


delete from sfb_topo.mt_iru
 where exists ( select 'x' 
                  from sfb_topo.mt_iru i
                 where i.idt_imovel = sfb_topo.mt_iru.idt_imovel
                   and i.gid > sfb_topo.mt_iru.gid
             );


--- find topo id

select a[3] from (select regexp_split_to_array(replace(replace(topo::text, '(',''), ')',''),',') as t from sfb_topo.mt_iru where gid=8000) as dt(a);


--- find invalid relations

select topogeo_id from topo_car.relation 
	where exists (select id 
	from (select regexp_split_to_array(replace(replace(topo::text, '(',''), ')',''),',') as t, element_id as id
		from sfb_topo.mt_iru where gid<20000) as dt(a), topo_car.relation where a[3]::int=element_id);
