create table sfb_result.sicar_int_munic_falta as
SELECT 
  municipio.idt_municipio
FROM 
  sfb_apoio.municipio full outer join sfb_result.sicar_int_munic_old using (idt_municipio)
WHERE 
 sfb_result.sicar_int_munic_old.idt_municipio is null;
