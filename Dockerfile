# Étape 1 : Build de l'application
FROM maven:3.9.4-eclipse-temurin-17 AS builder
WORKDIR /workspace

# Copier les fichiers Maven et le code source
COPY pom.xml mvnw mvnw.cmd ./
COPY .mvn .mvn
COPY src src

# Construire le projet sans lancer les tests
RUN mvn -B -DskipTests package

# Étape 2 : Exécution de l'application
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copier le WAR construit
COPY --from=builder /workspace/target/*.war /app/app.war

# Exposer le port
EXPOSE 8080

# Variables d'environnement par défaut (modifiable via docker-compose)
ENV SPRING_DATASOURCE_URL=jdbc:mysql://db:3306/notes_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
ENV SPRING_DATASOURCE_USERNAME=tpuser
ENV SPRING_DATASOURCE_PASSWORD=tppass
ENV SPRING_JPA_HIBERNATE_DDL_AUTO=none

# Lancer l'application
ENTRYPOINT ["sh", "-c", "java -jar /app/app.war"]
