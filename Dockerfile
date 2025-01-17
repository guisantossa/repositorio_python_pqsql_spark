# Usa a imagem base do Python
FROM python:3.12

# Define variáveis de ambiente do Spark
ENV SPARK_VERSION=3.5.4
ENV HADOOP_VERSION=3
ENV SPARK_HOME=/opt/spark
ENV PATH="$SPARK_HOME/bin:$PATH"
ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=python3

# Instala dependências do sistema

RUN apt-get update && apt-get install -y --no-install-recommends \
    default-jdk \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Baixa e instala o Apache Spark
RUN wget -qO - https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | tar xz -C /opt \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME}


# Instala dependências do Python
COPY src/requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copia o código da aplicação
COPY src /app

# Porta usada pelo PySpark
EXPOSE 4040

# Comando padrão ao iniciar o container
CMD ["python", "app.py"]