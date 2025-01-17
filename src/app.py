from pyspark.sql import SparkSession
import psycopg2

# Cria a sessão do Spark
spark = SparkSession.builder \
    .appName("SparkPostgresExample") \
    .config("spark.jars.packages", "org.postgresql:postgresql:42.6.0") \
    .getOrCreate()

# Conectar no PostgreSQL
conn = psycopg2.connect(
    dbname="mydatabase",
    user="user",
    password="password",
    host="postgres_db",
    port="5432"
)

print("Conectado ao PostgreSQL com sucesso!")

# Criar um DataFrame de exemplo no PySpark
data = [("Arthur", 10), ("Maria", 25), ("José", 30)]
df = spark.createDataFrame(data, ["Nome", "Idade"])

df.show()

# Fechar conexão com PostgreSQL
conn.close()