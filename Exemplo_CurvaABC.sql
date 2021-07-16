SELECT X.marca, 
       AVG(X.CURVA_A) AS CURVA_A,
       AVG(X.CURVA_B) AS CURVA_B,
       AVG(X.CURVA_C) AS CURVA_C,
       AVG(X.CURVA_D) AS CURVA_D,
       AVG(X.CURVA_Z) AS CURVA_Z
FROM (
select xxx.marca,
 case when xxx.CURVA_POPU = 'A' then  (xxx.DDE) end as CURVA_A,
 case when xxx.CURVA_POPU = 'B' then (xxx.DDE) end as CURVA_B,
 case when xxx.CURVA_POPU = 'C' then (xxx.DDE) end as CURVA_C,
 case when xxx.CURVA_POPU = 'D' then (xxx.DDE) end as CURVA_D,
 case when xxx.CURVA_POPU = 'Z' then (xxx.DDE) end as CURVA_Z
from (
select A1.CODPROD  ,
        A1.DESCRICAO, 
        A1.MARCA , 
        A1.CODGRUPO1, 
        A1.DESCRGRUPO1, 
        A1.SEGMENTO, 
        A1.TOTAL , 
        A1.CUSTO_TOTAL, 
        A1.ESTOQUE_GERAL,
        A2.CURVA_POPU,
        A2.CURVA_QTD,
         ((select (SUM(GIR.VLRVENDIAUTIL_1 + GIR.VLRVENDIAUTIL_2 + GIR.VLRVENDIAUTIL_3)) from TGFGIR GIR where GIR.CODREL = 850 and GIR.codprod = A1.codprod  and gir.codlocal in ( 901000000, 902000000 , 903000000) AND GIR.CODEMP IN (select  EEE.CODEMP from  AD_COBESTEMP EEE WHERE EEE.SEQUENCIA = :SEQUENCIA))/3) as GIRODIARIO,

          
         (select sum(GIR.ESTOQUE) from TGFGIR GIR where GIR.CODREL = 850 and GIR.codprod = A1.codprod  and gir.codlocal in ( 901000000, 902000000 , 903000000) AND GIR.CODEMP IN (select  EEE.CODEMP from  AD_COBESTEMP EEE WHERE EEE.SEQUENCIA = :SEQUENCIA)) as ESTOQUE_GIR,

case when  ((select (SUM(GIR.VLRVENDIAUTIL_1 + GIR.VLRVENDIAUTIL_2 + GIR.VLRVENDIAUTIL_3)) from TGFGIR GIR where GIR.CODREL = 850 and GIR.codprod = A1.codprod  and gir.codlocal in ( 901000000, 902000000 , 903000000) AND GIR.CODEMP IN (select  EEE.CODEMP from  AD_COBESTEMP EEE WHERE EEE.SEQUENCIA = :SEQUENCIA))/3) > 0 then 
(A1.ESTOQUE_GERAL /   ((select (SUM(GIR.VLRVENDIAUTIL_1 + GIR.VLRVENDIAUTIL_2 + GIR.VLRVENDIAUTIL_3)) from TGFGIR GIR where GIR.CODREL = 850 and GIR.codprod = A1.codprod  and gir.codlocal in ( 901000000, 902000000 , 903000000) AND GIR.CODEMP IN (select  EEE.CODEMP from  AD_COBESTEMP EEE WHERE EEE.SEQUENCIA = :SEQUENCIA))/3)) 
end
as DDE
  from AD_ANALISEST A1 LEFT JOIN AD_CURVAABC A2 ON A1.SEQUENCIA = A2.SEQUENCIA  AND A1.CODPROD = A2.CODPROD
 where A1.sequencia  = :SEQUENCIA
) xxx
--where xxx.CURVA_POPU is not null

) X
having  (AVG(X.CURVA_A) is not null 
  or   AVG(X.CURVA_B) is not null 
  or   AVG(X.CURVA_C) is not null 
  or   AVG(X.CURVA_D) is not null 
  or   AVG(X.CURVA_Z) is not null )
GROUP BY x.marca