FROM openjdk:17-jdk-slim

RUN mkdir /javavulny /app
COPY . /javavulny/
# Update the DB host as needed
RUN sed -i 's/localhost:5432/db:5432/' /javavulny/src/main/resources/application.yaml

RUN cd /javavulny \
    && ./gradlew --no-daemon build \
    && cp build/libs/java-spring-vuly-0.2.0.jar /app/ \
    && rm -rf build/ \
    && cd / \
    && rm -rf /javavulny /root/.gradle/

WORKDIR /app
ENV PWD=/app

# Make sure you reference the final .jar name correctly here
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/java-spring-vuly-0.2.0.jar"]
