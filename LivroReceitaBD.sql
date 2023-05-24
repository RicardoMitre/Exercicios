-- MySQL Workbench Synchronization
-- Generated: 2023-05-24 11:19
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: 06893796170

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `livroreceita` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `livroreceita`.`Receita` (
  `nome` VARCHAR(45) NOT NULL COMMENT 'Contém o nome da receita.\n\nExemplo: \nMacarronada\nFeijoada\nPizza\n...',
  `cozinheiro` SMALLINT(6) NOT NULL COMMENT 'Contémo identificador único do Cozinheiro(Funcionario).\n\nExemplo:\n0001\n0002\n...',
  `idReceita` INT(11) NOT NULL COMMENT 'Contém o identificador único da receita.\n\nExemplo: \n000001\n000002\n...',
  `dtCriacao` DATE NOT NULL COMMENT 'Contem a data de cadastramento da receita.\n\nExemolo: \n12/01/2010\n...',
  `idCategoria` INT(11) NOT NULL,
  `modo_preparo` VARCHAR(1000) NOT NULL COMMENT 'Contém a descrição detalhada do modo de preparo da receita.\n\nExemplo: \n\nModo de Preparo:\n\n1.  Em um recipiente, misture a farinha de trigo, o açúcar, o Chocolate em Pó DOIS FRADES, o fermento e o bicarbonato peneirados.\n2.  Junte o óleo, os ovos e a água fervente, misturando bem.\n3.  Despeje a massa em uma forma de furo central (24 cm de diâmetro) untada com óleo e polvilhada com farinha de trigo, e leve ao forno médio (180°C), preaquecido, por 40 minutos.\n',
  `qtd_porcao` SMALLINT(6) NULL DEFAULT NULL COMMENT 'Contém a informação de quantidade de porções que a receita atende.\n\nExemplo: \nQuantidade   Poçrões\n0002             \n0010',
  `degustador` SMALLINT(6) NULL DEFAULT NULL COMMENT 'contém o nome do degustador da receita.\n\nEmemplo:\n\nmateus\njoao\npedro',
  `dt_degustacao` DATE NULL DEFAULT NULL COMMENT 'contém a data da degustação.\n\nExemplo:\n\n10/03/2001\n15/12/2007',
  `nota_degustacao` DECIMAL(3,1) NULL DEFAULT NULL COMMENT 'contém a nota da receita avaliada pelo degustador.\n\nExemplo:\n\n5,5\n10\n2,9',
  `ined_receita` CHAR(1) NOT NULL COMMENT 'Contém um indicador de receita inédita,ou seja, a receita é inédita quando não foi publicada em um livro.\n\nExemplo:\ninedita   valor\nsim           s\nnao          n',
  PRIMARY KEY (`nome`, `cozinheiro`),
  INDEX `fk_Receita_Funcionario_idx` (`cozinheiro` ASC) VISIBLE,
  UNIQUE INDEX `idReceita_UNIQUE` (`idReceita` ASC) VISIBLE,
  INDEX `fk_Receita_Categoria1_idx` (`idCategoria` ASC) VISIBLE,
  INDEX `fk_Receita_Funcionario1_idx` (`degustador` ASC) VISIBLE,
  CONSTRAINT `fk_Receita_Funcionario`
    FOREIGN KEY (`cozinheiro`)
    REFERENCES `livroreceita`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Receita_Categoria1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `livroreceita`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Receita_Funcionario1`
    FOREIGN KEY (`degustador`)
    REFERENCES `livroreceita`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `livroreceita`.`Funcionario` (
  `idFuncionario` SMALLINT(6) NOT NULL AUTO_INCREMENT COMMENT 'Contem o identificador único do funcionario.\n\nExemplo:\n0001\n0002\n0003\n...',
  `rg` CHAR(15) NOT NULL COMMENT 'Contém o número de identificção do Registro Geral do funcionário.\n\nExemplo:\n0000-000\n1234-789',
  `nome` VARCHAR(80) NOT NULL COMMENT 'Contém o nome do funcionário.\n\nExemplo:\nMarcos\nMateus\nJoão',
  `dt_ingr` DATE NOT NULL COMMENT 'Contem a data de ingresso (adimição) do funcinário. dd/mm/yyyy\n\nExemplo:\n\n16/07/2000\n18/12/2007\n...',
  `slario` DECIMAL(9,2) NOT NULL COMMENT 'Contém o salário de contrataão do funcionário.\n\nExemplo: \n20000,00\n05689,33\n...',
  `idCargo` SMALLINT(6) NOT NULL COMMENT 'Contém a o identificado do cargo do funcioário.\n\nExemplo:\n0001\n0002\n...',
  `nome_fantasia` VARCHAR(25) NULL DEFAULT NULL COMMENT 'Contém o apelido do funcionario\n\nExemplo:\n\nnome fantasia  nome\nPele                  Edison',
  PRIMARY KEY (`idFuncionario`),
  UNIQUE INDEX `rg_UNIQUE` (`rg` ASC) VISIBLE,
  INDEX `fk_Funcionario_Cargo1_idx` (`idCargo` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Cargo1`
    FOREIGN KEY (`idCargo`)
    REFERENCES `livroreceita`.`Cargo` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `livroreceita`.`Cargo` (
  `idCargo` SMALLINT(6) NOT NULL AUTO_INCREMENT COMMENT 'Contém o identificador do cargo do funcionario.\n\nExemplo:\n\n00001 Cozinheiro\n00002 Editor\n...',
  `descricao` VARCHAR(45) NOT NULL COMMENT 'Contem a descrição cargo do funcionário.\n\nExemplo:\n\nCozinheiro\nEditor\n...',
  PRIMARY KEY (`idCargo`),
  UNIQUE INDEX `Cargo_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `livroreceita`.`Categoria` (
  `idCategoria` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Contém o identificador da categoria da receita.\n\nExemplo:\n\n00001 carne\n00002 ave\n...',
  `descricao` VARCHAR(45) NOT NULL COMMENT 'Contém a descrição da categoria da receita.\n\nExemplo:\n\n00001 carne\n00002 ave\n...',
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `livroreceita`.`Ingrediente` (
  `idIngrediente` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Contém a identificação única do inggrediente.\n\nExemplo:\n\nidIngrediente       nome\n1                          açucar\n2                          ovo\n3                          farinha',
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(200) NULL DEFAULT NULL COMMENT 'Contém um descrição para ingredientes exóticos.\n\nExemplo:\n\nUmeboshi: Umeboshi é uma especialidade da culinária japonesa que consiste em umê em conserva, por isso um tipo de tsukemono. É caracterizado pelo seu sabor forte muito ácido e salgado. O umê é originário da China e é normalmente chamado de ameixa apesar de ser um parente mais próximo do damasco.',
  PRIMARY KEY (`idIngrediente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `livroreceita`.`Receita_Ingrediente` (
  `nome` VARCHAR(45) NOT NULL COMMENT 'Contém o nome da receita.\n\nExemplo: \nMacarronada\nFeijoada\nPizza\n...',
  `cozinheiro` SMALLINT(6) NOT NULL COMMENT 'Contém o identificador único do Cozinheiro(Funcionario).\n\nExemplo:\n0001\n0002\n...',
  `idIngrediente` INT(11) NOT NULL COMMENT 'Contém a identificação única do inggrediente.\n\nExemplo:\n\nidIngrediente       nome\n1                          açucar\n2                          ovo\n3                          farinha',
  `idMedida` SMALLINT(6) NOT NULL COMMENT 'Contem o identificador único da medida dos ingredientes.\n\nExemplo:\nid               descrição\n0001         xicara\n0002         ml\n...',
  `qtd_medida` SMALLINT(6) NULL DEFAULT NULL COMMENT 'Contém a quantidade da medida do ingrediente.\n\nExemplo:\n\n0002\n0001\n...',
  PRIMARY KEY (`nome`, `cozinheiro`, `idIngrediente`),
  INDEX `fk_Receita_has_Ingrediente_Ingrediente1_idx` (`idIngrediente` ASC) VISIBLE,
  INDEX `fk_Receita_has_Ingrediente_Receita1_idx` (`nome` ASC, `cozinheiro` ASC) VISIBLE,
  INDEX `fk_Receita_Ingrediente_Medida_Ingrediente1_idx` (`idMedida` ASC) VISIBLE,
  CONSTRAINT `fk_Receita_has_Ingrediente_Receita1`
    FOREIGN KEY (`nome` , `cozinheiro`)
    REFERENCES `livroreceita`.`Receita` (`nome` , `cozinheiro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Receita_has_Ingrediente_Ingrediente1`
    FOREIGN KEY (`idIngrediente`)
    REFERENCES `livroreceita`.`Ingrediente` (`idIngrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Receita_Ingrediente_Medida_Ingrediente1`
    FOREIGN KEY (`idMedida`)
    REFERENCES `livroreceita`.`Medida_Ingrediente` (`idMedida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `livroreceita`.`Medida_Ingrediente` (
  `idMedida` SMALLINT(6) NOT NULL AUTO_INCREMENT COMMENT 'Contem o identificador único da medida dos ingredientes.\n\nExemplo:\nid               descrição\n0001         xicara\n0002         ml\n...',
  `descricao` VARCHAR(45) NOT NULL COMMENT 'Contem o identificador único da medida dos ingredientes.\n\nExemplo:\nid               descrição\n0001         xicara\n0002         ml\n...',
  PRIMARY KEY (`idMedida`),
  UNIQUE INDEX `idMedida_Ingrediente_UNIQUE` (`idMedida` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `livroreceita`.`Restaurante` (
  `idRestaurante` SMALLINT(6) NOT NULL AUTO_INCREMENT COMMENT 'Contem o identificador único do restaurante.\n\nExemplo:\nid              restaurante\n0001        churrascaria\n0002        mcdonalds\n0003        girafas\n...',
  `nome` VARCHAR(45) NOT NULL COMMENT 'Contem o identificador único do restaurante.\n\nExemplo:\nid              restaurante\n0001        churrascaria\n0002        mcdonalds\n0003        girafas\n...',
  `contato` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Contém o contato do restalrante.\n\nExemplo: \nrestalrante@gmai.com',
  PRIMARY KEY (`idRestaurante`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `livroreceita`.`Referencia` (
  `cozinheiro` SMALLINT(6) NOT NULL,
  `idRestaurante` SMALLINT(6) NOT NULL,
  `dt_inicio` DATE NOT NULL COMMENT 'Contém a data de inicio do contrato no restalrante.\n\nExemplo: \n10/10/2010',
  `dt_fim` DATE NULL DEFAULT NULL COMMENT 'Contém a data de fim do contrato no restalrante.\n\nExemplo: \n10/10/2010',
  PRIMARY KEY (`cozinheiro`, `idRestaurante`),
  INDEX `fk_Funcionario_has_Restaurante_Restaurante1_idx` (`idRestaurante` ASC) VISIBLE,
  INDEX `fk_Funcionario_has_Restaurante_Funcionario1_idx` (`cozinheiro` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_has_Restaurante_Funcionario1`
    FOREIGN KEY (`cozinheiro`)
    REFERENCES `livroreceita`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_has_Restaurante_Restaurante1`
    FOREIGN KEY (`idRestaurante`)
    REFERENCES `livroreceita`.`Restaurante` (`idRestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `livroreceita`.`parametros` (
  `idmes` SMALLINT(6) NOT NULL COMMENT 'contém o mês determinado para produção das receitas.\n\nExemplo:\n\nmes     ano     quantidade\n05       2023          4\n07       2024          3\n11       2024         10',
  `idano` SMALLINT(6) NOT NULL COMMENT 'contém o ano determinado para produção das receitas.\n\nExemplo:\n\nmes     ano     quantidade\n05       2023          4\n07       2024          3\n11       2024         10',
  `qtd_receitas` SMALLINT(6) NOT NULL COMMENT 'contém a quantidade de receitas do mes.\n\nExemplo:\n\nmes     ano     quantidade\n05       2023          4\n07       2024          3\n11       2024         10',
  PRIMARY KEY (`idmes`, `idano`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `livroreceita`.`Livro` (
  `idLivro` SMALLINT(6) NOT NULL AUTO_INCREMENT COMMENT 'Coném o identificador único do livro.\n\nExemplo:\nid livro     nome\n001         Receitas de Natal\n002         Receitas de Natal 2\n003         Receitas de Minas',
  `titulo` VARCHAR(45) NOT NULL COMMENT 'Coném o titulo único do livro.\n\nExemplo:\nid livro     nome\n001         Receitas de Natal\n002         Receitas de Natal 2\n003         Receitas de Minas',
  `cod_ISBN` CHAR(20) NOT NULL COMMENT 'o ISBN (International Standard Book Number/ Padrão Internacional de Numeração de Livro) é um padrão numérico criado com o objetivo de fornecer uma espécie de “RG” para publicações monográficas, como livros, artigos e apostilas. A difusão global do ISBN e a facilidade com que é lido por redes de varejo, bibliotecas e sistemas gerais de catalogação.A sequência é criada a partir de um sistema de registro utilizado pelo mercado editorial e livreiro em todo o mundo. A estrutura do ISBN é composta de 13 números que indicam o título, o autor, o país, a editora e a edição de uma obra.\n\nExemplo:\n123-45-67890-12-3',
  `editor` SMALLINT(6) NOT NULL COMMENT 'Contem o identificador único do funcionario editor do livro.\n\nExemplo:\n0001\n0002\n0003\n...',
  PRIMARY KEY (`idLivro`),
  UNIQUE INDEX `titulo_UNIQUE` (`titulo` ASC) VISIBLE,
  UNIQUE INDEX `cod_ISBN_UNIQUE` (`cod_ISBN` ASC) VISIBLE,
  INDEX `fk_Livro_Funcionario1_idx` (`editor` ASC) VISIBLE,
  CONSTRAINT `fk_Livro_Funcionario1`
    FOREIGN KEY (`editor`)
    REFERENCES `livroreceita`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
