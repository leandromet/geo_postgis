-- Functions to return the centroid of features with atribute values that identify them


 CREATE OR REPLACE FUNCTION scc.centro(IN _tbl regclass, IN registro integer, OUT centroide char) AS $$

 BEGIN
 EXECUTE format('SELECT ST_AsText(ST_Centroid(shape)) FROM %s WHERE objectid=%s',_tbl, registro)
 INTO centroide;
 END;
 $$LANGUAGE plpgsql;

--SELECT * FROM scc.centro('scc.scc_upa', 314);




 CREATE OR REPLACE FUNCTION scc.scc_centro_upa(IN umf integer, IN upa integer, OUT centroide char) AS $$

 BEGIN
 EXECUTE format('SELECT ST_AsText(ST_Centroid(shape)) FROM scc.scc_upa WHERE num_umf=%s AND num_upa=%s', umf, upa )
 INTO centroide;
 END;
 $$LANGUAGE plpgsql;

--SELECT * FROM scc.centro(6, 7);
