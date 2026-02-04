# MySQL 8.4 -- Container Docker (VPS)

Este container fornece um **serviço MySQL 8.4** rodando em uma **VPS**,
com persistência de dados, scripts de inicialização e integração com uma
**rede Docker externa (`traefik-net`)** para consumo por outras
aplicações containerizadas.

O banco **não é exposto publicamente**, apenas via `localhost`, sendo
acessado por aplicações backend dentro da mesma VPS/rede Docker.

------------------------------------------------------------------------

## Stack

-   **MySQL**: 8.4\
-   **Docker / Docker Compose**\
-   **Rede externa**: `traefik-net`\
-   **Persistência**: Docker Volume

------------------------------------------------------------------------

## Arquitetura

-   Container MySQL isolado
-   Volume persistente para dados
-   Execução automática de scripts SQL na inicialização
-   Healthcheck configurado
-   Comunicação segura via Docker Network

------------------------------------------------------------------------

## Estrutura de arquivos

``` txt
mysql/
├─ docker-compose.yml
├─ .env
├─ init-scripts/
│  ├─ mysql-init.sql
└─ README.md
```

------------------------------------------------------------------------

## ⚙️ Variáveis de Ambiente

As variáveis são carregadas via arquivo `.env`:

``` env
MYSQL_DATABASE=app_db
MYSQL_USER=app_user
MYSQL_PASSWORD=strong_password
MYSQL_ROOT_PASSWORD=root_password
```

------------------------------------------------------------------------

## Docker Compose 

-   Imagem oficial `mysql:8.4`
-   Volume persistente para dados
-   Scripts de inicialização em `/docker-entrypoint-initdb.d`
-   Healthcheck ativo
-   Rede Docker externa compartilhada

### Rede Docker

``` yaml
networks:
  net:
    external: true
    name: traefik-net
```

------------------------------------------------------------------------

## Healthcheck

O serviço utiliza `mysqladmin ping` para validar disponibilidade:

-   Intervalo: 5s
-   Timeout: 5s
-   Tentativas: 10

------------------------------------------------------------------------

## Segurança

-   Porta 3306 **não exposta publicamente**
-   Bind apenas em `127.0.0.1`
-   Acesso externo somente via SSH Tunnel (se necessário)
-   Comunicação entre containers via rede privada Docker

------------------------------------------------------------------------

## Subindo o serviço

``` bash
docker compose up -d
```

Verificar status:

``` bash
docker ps
docker logs mysql8
```

------------------------------------------------------------------------

## Conexão a partir de outros containers

Dentro da rede `traefik-net`:

``` txt
Host: mysql8
Port: 3306
User: MYSQL_USER
Password: MYSQL_PASSWORD
Database: MYSQL_DATABASE
```
