# E-commerce
E-commerce Project base on microservices architecture

```mermaid
graph TD
    %% Clients
    subgraph Clients
        A[Client App]
        B[BackOffice]
    end
    
    %% Microservices (Core and Event-Driven)
    subgraph Microservices
        %% Core Services
        Auth[Auth Service]
        Orders[Orders Service]
        Payments[Payments Service]
        
        %% Event-Driven Services
        Notifications[Notifications Service]
        
        %% RabbitMQ
        RabbitMQ((RabbitMQ))
    end
    
    %% Data Stores
    subgraph DataStores
        DB[(PostgreSQL)]
        Redis[(Redis Cache)]
        Mongo[(MongoDB)]
    end
    
    %% Client interactions
    A -->|Login| Auth
    B -->|Login| Auth
    A -->|Place Order| Orders
    B -->|Manage Orders| Orders
    
    %% Core Services interactions
    Auth -->|Process Users| DB
    Orders -->|Processes Payments| Payments
    Payments -->|Writes Transactions| DB
    
    %% RabbitMQ event flow (Publishers)
    Orders -->|Publishes to| RabbitMQ
    Payments -->|Publishes to| RabbitMQ
    
    %% RabbitMQ event flow (Subscribers)
    RabbitMQ -->|Sends to| Notifications
    
    %% Event-driven services storing data
    Notifications -->|Stores Notifications| Mongo
    
    %% Caching and Data Access
    Orders --> Redis
    Payments --> Redis
```
