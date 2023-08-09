with preference_category as (
  select distinct preference_category as preference_category
  from ontology_data
), 
lines as (
  select 'drop view if exists v_green_product_sustainability_mapping; ' as part
  union all 
  select 'create view v_green_product_sustainability_mapping as '
  union all
  select ' select source, product_idx ' 
  union all
  select ', avg(association_imp_score) filter (where preference_category = "' || preference_category || '") as "' || lower(preference_category) || '" '
  from preference_category
  union all
  select 'from (select pom.source, pom.product_idx, od.preference_category, 
pom.imp_score*od.association as association_imp_score 
from product_ontology_mapping pom 
left join ontology_data od 
on pom.onto_idx=od.idx where od.conditional=False) group by source, product_idx order by source, product_idx;'
)
select group_concat(part, '')
from lines;

