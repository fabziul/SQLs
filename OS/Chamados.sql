SELECT *
FROM AD_CHAMADODET WHERE SEQUENCIA = 425;

SELECT *
FROM AD_CHAMADO WHERE SEQUENCIA = 425;

SELECT * 
FROM AD_CHAMADO CHA INNER JOIN AD_CHAMADODET DET ON cha.sequencia = det.sequencia
WHERE cha.sequencia = 425;

-- Tempo de Atendimento OS da Hora da Abertura até o fechamento no último Detalhamento. 
SELECT cha.sequencia NumOS, det.seqchamado Detalha, emp.nomefantasia||'\'|| gru.nomegrupo ||'\'||usu2.nomeusu  Usuario,  usu.nomeusu Atendente, 
       TO_CHAR(cha.dtabertura, 'DD/MM/YYYY HH:MI:SS') Abertura, 
       NVL(TO_CHAR(cha.dataini),'-') DTInicio,    NVL(TO_CHAR(cha.datafin),'-')DTFim,   
       NVL(TO_CHAR(det.dtalter, 'DD/MM/YYYY HH:MI:SS'), '-') InicioDetalha,   
       NVL(TO_CHAR(det.dtfinal, 'DD/MM/YYYY HH:MI:SS'),'-') FimDetalha, 
       NVL(TO_CHAR(det.dtalter, 'DD/MM/YYYY HH:MI:SS'),'-') Altera_Det, 
       NVL2(cha.dtabertura - det.dtfinal, TO_CHAR(TO_NUMBER(det.dtfinal-cha.dtabertura)*24,'99.99'), '-') TempoAtende
FROM ad_chamado cha
    INNER JOIN ad_chamadodet det ON cha.sequencia = det.sequencia
    INNER JOIN tsiusu usu ON usu.codusu = det.codusu
    INNER JOIN tsiusu usu2 ON usu2.codusu = cha.codsolicitante
    INNER JOIN tsigru gru ON gru.codgrupo = usu2.codgrupo
    INNER JOIN tsiemp emp ON emp.codemp = usu2.codemp
WHERE cha.dtabertura > '05/04/2021' 
ORDER BY cha.sequencia, det.seqchamado;    

--TO_CHAR(cha.dtabertura - det.dtfinal, 'DD/MM/YYYY HH:MI:SS') TempoAtende

SELECT * FROM TSIEMP;

SELECT * FROM TSIGRU;

SELECT CODEMP FROM TSIUSU;

SELECT * FROM ad_chamado WHERE dtabertura > '05/04/2021';

SELECT * FROM ad_chamadodet where sequencia = 440;



-- 22/04/2021

-- Montar View com todos os campos:
SELECT cha.sequencia, cha.codsolicitante, cha.departamento, cha.observacao, cha.codatend, cha.dtabertura, cha.status, cha.fila, cha.codtipo, cha.dtfechamento  FROM ad_chamado cha WHERE dtabertura > '15/04/2021';

SELECT det.sequencia, det.seqchamado, det.dtatendimento, det.codatend, det.solucao, det.dtinicial, det.codusu, det.dtalter, det.datafechamento, det.status, det.codusufech  FROM ad_chamadodet det WHERE det.sequencia = 501;

-- View: 
CREATE OR REPLACE VIEW V_CHAMADOSTI AS 
SELECT cha.dtabertura, cha.sequencia, cha.codsolicitante CodSolicita, usu.nomeusu Solicitante, emp.nomefantasia, gru.nomegrupo, cha.departamento, SUBSTR(cha.observacao, 1, 15) Descricao, cha.codatend, 
       cha.fila, cha.codtipo, cha.dtfechamento, det.dtatendimento, SUBSTR(det.solucao, 1, 15) SOLUCAO, 
       det.dtinicial, det.seqchamado, det.codatend CodAtende, usu2.nomeusu Atendente, det.dtalter Ini_Det, det.datafechamento Fim_Det, det.status Status,  
       CASE status WHEN '1' THEN 'Novo' WHEN '2' THEN 'Em Atendimento' WHEN '7' THEN 'Cancelado' WHEN '8' THEN 'Concluído' ELSE 'Outros'
    END StatusTexto, det.codusufech    
FROM ad_chamado cha INNER JOIN ad_chamadodet det ON cha.sequencia = det.sequencia
                    INNER JOIN tsiusu usu ON usu.codusu = cha.codsolicitante
                    INNER JOIN tsiusu usu2 ON usu2.codusu = det.codatend
                    INNER JOIN tsiemp emp ON emp.codemp = usu.codemp
                    INNER JOIN tsigru gru ON gru.codgrupo = usu.codgrupo;
WHERE cha.dtabertura > '16/04/2021' AND cha.dtabertura < '20/04/2021';

--det.sequencia = 501
SELECT * FROM AD_CHAMADO;

select * from tsiemp;
select * from tsigru;


SELECT  NOMEGRUPO, COUNT(SEQUENCIA) QTD 
FROM V_CHAMADOSTI 
WHERE dtabertura > '01/04/2021' AND dtabertura < '30/04/2021'
GROUP BY NOMEGRUPO
ORDER BY QTD DESC;                    

SELECT    nomefantasia,    COUNT(sequencia)
FROM    v_chamadosti
WHERE        dtabertura > '01/04/2021'    AND dtabertura < '30/04/2021'
GROUP BY    nomefantasia;

SELECT dtabertura, sequencia, status,
    CASE status
        WHEN '1' THEN 'Novo'
        WHEN '2' THEN 'Em Atendimento'
        WHEN '7' THEN 'Cancelado'
        WHEN '8' THEN 'Concluído'
        ELSE 'Outros'
    END StatusTexto
FROM V_CHAMADOSTI
WHERE dtabertura > '15/04/2021';

SELECT * FROM v_chamadosti where dtabertura > '10/04/2021';

SELECT count(sequencia), nomefantasia
FROM v_chamadosti
WHERE seqchamado = 1 AND dtabertura >= '01/04/2021' AND dtabertura <= '30/04/2021'
GROUP BY nomefantasia;

SELECT * FROM ad_chamadotipo;

SELECT * FROM ad_chamadotipo where codtipo = 101001;

SELECT tinicio.descricao Tipo, tmeio.descricao Tipo2, tfim.descricao Detalhe
FROM ad_chamadotipo tfim INNER JOIN ad_chamadotipo tmeio ON tfim.codtipopai = tmeio.codtipo
                         INNER JOIN ad_chamadotipo tinicio ON tmeio.codtipopai = tinicio.codtipo
WHERE tfim.codtipo = 301005;


Select * from v_chamadosti WHERE dtabertura > '1/04/2021';

SELECT nomefantasia, solicitante, tipo, count(distinct(sequencia)) Qtd 
FROM v_chamadosti 
WHERE dtabertura > '1/04/2021'
GROUP BY nomefantasia, solicitante, tipo
ORDER BY nomefantasia;

-- Contagem por Tipo de O.S. em Abril:
SELECT tipo, count(distinct(sequencia)) Qtd 
FROM v_chamadosti 
WHERE seqchamado = 1 AND dtabertura >= '1/04/2021' and dtabertura <= '30/04/2021' AND status  'Concluído'
GROUP BY tipo;

-- Contagem por empresa de O.S. em Abril:
SELECT nomefantasia, count(distinct(sequencia)) Qtd 
FROM v_chamadosti 
WHERE seqchamado = 1 AND dtabertura >= '1/04/2021' and dtabertura <= '30/04/2021'
GROUP BY nomefantasia;

-- Contagem por Status de O.S. em Abril:
SELECT statustexto, count(distinct(sequencia)) Qtd 
FROM v_chamadosti 
WHERE seqchamado = 1 AND dtabertura >= '1/04/2021' and dtabertura <= '30/04/2021' 
GROUP BY statustexto;


-- Contagem por Status e tipo de O.S. em Abril:
SELECT tipo||' - '||statustexto, count(distinct(sequencia)) Qtd 
FROM v_chamadosti 
WHERE seqchamado = 1 AND dtabertura >= '1/04/2021' and dtabertura <= '30/04/2021' 
GROUP BY tipo, statustexto
ORDER BY tipo;



SELECT * 
FROM v_chamadosti 
WHERE seqchamado = 1 AND dtabertura >= '1/04/2021' and dtabertura <= '30/04/2021' --AND status <> 8
