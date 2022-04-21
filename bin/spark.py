strings = spark.read.text("file:///home/tawfik/Softy/spark-3.2.1/README.md")
strings.show(10, truncate=False)