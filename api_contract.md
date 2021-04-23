# Sweater Weather API Contract

## Endpoints

| HTTP verbs | Paths  | Used for | Output |
| ---------- | ------ | -------- | ------:|
| GET | /api/v1/forecast?location=denver,co | Get the weather for a location | [json](#weather-by-location) |
| GET | /api/v1/backgrounds?location=denver,co | Get a photo for a specific location | [json](#photo-by-location) |
| POST | /api/v1/users | create a user account | [json](#create-user) |
| POST | /api/v1/sessions | create a user session (login a user) | [json](#user-login) |
| POST | /api/v1/road_trip | create a new road trip | [json](#new-road-trip) |

### Weather by Location
```json
    {
      "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
          "current_weather": {
            "datetime": "2020-09-30 13:27:03 -0600",
            "temperature": 79.4,
            etc
          },
          "daily_weather": [
            {
              "date": "2020-10-01",
              "sunrise": "2020-10-01 06:10:43 -0600",
              etc
            },
            {...} etc
          ],
          "hourly_weather": [
            {
              "time": "14:00:00",
              "conditions": "cloudy with a chance of meatballs",
              etc
            },
            {...} etc
          ]
        }
      }
    }
```

### Photo by location

```json
    {
    "data": {
      "type": "image",
      "id": null,
      "attributes": {
        "image": {
          "location": "denver,co",
          "image_url": "https://pixabay.com/get/54e6d4444f50a814f1dc8460962930761c38d6ed534c704c7c2878dd954dc451_640.jpg",
          "credit": {
            "source": "pixabay.com",
            "author": "quinntheislander",
            "logo": "https://pixabay.com/static/img/logo_square.png"
          }
        }
      }
    }
  }
```


### Create User
- Request
  ```json
    POST /api/v1/users
    Content-Type: application/json
    Accept: application/json

    {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
  ```
- Response
  ```json
    status: 201
    body:

    {
      "data": {
        "type": "users",
        "id": "1",
        "attributes": {
          "email": "whatever@example.com",
          "api_key": "jgn983hy48thw9begh98h4539h4"
        }
      }
    }
  ```

### User Login
- Request
  ```json
    POST /api/v1/sessions
    Content-Type: application/json
    Accept: application/json

    {
    "email": "whatever@example.com",
    "password": "password"
    }
  ```

- Response
  ```json
    status: 200
    body:

    {
      "data": {
        "type": "users",
        "id": "1",
        "attributes": {
          "email": "whatever@example.com",
          "api_key": "jgn983hy48thw9begh98h4539h4"
        }
      }
    }
  ```

  ### New Road trip
  - Request
  ```json
    Content-Type: application/json
    Accept: application/json

    body:

    {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  ```
  - Response
  ```json
      {
      "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
          "start_city": "Denver, CO",
          "end_city": "Estes Park, CO",
          "travel_time": "2 hours, 13 minutes",
          "weather_at_eta": {
            "temperature": 59.4,
            "conditions": "partly cloudy with a chance of meatballs"
          }
        }
      }
    }
  ```
