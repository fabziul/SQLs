-- 16/07/2021

-- OS ABERTA E FECHADA NO PERÍODO PESQUISADO:
SELECT * FROM (
        SELECT tipo, statustexto
        FROM v_chamadosti
        WHERE dtabertura BETWEEN '01/06/2021' AND '30/06/2021'    AND seqchamado = 1
    )
    PIVOT (
        COUNT(statustexto)
        for statustexto in ('Concluído' as "Concluido", 'Novo' as "Novo")
);

-- OS FECHADA INDEPENDENTE DA DATA DE ABERTURA
SELECT * FROM (
    SELECT 'OS' AS OS, tipo
    FROM v_chamadosti
    WHERE dtfechamento BETWEEN '01/07/2021' AND '30/07/2021'
        AND seqchamado = 1
)
PIVOT(
    count(tipo)
    for tipo in ('TREINAMENTO' AS "Treinamento", 'SISTEMA' AS "Sistema", 'INFRAESTRUTURA' AS "Infraestrutura")
);

-- CHAMADOS FECHADOS POR ATENDENTE:

SELECT * FROM v_chamadosti;

SELECT atendente, tipo, count(sequencia) AS QTD FROM v_chamadosti WHERE (sequencia, seqchamado) IN (SELECT sequencia, max(seqchamado)
FROM v_chamadosti
WHERE dtfechamento BETWEEN '01/07/2021' AND '30/07/2021' 
GROUP BY sequencia)
GROUP BY atendente, tipo
order by atendente;


-- CHAMADOS EM ATENDIMENTO POR ATENDENTE INDEPENDENTE DA DATA DE ABERTURA:


SELECT sequencia, max(seqchamado)
FROM v_chamadosti
WHERE dtfechamento IS NULL AND status <> 8 AND status <> 7
GROUP BY sequencia
order by sequencia;



SELECT * FROM V_CHAMADOSTI WHERE STATUS = 8 AND DTFECHAMENTO IS NULL 
ORDER BY sequencia;


SELECT * FROM V_CHAMADOSTI WHERE SEQUENCIA IN (131, 255, 290, 309, 325, 340, 346, 369, 387, 390, 392, 394, 395, 404, 406) AND STATUS =8;

SELECT * FROM AD_CHAMADODET WHERE SEQUENCIA IN (131, 255, 290, 309, 325, 340, 346, 369, 387, 390, 392, 394, 395, 404, 406) AND DATAFECHAMENTO IS NULL;

UPDATE AD_CHAMADODET SET DATAFECHAMENTO = TRUNC(SYSDATE)
WHERE SEQUENCIA IN (131, 255, 290, 309, 325, 340, 346, 369, 387, 390, 392, 394, 395, 404, 406) AND DATAFECHAMENTO IS NULL;
rollback;

SELECT * FROM ad_chamado WHERE STATUS = 8 AND DTFECHAMENTO IS NULL;

--(131, 255, 290, 309, 325, 340, 346, 369, 387, 390, 392, 394, 395, 404, 406)

SELECT * FROM V_CHAMADOSTI WHERE SEQUENCIA = 131;

SELECT * FROM AD_CHAMADODET WHERE SEQUENCIA = 131;

UPDATE AD_CHAMADODET SET DATAFECHAMENTO = TRUNC(SYSDATE), CODUSUFECH = 0, STATUS = 8 WHERE SEQUENCIA = 131 AND CODUSUFECH IS NULL;



SELECT atendente, tipo, count(sequencia) AS QTD FROM v_chamadosti WHERE (sequencia, seqchamado) IN 
    (SELECT sequencia, max(seqchamado)
    FROM v_chamadosti
    WHERE dtfechamento IS NULL
    GROUP BY sequencia)
GROUP BY atendente, tipo
order by atendente;


SELECT * FROM v_chamadosti where sequencia > 820;

SELECT * FROM ad_chamado WHERE sequencia > 820;

SELECT usu.nomeusu, cha.codtipo, count(cha.sequencia) 
FROM ad_chamado cha INNER JOIN tsiusu usu ON usu.codusu = cha.codatend
where 
--cha.status <> 8 AND cha.status <> 7 
GROUP BY usu.nomeusu, cha.codtipo;


--INNER JOIN tsiusu usu2 ON usu2.codusu = det.codatend
