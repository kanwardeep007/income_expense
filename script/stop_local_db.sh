#!/bin/bash

# Set variables
CONTAINER_NAME="income_expense_postgres"

# Check if the container exists
if [ "$(docker ps -aq -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Stopping container ${CONTAINER_NAME}..."
    docker stop ${CONTAINER_NAME}
    
    echo "Removing container ${CONTAINER_NAME}..."
    docker rm ${CONTAINER_NAME}
    
    echo "Container ${CONTAINER_NAME} has been stopped and removed."
else
    echo "Container ${CONTAINER_NAME} does not exist."
fi
