with sustainability_preference as (
  select distinct sustainability_preference as sustainability_preference
  from ontology_data od where od.conditional=True
), 
lines as (
  select 'drop view if exists v_green_product_dietary_mapping; ' as part
  union all 
  select 'create view v_green_product_dietary_mapping as '
  union all
  select ' select source, product_idx ' 
  union all
  select ', avg(association_imp_score) filter (where sustainability_preference = "' || sustainability_preference || '") as "' || trim(replace(lower(sustainability_preference), 'products', '')) || '" '
  from sustainability_preference
  union all
  select 'from (select pom.source, pom.product_idx, od.sustainability_preference, 
pom.imp_score*od.association as association_imp_score 
from product_ontology_mapping pom 
left join ontology_data od 
on pom.onto_idx=od.idx where od.conditional=True) group by source, product_idx order by source, product_idx;'
)
select group_concat(part, '')
from lines;