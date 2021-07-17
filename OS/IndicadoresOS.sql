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
    WHERE dtfechamento BETWEEN '01/06/2021' AND '30/06/2021'
        AND seqchamado = 1
)
PIVOT(
    count(tipo)
    for tipo in ('TREINAMENTO' AS "Treinamento", 'SISTEMA' AS "Sistema", 'INFRAESTRUTURA' AS "Infraestrutura")
);

-- CHAMADOS FECHADOS POR ATENTEDE:

SELECT * FROM v_chamadosti;

SELECT atendente, tipo, count(sequencia) FROM v_chamadosti WHERE (sequencia, seqchamado) IN (SELECT sequencia, max(seqchamado)
FROM v_chamadosti
WHERE dtfechamento BETWEEN '01/06/2021' AND '30/06/2021' AND dtfechamento IS NOT NULL
GROUP BY sequencia)
GROUP BY atendente, tipo;

