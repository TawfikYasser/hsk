./kafka/bin/kafka-server-start.sh -daemon /home/tawfik/Softy/kafka/config/server.properties
./kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic test
./kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
>Test Message 1
>Test Message 2
>^C
./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
Test Message 1
Test Message 2
^C
Processed a total of 2 messages