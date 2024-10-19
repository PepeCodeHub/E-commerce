# E-commerce
E-commerce Project base on microservices architecture

Overall Architecture
```mermaid
graph TD

    %% Backoffice Admin Interactions
    subgraph Backoffice
        direction TB
        backoffice[Backoffice] <-->|HTTP Requests| api_gateway
    end
    
    %% External Client (Customer)
    subgraph External Client
        direction TB
        client[Client] <-->|HTTP Requests| api_gateway
    end

    %% API Gateway routes to microservices
    subgraph API Gateway
        direction TB
        api_gateway[API Gateway] --> product_service[Product Service]
        api_gateway --> auth_service[Auth Service]
        api_gateway --> order_service[Order Service]
        api_gateway --> payment_service[Payment Service]
    end
    
    %% Logs Service
    subgraph Logging
        direction TB
        api_gateway --> logs_service[Logs Service]
    end
    
    %% Message broker (RabbitMQ) for inter-service communication
    subgraph Messaging
        direction TB
        order_service <-->|Publish Events| rabbitmq[(RabbitMQ)]
        payment_service <-->|Listen for Events| rabbitmq
    end
    
    %% Microservices to Redis
    subgraph Caching
        direction TB
        product_service <--> redis[(Redis)]
        auth_service <--> redis
        order_service <--> redis
        payment_service <--> redis
        logs_service <--> redis
    end
    
    %% Periodically update primary databases from Redis
    subgraph Databases
        direction TB
        redis <-->|Update Periodically| mongo[(MongoDB)]
        redis <-->|Update Periodically| postgres[(PostgreSQL)]
    end
    
    %% WebSocket interactions
    subgraph WebSocket Interactions
        direction TB
        client -.->|WebSocket Connection| websocket_service[WebSocket Service]
        websocket_service -.->|Notify Client| client
        websocket_service -.->|Notify Admin| backoffice
        websocket_service <-->|Send Notifications| rabbitmq
        product_service --> websocket_service
        order_service --> websocket_service
        payment_service --> websocket_service
        product_service -->|Product Unavailable| websocket_service
    end

    %% Direct links to databases for important services
    product_service <--> mongo
    auth_service <--> postgres
    order_service <--> postgres
    payment_service <--> postgres
```
