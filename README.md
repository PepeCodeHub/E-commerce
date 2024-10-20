# E-commerce
E-commerce Project base on microservices architecture

```mermaid
graph TD
    %% Define the main project group
    subgraph project [Ecommerce]
        client[Client]
        backoffice[Backoffice]
        gateway[API Gateway]

        %% Define the microservices group within the project
        subgraph microservices [Microservices]
            cart[Cart Service]
            orders[Order Service]
            payments[Payment Service]
            products[Product Service]
            rabbitmq[RabbitMQ]
        end

        %% Define the databases group within the project
        subgraph databases [Databases]
            mongo[MongoDB]
            postgre[PostgreSQL]
        end

        %% Define the caching group within the project
        subgraph caching [Caching]
            redis[Redis]
        end

        %% Define the logging group within the project
        subgraph logging [Logging]
            logs[Logs Service]
        end

        %% Define the websocket group within the project
        subgraph websocketGroup [WebSocket]
            websocket[WebSocket Service]
        end
    end

    %% Connect client and backoffice to the API gateway
    client --> gateway
    backoffice --> gateway

    %% Connect API gateway to microservices
    gateway --> cart
    gateway --> orders
    gateway --> payments
    gateway --> products

    %% Connect microservices to databases
    cart --> mongo
    orders --> postgre
    payments --> postgre
    products --> mongo

    %% Connect microservices to RabbitMQ
    cart --> rabbitmq
    orders --> rabbitmq
    payments --> rabbitmq
    products --> rabbitmq

    %% Connect microservices to Redis
    cart --> redis
    orders --> redis
    payments --> redis
    products --> redis

    %% Connect microservices to Logs service
    orders --> logs
    payments --> logs
    products --> logs

    %% Connect Logs service to Redis
    logs --> redis

    %% Connect WebSocket for real-time data
    websocket <--> client
    websocket <--> backoffice
    websocket <--> cart
    websocket <--> orders
    websocket <--> payments
    websocket <--> products


    %% Note: Redis saves cache to MongoDB after 5 minutes
    redis -.->|Save Logs Cache Every 5 mins| mongo
```
