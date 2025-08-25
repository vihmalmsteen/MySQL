<h1>1. MANUTENÇÃO DAS TABELAS</h1>

<p align="justify">
  Pode fazer verificações de consistência, integridade e otimização nos dados armazenados e tabelas.
</p>

<h2>1.1 CHECK TABLE</h2>

<p align="justify">
  São comandos para verificar a consistência e integridade. Dependendo da engine, haverá mais ou menos recursos disponíveis:
</p>

<table>
  <thead>
    <tr>
      <th>COMANDOS</th>
      <th>ENGINE</th>
      <th>DESCRIÇÃO</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>REPAIR TABLE tabela QUICK;</td>
      <td>InnoDB e MyISAM</td>
      <td>Este comando não verifica os registros individualmente, apenas busca ligações incorretas na tabela. É uma opção rápida, mas pode não resolver completamente todos os problemas.</td>
    </tr>
    <tr>
      <td>REPAIR TABLE tabela FAST;</td>
      <td>MyISAM</td>
      <td>Este comando verifica apenas as tabelas que não foram fechadas corretamente. Pode ser mais rápido que a opção QUICK, mas também pode não resolver todos os problemas.</td>
    </tr>
    <tr>
      <td>REPAIR TABLE tabela CHANGED;</td>
      <td>MyISAM</td>
      <td>Este comando verifica apenas as tabelas que foram alteradas desde a última análise ou que não foram fechadas corretamente. É mais específico e pode ser mais eficiente para identificar e resolver problemas.</td>
    </tr>
    <tr>
      <td>REPAIR TABLE tabela MEDIUM;</td>
      <td>MyISAM</td>
      <td>Efetua uma varredura para verificar se os registros/ligações removidas são válidas. Calcula também a chave de conferência para os registros com base no check sum calculado para as chaves.</td>
    </tr>
    <tr>
      <td>REPAIR TABLE tabela EXTENDED;</td>
      <td>MyISAM</td>
      <td>Este comando faz uma consulta completa para todas as chaves de cada registro, verificando a integridade dos dados de forma mais abrangente. É o mais completo, mas também o mais demorado.</td>
    </tr>
  </tbody>
</table>


<p align="justify">Dos termos:</p>

<ul>
  <li><p align="justify"><b>Ligações incorretas: </b>Refere-se a referências de chave estrangeira que não correspondem a registros existentes na tabela de referência. Por exemplo, se em uma tabela de pedidos existe uma coluna de chave estrangeira para uma tabela de clientes, uma ligação incorreta ocorreria se houvesse um valor nessa coluna que não existisse na tabela de clientes;</p></li>
  <li><p align="justify"><b>Tabelas que não foram fechadas corretamente: </b>Significa que a tabela não foi fechada adequadamente após uma operação, como uma inserção, atualização ou exclusão de registros. Isso pode resultar em problemas de consistência e integridade dos dados;</p></li>
  <li><p align="justify"><b>Check sum: </b>É um valor calculado de verificação usado para garantir a integridade dos dados. É uma soma de verificação dos valores de uma determinada coluna ou de uma combinação de colunas. É usado para verificar se os dados foram corrompidos ou modificados de alguma forma. Se o check sum de um registro for diferente do valor previamente calculado, isso indica que algo está errado com o registro.</p></li>
</ul>

<h2>1.2 REPAIR TABLE</h2>

<p align="justify">
  Após a checagem com CHECK TABLE, usa-se o comando REPAIR TABLE para reparar erros encontrados. Há diferentes modos de reparo:
</p>


<table>
  <thead>
    <tr>
      <th>COMANDOS</th>
      <th>DESCRIÇÃO</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>REPAIR TABLE tabela QUICK;</td>
      <td>Este comando repara apenas o arquivo de índice .MYI da tabela especificada. Ele não realiza reparos no arquivo de dados da tabela. É útil quando há problemas específicos no índice da tabela;</td>
    </tr>
    <tr>
      <td>REPAIR TABLE tabela EXTENDED;</td>
      <td>Este comando faz uma reparação mais completa da tabela, recriando o índice linha por linha, em vez de criar um novo índice de uma vez com ordenação (QUICK). É mais lento, mas pode ser mais eficaz para resolver problemas mais complexos;</td>
    </tr>
    <tr>
      <td>REPAIR TABLE tabela USE_FRM;</td>
      <td>Este comando recria o arquivo de índices .MYI com base no arquivo .FRM associado à tabela. No entanto, é importante notar que o uso dessa opção pode levar à perda de dados e não é recomendado, a menos que seja absolutamente necessário. É considerada uma opção de último recurso.</td>
    </tr>
  </tbody>
</table>
