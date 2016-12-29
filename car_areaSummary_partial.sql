 ogr2ogr -append -f "PostgreSQL" PG:"host=host.116 user=adm dbname=car_nacional4 active_schema=sfb_dados" PG:"host=10.20.20.144 user=sfb dbname=car_nacional" -sql "with linhas as ( select *, (row_number() over()) as linha from relatorio.quadro_area)  SELECT   * FROM linhas where linha<300001;" -nln quadro_area20160419

 ogr2ogr -append -f "PostgreSQL" PG:"host=host.116 user=adm dbname=car_nacional4 active_schema=sfb_dados" PG:"host=10.20.20.144 user=sfb dbname=car_nacional" -sql "with linhas as ( select *, (row_number() over()) as linha from relatorio.quadro_area)  SELECT   * FROM linhas where linha>=300001 AND linha<500001;" -nln quadro_area20160419

 ogr2ogr -append -f "PostgreSQL" PG:"host=host.116 user=adm dbname=car_nacional4 active_schema=sfb_dados" PG:"host=10.20.20.144 user=sfb dbname=car_nacional" -sql "with linhas as ( select *, (row_number() over()) as linha from relatorio.quadro_area)  SELECT   * FROM linhas where linha>=500001 AND linha<700001;" -nln quadro_area20160419

 ogr2ogr -append -f "PostgreSQL" PG:"host=host.116 user=adm dbname=car_nacional4 active_schema=sfb_dados" PG:"host=10.20.20.144 user=sfb dbname=car_nacional" -sql "with linhas as ( select *, (row_number() over()) as linha from relatorio.quadro_area)  SELECT   * FROM linhas where linha>=700001;" -nln quadro_area20160419


with linhas as ( select *, (row_number() over()) as linha from relatorio.quadro_area)

SELECT 
  *
FROM 
  linhas
  where linha<50;
