# Need to setup "listeners" for standalone server
# Or it'll trigger error "Connection to node -1 (localhost/127.0.0.1:9092) could not be established. Broker may not be available. (org.apache.kafka.clients.NetworkClient)"
echo "listeners=PLAINTEXT://localhost:9092" >> ./kafka/config/server.properties  


./kafka/bin/kafka-server-start.sh -daemon ./kafka/config/server.properties
./kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test
./kafka/bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic test

# add some test msgs
for x in {1..2}; do echo "Test Message ${x}"; done | ./kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test

# Output:
#
# Test Message 1
# Test Message 2

./kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
# Output:
#
# Test Message 1
# Test Message 2

# Processed a total of 2 messages
