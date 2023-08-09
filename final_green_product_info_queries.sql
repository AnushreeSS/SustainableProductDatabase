drop view if exists v_green_product_mapping; 
create view v_green_product_mapping as  
select pk."source", pk."product_idx", round("health", 2) as "health", 
round("social",2) as "social", round("environment",2) as "environment", 
round("quality", 2) as "quality", round("vegan",2) as "vegan", 
round("gluten-free",2) as "gluten-free", round("vegetarian",2) as "vegetarian", 
round("lactose-free",2) as "lactose-free", round("allergen-free",2) as "allergen-free" 
from product_keywords pk
left join v_green_product_sustainability_mapping gpsm on pk.source=gpsm.source and pk.product_idx=gpsm.product_idx
left join v_green_product_dietary_mapping gpdm on pk.source=gpdm.source and pk.product_idx=gpdm.product_idx
;

drop view if exists v_keywords_freq; 
create view v_keywords_freq as
select v.vocab, count(*) as freq from product_keywords pk
join vocabulary v on v.idx=pk.vocab_idx
group by v.idx, v.vocab
order by freq desc; 

drop view if exists v_green_product_info; 
create view v_green_product_info as
select  pd.source, pd.idx, pd.product_description, k.keywords, 
gpi."health", gpi."social", gpi."environment", gpi."quality", gpi."vegan", 
gpi."gluten-free", gpi."vegetarian", gpi."lactose-free", gpi."allergen-free"  
from
(select  pk.source, pk.product_idx, group_concat(vocab, ', ') as keywords 
from product_keywords pk
left join vocabulary v on pk.vocab_idx=v.idx
group by pk.source, pk.product_idx) k
left join product_data pd on pd.idx=k.product_idx and pd.source=k.source
left join v_green_product_mapping gpi on pd.idx=gpi.product_idx and pd.source=gpi.source
;