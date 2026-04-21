# Spring Boot Demo

A small Spring Boot app that exposes contact details.

## What this app returns

- `GET /contact` -> phone and email
- `GET /actuator/health` -> app health status

Example `/contact` response:

```json
{
  "phone": "123-456-7890",
  "email": "john.doe@example.com"
}
```

## Run locally (Windows PowerShell)

```powershell
cd "c:\Users\ggvfj\Downloads\All Projects\React\Springboot\demo\demo"
.\mvnw.cmd spring-boot:run
```

## Quick test

```powershell
Invoke-WebRequest -UseBasicParsing http://localhost:8080/contact | Select-Object -ExpandProperty Content
Invoke-WebRequest -UseBasicParsing http://localhost:8080/actuator/health | Select-Object -ExpandProperty Content
```

## Docker

Build image:

```powershell
docker build -t demo-springboot-local .
```

Run container:

```powershell
docker run --rm -p 8080:8080 demo-springboot-local
```

Test container endpoint:

```powershell
Invoke-WebRequest -UseBasicParsing http://localhost:8080/contact | Select-Object -ExpandProperty Content
```

## If port 8080 is busy

If you get `port already in use`, stop the old app/container first, then run again.
