-- Tamanho Total BD;
select sum(bytes) / 1024 / 1024 / 1024 tamanho_GB from dba_segments;

-- Tamanho BD por TableSpace;
select tablespace_name, sum(bytes) / 1024 / 1024 / 1024 tamanho_GB from dba_segments group by tablespace_name;

-- Status Contas BD
SELECT username, account_status FROM dba_users where account_status = 'OPEN';