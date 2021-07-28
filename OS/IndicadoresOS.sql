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


-- CHAMADOS EM ATENDIMENTO POR ATENDENTE INDEPENDENTE DA DATA DE ABERTURA: -- 27/07/2021

    -- Pesquisar chamados Concluídos com DTFechamento em Aberto
    SELECT DISTINCT(sequencia) FROM AD_chamado WHERE STATUS = 8 AND DTFECHAMENTO IS NULL 
    ORDER BY sequencia;
    
    SELECT * FROM v_chamadosti WHERE sequencia in (458, 459, 460, 461, 462);
    
    SELECT DISTINCT(sequencia) FROM AD_CHAMADODET WHERE STATUS = 8 AND DATAFECHAMENTO IS NULL 
    ORDER BY sequencia;

    -- Fechar detalhamentos em 30/03/2021 com usuário 347 - Fabiano. Obs: Alterada datas de fechamento para dia 10/04 pq se ficasse 30/03 a Dt fechamento seria menor que a Dt Atendimento. 
    UPDATE AD_CHAMADODET SET DATAFECHAMENTO = '10/04/2021', CODUSUFECH = 347, STATUS = 8 WHERE SEQUENCIA in (458, 459, 460, 461, 462) AND CODUSUFECH IS NULL;
    UPDATE AD_CHAMADO SET DTFECHAMENTO = '10/04/2021' WHERE SEQUENCIA in (458, 459, 460, 461, 462);

    SELECT * FROM AD_chamado WHERE sequencia in (300, 302, 303, 304, 305, 306, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 351, 352, 353, 354, 356, 357, 358, 359, 360, 361, 362, 363, 364, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 381, 382, 386, 387, 388, 389, 390, 392, 393, 394, 395, 397, 398, 399, 400, 401, 402, 404, 405, 406, 407, 413, 414, 415, 417, 418, 419, 420, 421, 422, 423, 425, 426, 427, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457)
    order by sequencia;
    
    -- Fechar detalhamento e chamado considerando a data de fechamento = Dt de Atendimento ou Dt de Abertura + 1 dia para chamados antigos que não atendiam à estrutura atual de chamados. 
    UPDATE AD_CHAMADODET SET DATAFECHAMENTO = (DTATENDIMENTO+ INTERVAL '1' DAY), CODUSUFECH = 347, STATUS = 8 WHERE SEQUENCIA in (300, 302, 303, 304, 305, 306, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 351, 352, 353, 354, 356, 357, 358, 359, 360, 361, 362, 363, 364, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 381, 382, 386, 387, 388, 389, 390, 392, 393, 394, 395, 397, 398, 399, 400, 401, 402, 404, 405, 406, 407, 413, 414, 415, 417, 418, 419, 420, 421, 422, 423, 425, 426, 427, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457) AND CODUSUFECH IS NULL;
    UPDATE AD_CHAMADO SET DTFECHAMENTO =  (DTABERTURA+ INTERVAL '1' DAY) WHERE SEQUENCIA in (300, 302, 303, 304, 305, 306, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 351, 352, 353, 354, 356, 357, 358, 359, 360, 361, 362, 363, 364, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 381, 382, 386, 387, 388, 389, 390, 392, 393, 394, 395, 397, 398, 399, 400, 401, 402, 404, 405, 406, 407, 413, 414, 415, 417, 418, 419, 420, 421, 422, 423, 425, 426, 427, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457);
    commit;
    
    select * from ad_chamado WHERE sequencia in (300, 302, 303, 304, 305);

    SELECT * FROM AD_CHAMADODET WHERE SEQUENCIA in (300, 302, 303, 304, 305, 306, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 351, 352, 353, 354, 356, 357, 358, 359, 360, 361, 362, 363, 364, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 381, 382, 386, 387, 388, 389, 390, 392, 393, 394, 395, 397, 398, 399, 400, 401, 402, 404, 405, 406, 407, 413, 414, 415, 417, 418, 419, 420, 421, 422, 423, 425, 426, 427, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457);

    SELECT * FROM v_chamadosti WHERE sequencia in (862);

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

    --> Consulta para montar o componente de BI
    SELECT atendente, tipo, count(sequencia) AS QTD FROM v_chamadosti WHERE (sequencia, seqchamado) IN 
        (SELECT sequencia, max(seqchamado)
        FROM v_chamadosti
        WHERE dtfechamento IS NULL
        GROUP BY sequencia)
    GROUP BY atendente, tipo
    order by atendente;

        -- Checando chamados em aberto para verifica se é preciso fazer alguma atualização devido à mudança de estrutura. 
        SELECT sequencia, max(seqchamado)
        FROM v_chamadosti
        WHERE dtfechamento IS NULL
        GROUP BY sequencia;
        -- Chamados fechados com dtfechamento NULL e detalhamento em aberto:
            UPDATE AD_CHAMADODET SET DATAFECHAMENTO = (DTATENDIMENTO+ INTERVAL '1' DAY), CODUSUFECH = 347, STATUS = 8 WHERE SEQUENCIA in (290, 403, 409, 410, 411, 412) AND CODUSUFECH IS NULL;
            UPDATE AD_CHAMADO SET DTFECHAMENTO =  (DTABERTURA+ INTERVAL '1' DAY) WHERE SEQUENCIA in (290, 403, 409, 410, 411, 412);
            commit;

        


SELECT * FROM v_chamadosti where sequencia > 820;

SELECT * FROM ad_chamado WHERE sequencia > 820;

SELECT usu.nomeusu, cha.codtipo, count(cha.sequencia) 
FROM ad_chamado cha INNER JOIN tsiusu usu ON usu.codusu = cha.codatend
where 
--cha.status <> 8 AND cha.status <> 7 
GROUP BY usu.nomeusu, cha.codtipo;


-- OS FECHADA POR DEPARTAMENTO NO PERÍODO PESQUISADO

// consulta para buscar os nomes dos departamentos e atualizar a listagem na consulta com PIVOT.
SELECT ''''||nomegrupo||''''||', ' FROM (SELECT distinct(nomegrupo) FROM V_CHAMADOSTI);

SELECT * FROM (
    SELECT 'OS' AS OS, nomegrupo
    FROM v_chamadosti
    WHERE dtfechamento BETWEEN '01/07/2021' AND '30/07/2021'
        AND seqchamado = 1
)
PIVOT(
    count(nomegrupo)
    for nomegrupo in ('DIRETORIA', 
'FIN - CRED E CADASTR', 
'EST - AUX DE ESTOQUE', 
'TI - SUPORTE', 
'RH - REC HUMANOS', 
'CMP - GERENTE', 
'FIN - AUX TESOURARIA', 
'CML - VENDEDORES', 
'CML - GERENTE', 
'CTR - CONTROLADORIA', 
'TI - GERENTE', 
'FIN - TESOURARIA', 
'<SEM GRUPO>', 
'FISC - GERENTE', 
'FIN - COBRANCA EXTER', 
'CMP - AUXILIAR', 
'AT - GERENTE', 
'EST - EXPEDICAO', 
'FIN - GERENTE', 
'FIN - CAIXA', 
'EST - GERENTE', 
'MKT - MARKETING'  )
);

SELECT nomegrupo, count(distinct(sequencia)) Qtd 
FROM v_chamadosti 
WHERE seqchamado = 1 AND dtfechamento BETWEEN '01/06/2021' AND '30/06/2021' AND statustexto =  'Concluído'
GROUP BY nomegrupo;
