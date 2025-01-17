# 🚀 Projeto: Ambiente de Big Data com Docker

## 📌 Descrição
Este repositório contém a configuração de um ambiente baseado em **Docker** para desenvolvimento com **Python**, **PostgreSQL** e **Apache Spark/PySpark**. 

O objetivo é fornecer uma stack pronta para análise de dados, machine learning e engenharia de dados, utilizando contêineres para facilitar a instalação e configuração.

---

## 🏗️ Tecnologias Utilizadas

- **Docker & Docker Compose** → Gerenciamento de contêineres
- **Python 3.12** → Linguagem principal para análise e engenharia de dados
- **PostgreSQL** → Banco de dados relacional para armazenar dados estruturados
- **Apache Spark & PySpark** → Processamento distribuído para Big Data
- **Poetry** → Gerenciador de dependências do Python

---

## 📂 Estrutura do Projeto

```
📦 projeto
 ┣ 📂 src                 # Código-fonte
 ┃ ┣ 📜 app.py            # Arquivo principal Python
 ┃ ┣ 📜 requirements.txt  # Dependências
 ┣ 📜 docker-compose.yml  # Orquestração dos serviços
 ┣ 📜 Dockerfile          # Configuração da imagem Python
 ┗ 📜 README.md           # Documentação do projeto
```

---

## 🚀 Como Rodar o Projeto

### 🐳 1️⃣ Instalar Dependências
Certifique-se de ter o **Docker** e **Docker Compose** instalados no seu sistema:

- Instalar Docker: [Guia Oficial](https://docs.docker.com/get-docker/)
- Instalar Docker Compose: [Guia Oficial](https://docs.docker.com/compose/install/)

### ▶️ 2️⃣ Subir os contêineres
Execute o comando abaixo na raiz do projeto:

```sh
docker-compose up -d --build
```

### 📌 3️⃣ Acessar os serviços
- **Jupyter Notebook (se ativado)** → `http://localhost:8888`
- **PostgreSQL** → `localhost:5432` (usuário/senha definidos no `docker-compose.yml`)
- **Spark UI** → `http://localhost:8080`

---

## 📜 Código do Dockerfile
```dockerfile
FROM python:3.12-slim

# Instala dependências do sistema
RUN apt-get update && apt-get install -y wget openjdk-17-jdk && rm -rf /var/lib/apt/lists/*

# Instala o Poetry
RUN pip install poetry

# Define diretório de trabalho
WORKDIR /src

# Copia arquivos do projeto
COPY . /src

# Instala dependências do Python
RUN poetry install

CMD ["poetry", "run", "python", "app.py"]
```

---

## 📜 Código do docker-compose.yml
```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15
    container_name: postgres_db
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    ports:
      - "5432:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data

  spark:
    image: bitnami/spark:latest
    container_name: spark_master
    environment:
      - SPARK_MODE=master
    ports:
      - "8080:8080"
      - "7077:7077"

  python_app:
    build: .
    container_name: python_app
    depends_on:
      - postgres
      - spark
    volumes:
      - .:/src
    command: ["poetry", "run", "python", "app.py"]

volumes:
  pgdata:
```

---

## 🛠️ Comandos Úteis

- **Parar os contêineres:**
  ```sh
  docker-compose down
  ```

- **Reiniciar apenas o contêiner Python:**
  ```sh
  docker-compose restart python_app
  ```

- **Acessar o shell do contêiner PostgreSQL:**
  ```sh
  docker exec -it postgres_db psql -U user -d mydb
  ```

---

## 📝 Autor
Projeto desenvolvido por **[Seu Nome]**. 🚀

