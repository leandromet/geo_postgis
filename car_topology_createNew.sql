
--IRU Brasil
--select topology.CreateTopology('topo_brasil', 4674);
--create table sfb_topo.brasil_iru(gid serial primary key, idt_imovel numeric(16));
--SELECT topology.AddTopoGeometryColumn('topo_brasil', 'sfb_topo', 'brasil_iru', 'topo', 'MULTIPOLYGON') As layer_br_iru;
--create table sfb_topo.brasil_irup(gid serial primary key, idt_imovel numeric(16));
--SELECT topology.AddTopoGeometryColumn('topo_brasil', 'sfb_topo', 'brasil_irup', 'topo', 'MULTIPOLYGON') As layer_br_irup;



--GPL Leandro Biondo 2016
-- Creating topology and topogeometry table in postgis



--criar topologia
select topology.CreateTopology('topo_car', 4674);

-- criar tabela
create table sfb_topo.mt_iru(gid serial primary key, idt_imovel numeric(16));

-- incluir coluna topogeometrica

SELECT topology.AddTopoGeometryColumn('topo_car', 'sfb_topo', 'mt_iru', 'topo', 'MULTIPOLYGON') As layer_mt_iru;


-- Insere geometrias





INSERT INTO sfb_topo.mt_topo3(idt_imovel, topo)
SELECT mt.idt_imovel, topology.toTopoGeom(mt.geom, 'topo_sfb_car', 1, 0.0001)
FROM sfb_dados.geom_mt mt,   usr_geocar_aplicacao.imovel i
where  imovel.idt_imovel = mt_topo3.idt_imovel
  and imovel.ind_status_imovel in ('RE','CA');


DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT * FROM sfb_dados.geom_mt LOOP
   IF (r.id<10000 ) then
    BEGIN
      INSERT INTO sfb_topo.mt_topo(idt_imovel, topo)
      SELECT mt.idt_imovel, topology.toTopoGeom(mt.geom, 'topo_sfb_car', 1, 0.0001)
      FROM sfb_dados.geom_mt mt,   usr_geocar_aplicacao.imovel i
      WHERE mt.id = r.id 
	and i.idt_imovel = mt.idt_imovel
  	and i.ind_status_imovel in ('PE','AT')
	and i.ind_tipo_imovel='IRU';
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.id, SQLERRM;
    END;
   END IF;
  END LOOP;
END$$;



--Simplificar geometrias

SELECT SimplifyEdgeGeom('topo_brasil', edge_id, 0.001) FROM topo_brasil.edge;



CREATE OR REPLACE FUNCTION SimplifyEdgeGeom(atopo varchar, anedge int, maxtolerance float8)
RETURNS float8 AS $$
DECLARE
  tol float8;
  sql varchar;
BEGIN
  tol := maxtolerance;
  LOOP
    sql := 'SELECT topology.ST_ChangeEdgeGeom(' || quote_literal(atopo) || ', ' || anedge
      || ', ST_Simplify(geom, ' || tol || ')) FROM '
      || quote_ident(atopo) || '.edge WHERE edge_id = ' || anedge;
    BEGIN
      RAISE DEBUG 'Running %', sql;
      EXECUTE sql;
      RETURN tol;
    EXCEPTION
     WHEN OTHERS THEN
      RAISE WARNING 'Simplification of edge % with tolerance % failed: %', anedge, tol, SQLERRM;
      tol := round( (tol/2.0) * 1e8 ) / 1e8; -- round to get to zero quicker
      IF tol = 0 THEN RAISE EXCEPTION '%', SQLERRM; END IF;
    END;
  END LOOP;
END
$$ LANGUAGE 'plpgsql' STABLE STRICT;















--passos tabela filtrada
create table sfb_topo.mt_topo3_ast(gid serial primary key, idt_imovel numeric(16));
SELECT topology.AddTopoGeometryColumn('topo_sfb_car3', 'sfb_topo', 'mt_topo3_ast', 'topo', 'MULTIPOLYGON') As layer_mt_ast;


INSERT INTO sfb_topo.mt_topo3_ast(idt_imovel, topo)
SELECT tp.idt_imovel, tp.topo
FROM sfb_topo.mt_topo3_ast tp,   usr_geocar_aplicacao.imovel i
where tp.idt_imovel=i.idt_imovel and i.ind_tipo_imovel='AST';


--tentativa 2

create table sfb_topo.mt_topo2_ast(gid serial primary key, idt_imovel numeric(16));
SELECT topology.AddTopoGeometryColumn('topo_sfb_car2', 'sfb_topo', 'mt_topo2_ast', 'topo', 'MULTIPOLYGON') As layer_mt_ast;

INSERT INTO sfb_topo.mt_topo2_ast(idt_imovel, topo)
SELECT tp.idt_imovel, tp.topo
FROM sfb_topo.mt_topo3 tp,   usr_geocar_aplicacao.imovel i
where tp.idt_imovel=i.idt_imovel and i.ind_tipo_imovel='AST';



---view
create view sfb_topo.v_mt_topo3_ast as
SELECT tp.gid, tp.idt_imovel, tp.topo
FROM sfb_topo.mt_topo3 tp,   usr_geocar_aplicacao.imovel i
where tp.idt_imovel=i.idt_imovel and i.ind_tipo_imovel='AST';

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


--teste com geometria
DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT * FROM sfb_dados.geom_mt LOOP
   IF (r.id<10000 ) then
    BEGIN
      INSERT INTO sfb_topo.mt_topo(idt_imovel, topo)
      SELECT mt.idt_imovel, topology.toTopoGeom(mt.geom, 'topo_sfb_car', 1, 0.0001)
      FROM sfb_dados.geom_mt mt,   usr_geocar_aplicacao.imovel i
      WHERE mt.id = r.id 
	and i.idt_imovel = mt.idt_imovel
  	and i.ind_status_imovel in ('PE','AT')
	and i.ind_tipo_imovel='IRU';
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.id, SQLERRM;
    END;
   END IF;
  END LOOP;
END$$;







DO $$DECLARE r record;
BEGIN
  FOR r IN SELECT * FROM sfb_dados.geom_mt LOOP
   IF (r.id>9999 and r.id<30000 ) then
    BEGIN
      INSERT INTO sfb_topo.mt_topo(idt_imovel, topo)
      SELECT mt.idt_imovel, topology.toTopoGeom(mt.geom, 'topo_sfb_car', 1, 0.0001)
      FROM sfb_dados.geom_mt mt,   usr_geocar_aplicacao.imovel i
      WHERE mt.id = r.id 
	and i.idt_imovel = mt.idt_imovel
  	and i.ind_status_imovel in ('PE','AT')
	and i.ind_tipo_imovel='IRU';
    EXCEPTION
      WHEN OTHERS THEN
        RAISE WARNING 'Loading of record % failed: %', r.id, SQLERRM;
    END;
   END IF;
  END LOOP;
END$$;



#!/bin/sh
dbname="car_nacional082016"
username="adm"
line=30999

for i in {0..80}
 do 
  line=$(($line+i*500))
  next=$(($line+500))
  echo $line
  echo $next

  psql -h 172.16.32.116 $dbname $username -c "DO \$\$DECLARE r record;  BEGIN    FOR r IN SELECT * FROM sfb_dados.geom_mt LOOP     IF (r.id>$line and r.id<=$next ) then      BEGIN        INSERT INTO sfb_topo.mt_topo(idt_imovel, topo)        SELECT mt.idt_imovel, topology.toTopoGeom(mt.geom, 'topo_sfb_car', 1, 0.0001)        FROM sfb_dados.geom_mt mt,   usr_geocar_aplicacao.imovel i        WHERE mt.id = r.id    and i.idt_imovel = mt.idt_imovel     and i.ind_status_imovel in ('PE','AT')   and i.ind_tipo_imovel='IRU';      EXCEPTION        WHEN OTHERS THEN   RAISE WARNING 'Loading of record % failed: %', r.id, SQLERRM;      END;     END IF;    END LOOP;  END\$\$;"


 done




