Oracle Text e Contains

Oracle Text

O Oracle Text � uma feature embutida no banco de dados que utiliza a linguagem SQL para indexar, pesquisar e analisar textos e documentos bin�rios armazenados nas tabelas. Nas vers�es Oracle 11g essa feature � conhecida como Oracle Text. Esta tecnologia oferece uma solu��o completa para pesquisa de textos na qual a mesma permite filtrar e extrair textos de conte�dos de diferentes formatos de documentos. O Oracle Text suporta mais de 150 formatos de documentos, incluindo os mais populares como os documentos Microsoft Office, al�m de formatos de arquivo do Adobe PDF, arquivos HTML e XML. Neste artigo irei demonstrar como gravar um documento bin�rio (.doc) no banco de dados Oracle 11g e o que fazer para poder realizar pesquisas no seu conte�do. 

O arquivo que irei carregar para o banco de dados (teste.doc) possui o conte�do "Marcio Konrath Curso de Oracle" para isto abra arquivo em branco do microsoft word e escreva o texto mencinado ou algum outro texto qualquer e salva na pasta C:\Temp com nome de "arquivo.doc"

Em seguida abra o CMD como administrador e conecte no SQLPLUS 

C:\set ORACLE_SID=curso

C:\>sqlplus sys/123 as sysdba


-- Cria��o de um diret�rio que indica a localiza��o do documento

--Conectado como usuario system grant create any directory to marcio;

--Conectado como usuario normal create or replace directory arquivos as 'C:\Temp';
 

Agora conectado como usu�rio normal de desenvolvimento no SQL Developer vamos criar uma tabela

create table teste (
  codigo number,
  nome varchar2(40),
  documento blob
);
create sequence seq_doc;
-- Cria��o de uma procedure para carregar o arquivo para o banco de dados

create or replace procedure grava_arquivo (p_file in varchar(40))
as
  v_bfile bfile;
  v_blob blob;
begin
  insert into teste (codigo,nome,documento)
  values (seq_doc.nextval,p_file_name,empty_blob())
  return documento into v_blob;
  -- Informa��o de directory tem que ser maiusculo 
  v_bfile := bfilename('ARQUIVOS',p_file);
  dbms_lob.fileopen(v_bfile, dbms_lob.file_readonly);     
  dbms_lob.loadfromfile(v_blob,v_bfile,dbms_lob.getlength(v_bfile));
  dbms_lob.fileclose(v_bfile);
  commit;
end;
-- Grava o arquivo para a tabela 

execute grava_arquivo('arquivo.doc');
 
--Para testar se gravou o registro fa�a select na tabela

Select * from teste;
e

Select dbms_lob.getlength(documento) bytes from teste;
--Vamos criar �ndice que vai permitir pesquisar dentro deste arquivo grava na tabela

create index ind_teste_doc on teste (documento) indextype is ctxsys.context parameters ('sync (on commit)');
--Para verificar se houve erro na cria��o do �ndice

select * from ctx_user_index_errors;
--Podemos verificar que foram criados alguns �ndices adicionais usando o selects abaixo

select table_name from user_tables;
select index_name,table_name from user_indexes;
--Fazendo pesquisar no documento gravando na tabela

select codigo, nome from teste where contains(documento, 'Marcio', 1) > 0;
select codigo,nome from teste where contains(documento, 'curso', 1) >