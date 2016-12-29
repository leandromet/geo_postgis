
--criar topologia
select topology.CreateTopology('topo_sfb_car', 4674);

-- criar tabela
create table sfb_topo.mt_topo(gid serial primary key, idt_imovel numeric(16));

-- incluir coluna topogeometrica

SELECT topology.AddTopoGeometryColumn('topo_sfb_car', 'sfb_topo', 'mt_topo', 'topo', 'MULTIPOLYGON') As layer_mt;


-- Insere geometrias


INSERT INTO sfb_topo.mt_topo3(idt_imovel, topo)
SELECT geom_mt.idt_imovel, topology.toTopoGeom(geom_mt.geom, 'topo_sfb_car3', 1, 0.0001)
FROM sfb_dados.geom_mt
where id<1000;


--resumo

select * from topology.TopologySummary('topo_sfb_car3');


DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT * FROM sfb_dados.geom_mt LOOP
    BEGIN
      INSERT INTO sfb_topo.mt_topo3(idt_imovel, topo)
      SELECT geom_mt.idt_imovel, topology.toTopoGeom(geom_mt.geom, 'topo_sfb_car3', 1, 0.00002)
      FROM sfb_dados.geom_mt
      WHERE geom_mt.id = r.id;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.id, SQLERRM;
    END;
  END LOOP;
END$$;

select * from topology.TopologySummary('topo_sfb_car3');

-- restrito
DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT * FROM sfb_dados.geom_mt LOOP
	IF (r.id>999 and r.id<20000) then
    BEGIN
    
      INSERT INTO sfb_topo.mt_topo3(idt_imovel, topo)
      SELECT geom_mt.idt_imovel, topology.toTopoGeom(geom_mt.geom, 'topo_sfb_car3', 1, 0.00002)
      FROM sfb_dados.geom_mt
      WHERE geom_mt.id = r.id;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.id, SQLERRM;
    
    END;
   END IF;
  END LOOP;
END$$;
