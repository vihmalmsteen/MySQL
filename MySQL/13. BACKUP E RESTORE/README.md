<h1>1. BACKUP & RESTORE</h1>

<p align="justify">
  Todas as IDEs possuem algum tipo de recurso <i>user friendly</i> para fazer o backup ou o restore de DBs ou tabelas específicas. Portanto, o foco aqui é através do PROMPT de comando. Os comandos em sí são muito parecidos:
</p>

```
+------------------------------------------------+-------------------------------------------------------------------------------------------------+
| FUNÇÃO                                         | COMANDO                                                                                         |
+------------------------------------------------+-------------------------------------------------------------------------------------------------+
| Backup de um banco                             | mysqldump -u USUARIO –pSENHA nomeDB > C:\path\to\file\nomeArquivoBK.sql                         |
| Backup 1 Tabela de um banco                    | mysqldump -u USUARIO –pSENHA nomeDB  nomeTabela > C:\path\to\file\nomeArquivoBK.sql             |
| Backup 2 ou maisTabelas                        | mysqldump -u USUARIO –pSENHA nomeDB nomeTabela1 nomeTabela2 > C:\path\to\file\nomeArquivoBK.sql |
| Backup mais de um Banco                        | mysqldump -u USUARIO –pSENHA --databases nomeDB1 nomeDB2 > C:\path\to\file\nomeArquivoBK.sql    |
| Backup todos bancos na instancia               | mysqldump -u USUARIO –pSENHA --all-databases > C:\path\to\file\nomeArquivoBK.sql                |
| Backup incluindo funçoes procedures e triggers | mysqldump -u USUARIO --routines --triggers -pSENHA nomeDB > C:\path\to\file\nomeArquivoBK.sql   |
| Restore de um Banco                            | mysql -u USUARIO –pSENHA nomeDB < C:\path\to\file\nomeArquivoBK.sql                             |
| Restaurando todos bancos na instancia          | mysql -u USUARIO –pSENHA < C:\path\to\file\nomeArquivoBK.sql                                    |
| Restaurando backup em outro database           | mysql -u USUARIO –pSENHA nomeNovoDB < C:\path\to\file\nomeArquivoBK.sql                         |
+------------------------------------------------+-------------------------------------------------------------------------------------------------+
```

<p align="justify">
  A maior diferença entre BACKUP e RESTORE é o sinal logo antes do caminho do arquivo a ser criado ou restaurado. Ele literalmente aponta a direção:
</p>

<ul>
  <li><p align="justify"><b>BACKUP (>): </b>Pega do MySQL e joga (aponta) para o diretório/arquivo, criando o BACKUP;</p></li>
  <li><p align="justify"><b>RESTORE (<): </b>Pega do diretório/arquivo e joga (aponta) para o MySQL.</p></li>
</ul>

<p align="justify"><b>NOTA: </b>Ao fazer uma restauração em um outro DB, este outro DB deve ser criado antes.</p>

<h1>2. CONFIGURAÇÃO DO CMD</h1>

<p align="justify">
  Os comandos acima são para serem usados no PROMPT de comando, ou CMD. E para isso, devem ser executados na pasta raíz respectiva do servidor MySQL, a qual é <b>a pasta de binários (bin) do servidor MySQL (MySQL server)</b>. Exemplo:
</p>

```
C:\Program Files\MySQL\MySQL Server 8.0\bin
```

<p align="justify">
  No PROMPT de comando, deve-se apontar/navegar para essa pasta dentro do CMD antes de executar os comandos. Isto é feito com o comando <b>cd</b> (ou <i>change directory</i>):
</p>

```
cd 'C:\Program Files\MySQL\MySQL Server 8.0\bin'
```

<p align="justify">
  Agora, pode-se executar os comandos do MySQL do CMD. Outro <b>ponto facilitador</b>:
</p>

<ul>
  <li><p align="justify"><b>1°: </b>Criar na área de trabalho um atalho do CMD;</p></li>
  <li><p align="justify"><b>2°: </b>Ir em "Configurações" do próprio atalho criado;</p></li>
  <li><p align="justify"><b>3°: </b>Setar na caixa "Iniciar em:" o diretório dos binários.</p></li>
</ul>

<p align="justify">
  Com isso, o CMD será iniciado sempre na pasta raíz de execução destes comandos quando aberto o atalho.
</p>

<h1>3. EXEMPLOS</h1>

<h2>3.1 BACKUP</h2>

<p align="justify">
  Fazer backup do DB 'lojinha' com todos os gatilhos (triggers) e procedimentos (routines) na pasta de 'Downloads':
</p>

```
-u root --routines --triggers -p1234 lojinha > "C:\Users\Vitor Elguesabel\Downloads\lojinhaBK.sql"
```

<p align="justify">O conteúdo do arquivo será como abaixo:</p>

```sql
-- MySQL dump 10.13  Distrib 8.0.35, for Win64 (x86_64)
--
-- Host: localhost    Database: lojinha
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `entregas`
--

DROP TABLE IF EXISTS `entregas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entregas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `carro` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entregas`
--

LOCK TABLES `entregas` WRITE;
/*!40000 ALTER TABLE `entregas` DISABLE KEYS */;
INSERT INTO `entregas` VALUES (1,'furgão'),(2,'moto');
/*!40000 ALTER TABLE `entregas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itenscarrinhos`
--

DROP TABLE IF EXISTS `itenscarrinhos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itenscarrinhos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produtoId` int DEFAULT NULL,
  `qtde` int DEFAULT NULL,
  `pedidoId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `produtoId` (`produtoId`),
  KEY `pedidoId` (`pedidoId`),
  CONSTRAINT `itenscarrinhos_ibfk_1` FOREIGN KEY (`produtoId`) REFERENCES `produtos` (`id`),
  CONSTRAINT `itenscarrinhos_ibfk_2` FOREIGN KEY (`pedidoId`) REFERENCES `pedidos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itenscarrinhos`
--

LOCK TABLES `itenscarrinhos` WRITE;
/*!40000 ALTER TABLE `itenscarrinhos` DISABLE KEYS */;
INSERT INTO `itenscarrinhos` VALUES (1,1,2,1),(2,2,1,1),(3,4,1,1),(4,5,1,1),(5,7,3,1),(6,4,3,2),(7,5,3,2),(8,10,3,2),(9,11,1,2),(10,1,3,3),(11,2,1,3),(12,3,2,3),(13,6,1,3),(14,11,1,3),(15,2,3,4),(16,3,3,4),(17,4,3,4),(18,6,3,5),(19,7,3,5),(20,8,3,5),(21,1,1,6),(22,7,3,6),(23,10,1,6),(24,11,2,6),(25,1,1,7),(26,5,2,7),(27,6,3,7),(28,1,1,8),(29,5,1,8),(30,6,2,8),(31,1,3,9),(32,2,3,9),(33,4,3,9),(34,5,1,9),(35,6,3,9),(36,1,2,10),(37,3,1,10),(38,7,3,10);
/*!40000 ALTER TABLE `itenscarrinhos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `lojavendas`
--

DROP TABLE IF EXISTS `lojavendas`;
/*!50001 DROP VIEW IF EXISTS `lojavendas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `lojavendas` AS SELECT 
 1 AS `pedido`,
 1 AS `itemId`,
 1 AS `comprador`,
 1 AS `bairro`,
 1 AS `carro`,
 1 AS `produto`,
 1 AS `tipo`,
 1 AS `preco`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comprador` text,
  `bairro` text,
  `entregaId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entregaId` (`entregaId`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`entregaId`) REFERENCES `entregas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'Ana','Barra',1),(2,'Anderson','Recreio',1),(3,'Beto','Barra',1),(4,'Cláudio','Recreio',1),(5,'Cláudia','Copacabana',2),(6,'Francisco','Barra',1),(7,'Fernanda','Barra',1),(8,'Fabrício','Botafogo',2),(9,'Mônica','Recreio',1),(10,'Eduardo','Centro',2),(22,'Rogério','Ipanema',2),(23,'Carinny','Leblon',2),(24,'Vera','Urca',2),(25,'Xico','Morro do Dendê',1),(26,'Rogério','Ipanema',2),(27,'Carinny','Leblon',2),(28,'Vera','Urca',2),(29,'Xico','Morro do Dendê',1);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `novosPedidos` AFTER INSERT ON `pedidos` FOR EACH ROW insert into pedidosNovos values

	(new.id, new.comprador, new.bairro, new.entregaId, now()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pedidoscartao`
--

DROP TABLE IF EXISTS `pedidoscartao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidoscartao` (
  `IdPedido` int DEFAULT NULL,
  `ValorPedido` decimal(10,2) DEFAULT NULL,
  `NumParcelas` int DEFAULT NULL,
  `ValorParcela` decimal(10,2) DEFAULT NULL,
  `DataCompra` date DEFAULT NULL,
  `DataCompensacao1` date DEFAULT NULL,
  `DataCompensacao2` date DEFAULT NULL,
  `DataCompensacao3` date DEFAULT NULL,
  `DataCompensacao4` date DEFAULT NULL,
  `DataCompensacao5` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidoscartao`
--

LOCK TABLES `pedidoscartao` WRITE;
/*!40000 ALTER TABLE `pedidoscartao` DISABLE KEYS */;
INSERT INTO `pedidoscartao` VALUES (1,11.20,3,3.73,'2023-12-30','2024-01-29','2024-02-28','2024-03-29',NULL,NULL),(2,13.30,4,3.33,'2023-12-25','2024-01-24','2024-02-23','2024-03-24','2024-04-23',NULL),(3,10.05,2,5.03,'2023-12-17','2024-01-16','2024-02-15',NULL,NULL,NULL),(4,11.55,5,2.31,'2023-12-24','2024-01-23','2024-02-22','2024-03-23','2024-04-22','2024-05-22');
/*!40000 ALTER TABLE `pedidoscartao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidosnovos`
--

DROP TABLE IF EXISTS `pedidosnovos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidosnovos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comprador` text,
  `bairro` text,
  `entregaId` smallint DEFAULT NULL,
  `momento` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidosnovos`
--

LOCK TABLES `pedidosnovos` WRITE;
/*!40000 ALTER TABLE `pedidosnovos` DISABLE KEYS */;
INSERT INTO `pedidosnovos` VALUES (26,'Rogério','Ipanema',2,'2024-01-08 00:07:38'),(27,'Carinny','Leblon',2,'2024-01-08 00:07:38'),(28,'Vera','Urca',2,'2024-01-08 00:07:38'),(29,'Xico','Morro do Dendê',1,'2024-01-08 00:07:38');
/*!40000 ALTER TABLE `pedidosnovos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produto` text,
  `tipo` text,
  `preco` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'pao','padaria',1.20),(2,'leite','lacteos',1.40),(3,'manteiga','lacteos',1.35),(4,'ovo','animais',1.10),(5,'presunto','frios',2.40),(6,'queijo','frios',1.80),(7,'café','bebidas',1.30),(8,'mortadela','frios',1.20),(9,'suco','bebidas',0.80),(10,'banana','frutas',0.75),(11,'maça','frutas',0.55);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `produtosBK_trigger` BEFORE DELETE ON `produtos` FOR EACH ROW INSERT INTO produtosBK values

    (OLD.id, OLD.produto, OLD.tipo, OLD.preco, 'DELETED', now()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produtosbk`
--

DROP TABLE IF EXISTS `produtosbk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtosbk` (
  `id` int DEFAULT NULL,
  `produto` text,
  `tipo` text,
  `preco` float DEFAULT NULL,
  `tipoAcao` text,
  `momento` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtosbk`
--

LOCK TABLES `produtosbk` WRITE;
/*!40000 ALTER TABLE `produtosbk` DISABLE KEYS */;
/*!40000 ALTER TABLE `produtosbk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtosnaolacteos`
--

DROP TABLE IF EXISTS `produtosnaolacteos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtosnaolacteos` (
  `id` int DEFAULT NULL,
  `produto` text,
  `tipo` text,
  `preco` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtosnaolacteos`
--

LOCK TABLES `produtosnaolacteos` WRITE;
/*!40000 ALTER TABLE `produtosnaolacteos` DISABLE KEYS */;
INSERT INTO `produtosnaolacteos` VALUES (1,'pao','padaria',1.2),(4,'ovo','animais',1.1),(5,'presunto','frios',2.4),(6,'queijo','frios',1.8),(7,'café','bebidas',1.3),(8,'mortadela','frios',1.2),(9,'suco','bebidas',0.8),(10,'banana','frutas',0.75),(11,'maça','frutas',0.55);
/*!40000 ALTER TABLE `produtosnaolacteos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teste`
--

DROP TABLE IF EXISTS `teste`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teste` (
  `id` int DEFAULT NULL,
  `nome` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teste`
--

LOCK TABLES `teste` WRITE;
/*!40000 ALTER TABLE `teste` DISABLE KEYS */;
INSERT INTO `teste` VALUES (1,'vitor'),(2,'carinny');
/*!40000 ALTER TABLE `teste` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'lojinha'
--
/*!50003 DROP PROCEDURE IF EXISTS `procedimento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `procedimento`()
main: BEGIN

  DECLARE var1 int;
  DECLARE var2 int;
  DECLARE varN int;
  DECLARE cur_fim INT;
  DECLARE contador INT DEFAULT 0;
  DECLARE cur CURSOR FOR SELECT col1, col2, colN FROM tabela;

  SELECT COUNT(*) INTO cur_fim FROM tabela;

  OPEN cur;
  meu_loop: LOOP
    SET contador = contador + 1;
    IF contador >= cur_fim THEN
      FETCH cur INTO var1, var2, varN;
    ELSE
      LEAVE meu_loop;
    END IF;
  END LOOP;
  CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `lojavendas`
--

/*!50001 DROP VIEW IF EXISTS `lojavendas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `lojavendas` AS select `pe`.`id` AS `pedido`,`ic`.`id` AS `itemId`,`pe`.`comprador` AS `comprador`,`pe`.`bairro` AS `bairro`,`e`.`carro` AS `carro`,`pr`.`produto` AS `produto`,`pr`.`tipo` AS `tipo`,`pr`.`preco` AS `preco` from (((`itenscarrinhos` `ic` left join `pedidos` `pe` on((`ic`.`pedidoId` = `pe`.`id`))) left join `produtos` `pr` on((`ic`.`produtoId` = `pr`.`id`))) left join `entregas` `e` on((`e`.`id` = `pe`.`entregaId`))) order by `pe`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-16 13:06:43
```

<h2>3.2 RESTORE</h2>

<p align="justify">
  Restaurar o DB 'lojinha' em um outro DB chamado 'outraLojinha':
</p>

```sql
-- No MySQL ou outra IDE
CREATE DATABASE outraLojinha;
```

```
mysql -u root -p1234 outraLojinha < "C:\Users\Vitor Elguesabel\Downloads\lojinhaBK.sql"
```

<p align="justify">Ao final, o DB 'outraLojinha' terá sido populado com todo o conteúdo do arquivo de BK.</p>

<h1>2. NOTAS</h1>

<p align="justify">
	Acima, no conteúdo do arquivo de BK, é possível ver, por exemplo, a seguinte linha:
</p>

```sql
LOCK TABLES `pedidos` WRITE;
UNLOCK TABLES;
```

<ul>
	<li><p align="justify"> <b>LOCK: </b>Bloqueia operações na tabela 'pedidos';</p></li>
	<li><p align="justify"> <b>READ: </b>As operações de bloqueio são de escrita (WRITE). Ou seja, INSERTS não ocorrerão;</p></li>
	<li><p align="justify"> <b>UNLOCK: </b>Desbloqueia a tabela.</p></li>
</ul>

<p align="justify">
	Ocorre que, por questões de integridade, os objetos do dump serão bloqueados enquanto a operação estiver ocorrendo. Isso significa que enquanto o backup estiver ocorrendo, tabelas estarão bloqueadas para operações DML. Ou seja, pode impactar o armazenamento de informações. Outro ponto é que INSERTS durante o bloqueio não são retomados automaticamente após a desbloqueio, devendo injetar manualmente após o desbloqueio da tabela. Isso é especificamente importante em aplicações de alto volume de dados transacionados. O que torna uma boa prática fazer/agendar backups em horários de menor tráfego. 
</p>

<p align="justify">
	Um ponto mitigador desse problema é a engine innoDB, que realiza o LOCK em linha. Ao usar o bloqueio de linha, apenas as linhas afetadas por operações de gravação serão bloqueadas durante o backup, permitindo que outras operações de gravação na mesma tabela continuem normalmente. Isso reduz o tempo de bloqueio e minimiza o impacto nas operações ativas. 
</p>

<p align="justify">
	No entanto, mesmo com bloqueios de linha, ainda é recomendável agendar backups para horários de menor movimento, se possível. Isso ajudará a reduzir a chance de conflitos e bloqueios prolongados nas tabelas durante o processo de backup. Lembre-se de que, embora o InnoDB utilize bloqueios de linha, ainda há um custo associado ao bloqueio e desbloqueio de linhas durante o backup. Em cenários de alto movimento, esses bloqueios podem impactar o desempenho global do sistema. Portanto, realizar backups em horários com menor atividade continua sendo uma prática recomendada para minimizar qualquer interrupção nas operações em execução.
</p>

<p align="justify">
	Existem várias ferramentas e métodos disponíveis para realizar backups de bancos de dados sem bloquear as tabelas de forma disruptiva. Alguns exemplos incluem:
</p>

<ul>
	<li><p align="justify"><b>Backup online/incremental: </b>Essa técnica envolve o uso de ferramentas especializadas que permitem realizar backups enquanto as operações de escrita estão em andamento. Essas ferramentas são capazes de capturar apenas as alterações incrementais nos dados, minimizando o impacto no desempenho e na disponibilidade;</p></li>
	<li><p align="justify"><b>Replicação de dados: </b>Uma abordagem comum é configurar uma replicação de dados em tempo real para fins de backup. Isso envolve ter várias instâncias do banco de dados, onde uma é designada como o servidor principal para o qual todas as operações de escrita são encaminhadas, enquanto as outras instâncias são usadas para fins de backup. Dessa forma, as operações de escrita não são afetadas durante o processo de backup;</p></li>
	<li><p align="justify"><b>Snapshots do sistema de arquivos: </b>Algumas ferramentas de backup permitem a criação de snapshots do sistema de arquivos subjacente ao banco de dados. Esses snapshots são capturas instantâneas dos arquivos de dados e log do banco de dados em um determinado momento, permitindo que você restaure esses arquivos para um estado consistente posteriormente, sem interromper as operações de escrita;</p></li>
	<li><p align="justify"><b>Backup baseado em transações: </b>Backup baseado em transações: Em vez de bloquear as tabelas inteiras, esse método permite apenas o bloqueio das transações em andamento no momento do backup, permitindo que outras operações de escrita prossigam normalmente. Uma vez que as transações ativas são concluídas, o backup é realizado.</p></li>
</ul>

<p align="justify">
	Essas são apenas algumas das opções disponíveis e a escolha da ferramenta ou método depende do banco de dados específico que está sendo usado e das necessidades e recursos da sua aplicação. É recomendável consultar a documentação do seu banco de dados ou buscar orientação técnica para determinar a melhor abordagem para os backups sem bloqueio.
</p>
