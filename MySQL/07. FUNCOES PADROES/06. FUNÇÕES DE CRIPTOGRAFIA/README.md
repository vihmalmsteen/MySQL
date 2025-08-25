<h2>6. FUNÇÕES DE CRIPTOGRAFIA</h2>

<p align="justify">
	Funções para criptografar informações sensíveis, como senhas, logins, dados bancários, registros pessoais, etc. Segue:
</p>

<table align="center"><thead><tr><th>FUNÇÃO</th><th>DESCRIÇÃO</th><th>EXEMPLO</th></tr></thead><tbody><tr><td>MD5()</td><td>Retorna o valor de hash MD5 de uma string.</td><td>SELECT MD5('password');</td></tr><tr><td>SHA1()</td><td>Retorna o valor de hash SHA1 de uma string.</td><td>SELECT SHA1('password');</td></tr><tr><td>SHA2()</td><td>Retorna o valor de hash SHA-2 (SHA-256, SHA-512, etc.) de uma string com base na configuração do tamanho do hash.</td><td>SELECT SHA2('password', 256);</td></tr><tr><td>COMPRESS()</td><td>Comprime uma string.</td><td>SELECT COMPRESS('data');</td></tr><tr><td>UNCOMPRESS()</td><td>Descomprime uma string previamente comprimida com a função COMPRESS().</td><td>SELECT UNCOMPRESS('compressed_data');</td></tr></tbody></table>

```sql
select 
 'md5' as `funcao`
, md5('senha') as `retorno`
union all
select 
 'sha1' as `funcao`
, sha1('senha') as `retorno`
union all
select 
 'sha2' as `funcao`
, sha2('senha', 256) as `retorno`
union all
select 
 'compress' as `funcao`
, compress('senha') as `retorno`
union all
select 
'uncompress' as `funcao`, uncompress(compress('senha')) as `retorno`
;
```

<table align="center"><thead><tr><th>funcao</th><th>retorno</th></tr></thead><tbody><tr><td>md5</td><td>e8d95a51f3af4a3b134bf6bb680a213a</td></tr><tr><td>sha1</td><td>7751a23fa55170a57e90374df13a3ab78efe0e99</td></tr><tr><td>sha2</td><td>b7e94be513e96e8c45cd23d162275e5a12ebde9100a425c4ebcdd7fa4dcd897c</td></tr><tr><td>compress</td><td>    x +NÍËH   S  </td></tr><tr><td>uncompress</td><td>senha</td></tr></tbody></table>

<p align="justify">
	Das criptografias, uma bastante usada é MD5. Pois, é unidirecional, ou seja, após criptografar, não há um meio de reverter do hash para a senha imputada. O que ocorre é que o campo no banco (coluna de senha) receberá o hash. Na aplicação, no momento de login, a senha imputada pelo usuário será recebida e também será "hasheada", e ambos hashs devem ser iguais. Exemplo:
</p>

```sql
create table usuarios (id int auto_increment primary key not null,
                       login text not null,
                       senha text not null);

insert into usuarios values
(id, 'ana.clara@gmail.com', md5('clara123')),
(id, 'beto.alonso@gmail.com', md5('betinhoboy')),
(id, 'vera.verao@hotmail.com', md5('tapitchuruca')),
(id, 'gandalf_the_gray@palantir.uk', md5('daquingmpassa'))
;

select * from usuarios;
```

<table align="center"><thead><tr><th>id</th><th>login</th><th>senha</th></tr></thead><tbody><tr><td>1</td><td>ana.clara@gmail.com</td><td>aabc8a500e43c8cd96774aa15f17ca4d</td></tr><tr><td>2</td><td>beto.alonso@gmail.com</td><td>5e3f9fb856c7b05bb0172ce2e55b1ac4</td></tr><tr><td>3</td><td>vera.verao@hotmail.com</td><td>8ecb89fd51d12de0c5a5bb4d904479ca</td></tr><tr><td>4</td><td>gandalf_the_gray@palantir.uk</td><td>bbea08cc4707526bfe232c375d1ac83d</td></tr></tbody></table>

<p align="justify">
	Numa aplicação web, por exemplo, o script de input de senha deve conter também uma função md5 para converter a string da senha inserida pelo usuário em uma hash md5. Caso a hash seja igual ao hash da senha no banco, o acesso é liberado.
</p>
