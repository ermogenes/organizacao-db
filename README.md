# 👩‍💼👨‍💼 organizacao-db

Recursos referentes a bancos de dados de uma organização, para fins de testes de cenários.

Implementações em MySQL e Microsoft SQL Server.

## _Scripts_

- MySQL
  - [DDL (somente estrutura)](scripts/mysql/mysql-organizacao-DDL.sql)
  - [DDL (somente estrutura, sem `AUTO_INCREMENT` nas PKs)](scripts/mysql/mysql-organizacao-DDL-sem-AUTO_INCREMENT.sql)
  - [DML (somente dados)](scripts/mysql/mysql-organizacao-DML.sql)
  - [Ambos (estrutura e dados)](scripts/mysql/mysql-organizacao-DDL-DML.sql)
- SQL Server
  - [DDL (somente estrutura)](scripts/sqlserver/sqlserver-organizacao-DDL.sql)
  - [DDL (somente estrutura, sem `IDENTITY` nas PKs)](scripts/sqlserver/sqlserver-organizacao-DDL-sem-IDENTITY.sql)
  - [DML (somente dados)](scripts/sqlserver/sqlserver-organizacao-DML.sql)
  - [Ambos (estrutura e dados)](scripts/sqlserver/sqlserver-organizacao-DDL-DML.sql)

## Modelo de dados

Arquivo do MySQL Workbench: [`model/organizacao.mwb`](model/organizacao.mwb)

**Diagrama Entidade-Relacionamento**

![](assets/organizacao.png)

## Rodando com Docker

1. Baixe esse repositório, e acesse o seu conteúdo:

```bash
git clone https://github.com/ermogenes/organizacao-db
cd organizacao-db
```

2. Execute o comando de uma das versões abaixo:

  - _MySQL_: `docker compose up mysql`
  - _SQL Server_: `docker compose up sqlserver`
  - _Ambos_: `docker compose up`

### Credenciais:

Serviço | Endereço | Usuário | Senha
--- | --- | --- | ---
MySQL | `localhost:3307` | `root` | `root`
SQL Server | `localhost,1434` | `sa` | `My_secret_!2#4%`

### Todas as versões

- _Ambos_ com carga de dados:

```bash
docker compose up
```

- Carga de dados somente no _MySQL_:

```bash
docker compose --file dc-mysql-com-dados.yml up
```

- Carga de dados somente no _SQL Server_:

```bash
docker compose --file dc-sqlserver-com-dados.yml up
```

- Somente as estruturas, sem dados:

```bash
docker compose --file dc-somente-estrutura.yml up
```

⚠ _Se quiser criar um ambiente que não reaproveite nada de execuções anteriores, adicione o parâmetro `--force-recreate`._

**Versões incluíndo um cluster de Kafka Connect**

- _Ambos_ com carga de dados:

```bash
docker compose --file dc-kafka.yml up
```

- Carga de dados somente no _MySQL_, e PKs no _SQL Server_ sem `IDENTITY`:

```bash
docker compose --file dc-mysql-com-dados-kafka.yml up
```

- Carga de dados somente no _SQL Server_, e PKs no _MySQL_ sem `AUTO_INCREMENT`:

```bash
docker compose --file dc-sqlserver-com-dados-kafka.yml up
```

- Somente as estruturas, sem dados:

```bash
docker compose --file dc-somente-estrutura-kafka.yml up
```

**Versão somente com Kafka Connect, sem MySQL e SQL Server**

```bash
docker compose --file dc-somente-kafka.yml up
```

_Kafka UI em [http://localhost:3030](http://localhost:3030)._
