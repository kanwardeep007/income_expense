#!/bin/bash

# Set variables
CONTAINER_NAME="income_expense_postgres"
DB_NAME="income_expense_development"
DB_USER="appname"
DB_PASSWORD="password"
DB_PORT="5432"

# Check if the container already exists
if [ "$(docker ps -aq -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Container already exists. Starting it..."
    docker start ${CONTAINER_NAME}
else
    echo "Creating and starting new container..."
    docker run --name ${CONTAINER_NAME} \
        -e POSTGRES_DB=${DB_NAME} \
        -e POSTGRES_USER=${DB_USER} \
        -e POSTGRES_PASSWORD=${DB_PASSWORD} \
        -p ${DB_PORT}:5432 \
        -d postgres:13
fi

# Wait for the database to be ready
echo "Waiting for database to be ready..."
until docker exec ${CONTAINER_NAME} pg_isready -U ${DB_USER} -d ${DB_NAME}
do
    echo "Database is unavailable - sleeping"
    sleep 1
done

echo "Database is ready and accessible on localhost:${DB_PORT}"
echo "Database Name: ${DB_NAME}"
echo "User: ${DB_USER}"
echo "Password: ${DB_PASSWORD}"
