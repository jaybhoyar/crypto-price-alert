# CRYPTO PRICE ALERT

This is a Crypto Price Alert Application built with Ruby on Rails. It allows users to create alerts for cryptocurrency prices and receive notifications when the target price is reached.

## Prerequisites
- Ruby v3.3.0
- Postgres
- Docker
- Docker Compose
- Redis

## Running the Project

1. **Clone the Repository**

    ```bash
      git clone https://github.com/jaybhoyar/crypto-price-alert.git
      cd crypto-price-alert
    ```

2. **Start the Application**
    ```bash
      docker-compose up --build
    ```
3. **Access the Application**

    The Rails server will be available at http://localhost:3000.


## API Endpoints
### User Registration
**Endpoint: POST /api/users**

Description: Register a new user.

Request Body:

  ```json
    {
      "user": {
        "email": "peter@example.com",
        "password": "welcome",
        "password_confirmation": "welcome"
      }
    }
  ```

### User Login
**Endpoint: POST /api/auth/login**

Request Body:

  ```json
    {
      "user": {
        "email": "peter@example.com",
        "password": "welcome",
      }
    }
  ```
Response 

  ```json
    {
      "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MjUzNDMyOTF9.k4k1tl3zkewz9Z180HCqpZbg-9xP-Q6Y9fFsow1AcA4",
      "user": {
          "id": 1,
          "email": "peter@example.com",
          "password_digest": "$2a$12$fzTWVBbiVGM0S3EUpRCWg.84jcbCtreObfw2ZDTkFTYnfG.8bULNW",
          "created_at": "2024-09-02T06:01:26.420Z",
          "updated_at": "2024-09-02T06:01:26.420Z"
      }
    }
  ```

### Create Alert
**Endpoint**: `POST /api/alerts`

Description: Create a new price alert.

Request Body:

  ```json
    {
      "coin": "BTC",
      "target_price": 58036.00
    }
  ```
**Auth Required: Yes**

Request Header:

  ```json
    {
      "Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MjUzNDMyOTF9.k4k1tl3zkewz9Z180HCqpZbg-9xP-Q6Y9fFsow1AcA4",
      "Content-Type": "application/json"
    }
  ```

Response 

  ```json
    {
      "alert": {
        "id": 1,
        "user_id": 2,
        "coin": "BTC",
        "target_price": "58036.0",
        "status": "created",
        "created_at": "2024-09-01T11:44:49.466Z",
        "updated_at": "2024-09-01T11:44:49.466Z"
      }
    }
  ```

### Fetch All Alerts

- **Endpoint:** `GET /api/alerts`
- **Description:** Retrieve all alerts associated with the current user.
- **Query Parameters:**
  - `status` (optional): Filter alerts by status (e.g., `created`, `triggered`).
  - `page` (optional): Page number for pagination.
  - `per_page` (optional): Number of alerts per page.

- **Auth Required: Yes**

- Request Header:

  ```json
    {
      "Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MjUzNDMyOTF9.k4k1tl3zkewz9Z180HCqpZbg-9xP-Q6Y9fFsow1AcA4",
      "Content-Type": "application/json"
    }
  ```

- **Response:**

  ```json
  {
    "alerts": [
      {
        "id": 1,
        "coin": "BTC",
        "target_price": 33000,
        "status": "created",
        "created_at": "2023-09-01T00:00:00Z",
        "updated_at": "2023-09-01T00:00:00Z"
      }
    ],
    "current_page": 1,
    "total_pages": 1,
    "total_count": 1
  }


### Delete an Alert 
 
- **Endpoint:** `DELETE /api/alerts/:id`
- **Description:** Delete an existing alert.
- **Request Parameters:**
  - `id`: The ID of the alert to be deleted (URL parameter).

 **Auth Required: Yes**

Request Header:

  ```json
    {
      "Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MjUzNDMyOTF9.k4k1tl3zkewz9Z180HCqpZbg-9xP-Q6Y9fFsow1AcA4",
      "Content-Type": "application/json"
    }
  ```

**Response:**

  ```json
    {
      "message": "Alert deleted"
    }
  ```


### Background Processing
  Alerts are checked asynchronously using Sidekiq.

### Authentication
  JWT: Authentication is handled using JWT tokens. Users need to be authenticated to access most endpoints.

### Additional Notes
  WebSocket: The application uses WebSocket to receive real-time price updates for cryptocurrency.
  Notifications: When a target price is reached, a console notification will be printed in the following format:

  ```bash
    ALERT TRIGGERED: User peter@example.com's alert for BTC has been triggered. Target price: $58000, Current price: $58000
  ```