<h1><b>EchangeBooks</h1>

- [Nicolas Hidalgo](https://github.com/nico1710)
- [Nicolas Pereira](https://github.com/nico1710)

## Introduction

ExchangeBooks is a software project, which consists of an opportunity to exchange books between users, it also has a recommendation system based on user preferences.
The project is developed as a mobile application, and It has own server.
The project is developing of the following technologies:

- [Flutter](https://flutter.dev)
- [Express.js](https://expressjs.com/)
- [OpenaAI](https://openai.com/blog/openai-api)
- [MongoDB](https://www.mongodb.com)
- [Firebase](https://firebase.google.com)

## Install API

#### Install dependencies in all services folders

    npm install

#### Run services

    npm run dev

# REST API

The REST API work in http://localhost:3000

## Gateway Service

<h4>Verify service is running</h4>

<span style="color:blue">GET</span> `/`

    curl -i -H 'Accept: application/json' http://localhost:3000

<h4>Get all services</h4>

<span style="color:blue">GET</span> `/services`

    curl -i -H 'Accept: application/json' http://localhost:3000/services

<br />

## Auth Service

<h4>Verify auth service is running</h4>

<span style="color:blue">GET</span> `/api/auth`

    curl -i -H 'Accept: application/json' http://localhost:3000/api/auth

<h4>Sign up a new user</h4>

<font color="greenyellow">POST</font> `/api/auth/create`

    curl -i -H 'Accept: application/json' http://localhost:3000/api/auth/create

```
name: string
lastname: string
email: string
password?: string
googleId?: string
```

<h4>Verify if a user is register in the database</h4>

<font color="greenyellow">POST</font> `/api/auth/verify`

    curl -i -H 'Accept: application/json' http://localhost:3000/api/auth/verify

```
email: string
```

<h4>Edit user information</h4>

<font color="orange">PUT</font> `/api/auth/updateUser/:userId`

    curl -i -H 'Accept: application/json' http://localhost:3000/api/auth/updateUser/:userId

```
email: string
```

<h4>Get user information by email</h4>

<font color="blue">GET</font> `/api/auth/get-user/:email`

    curl -i -H 'Accept: application/json' http://localhost:3000/api/auth/get-user/:email

<br />

## Genre Service

<h4>Verify genre service is running</h4>

<font color="blue">GET</font> `/api/genre`

    curl -i -H 'Accept: application/json' http://localhost:3000/api/genre

<h4>Create a genre</h4>

<font color="greenyellow">POST</font> `/api/genre/create`

    curl -i -H 'Accept: application/json' http://localhost:3000/api/genre/create

```
name: string
```

<br />

## Upload Service

<h4>Verify upload service is running</h4>

<font color="blue">GET</font> `/api/upload`

    curl -i -H 'Accept: application/json' http://localhost:3000/api/upload

<h4>Upload files to AWS S3</h4>

<font color="greenyellow">POST</font> `/api/upload/files`

    curl -i -H 'Accept: application/json' http://localhost:3000/api/upload/files?folder=${value}

Query

```
folder: string
```
