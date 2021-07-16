CREATE OR REPLACE VIEW V_CHAMADOSTI AS 
SELECT cha.sequencia, cha.dtabertura, cha.codsolicitante CodSolicita, usu.nomeusu Solicitante, emp.nomefantasia, gru.nomegrupo, cha.departamento, cha.codatend, 
       cha.fila, cha.codtipo, tinicio.descricao Tipo, tmeio.descricao Tipo2,tfim.descricao Detalhe, SUBSTR(cha.observacao, 1, 15) Descricao, cha.dtfechamento, det.dtatendimento, SUBSTR(det.solucao, 1, 15) SOLUCAO, 
       det.dtinicial, det.seqchamado, det.codatend CodAtende, usu2.nomeusu Atendente, det.dtalter Ini_Det, det.datafechamento Fim_Det, det.status Status,  
       CASE det.status WHEN '1' THEN 'Novo' WHEN '2' THEN 'Em Atendimento' WHEN '7' THEN 'Cancelado' WHEN '8' THEN 'Concluído' ELSE 'Outros'
    END StatusTexto, det.codusufech    
FROM ad_chamado cha INNER JOIN ad_chamadodet det ON cha.sequencia = det.sequencia
                    INNER JOIN tsiusu usu ON usu.codusu = cha.codsolicitante
                    INNER JOIN tsiusu usu2 ON usu2.codusu = det.codatend
                    LEFT JOIN tsiemp emp ON emp.codemp = usu.codemp
                    INNER JOIN tsigru gru ON gru.codgrupo = usu.codgrupo
                    INNER JOIN ad_chamadotipo tfim ON cha.codtipo = tfim.codtipo
                    INNER JOIN ad_chamadotipo tmeio ON tfim.codtipopai = tmeio.codtipo
                    LEFT JOIN ad_chamadotipo tinicio ON tmeio.codtipopai = tinicio.codtipo;
                    
SELECT * FROM V_CHAMADOSTI WHERE DTABERTURA > '1/04/2021';                    



// Tipo > Tipo > Detalhe
SELECT tinicio.descricao Tipo, tmeio.descricao Tipo2, tfim.descricao Detalhe
FROM ad_chamadotipo tfim INNER JOIN ad_chamadotipo tmeio ON tfim.codtipopai = tmeio.codtipo
                         INNER JOIN ad_chamadotipo tinicio ON tmeio.codtipopai = tinicio.codtipo
WHERE tfim.codtipo = 301005;

