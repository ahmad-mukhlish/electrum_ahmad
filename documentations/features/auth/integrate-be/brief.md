# Auth Backend Integration Brief

## Context
- integrate auth with firebase auth
- create firebase auth service
- implement register and sign in with firestore
- create user entity
- save user data on shared preferences (create user DTO)


## Scope
- register data flow (change the text on login page from "no account? sign up" to outlined button) as entry point
- sign-in data flow
- after sign-in user dto should be saved at shared preferences
- keep auth provider as is, only add firebaseDataSource for interacting with firebase auth service
- after login user should be see their name, photo and email at homepage
- when user sign-out delete the shared preference and update auth provider, invalidate firebase providers if needed

## Requirements
- user could use register functionality 
- user could use sign in functionality
- if already registered and register add snackbar : "already registered please login"
- if not already registered and login add snackbar : "not registered yet, please sign up"

## Clues
- see at root/ref/firebase-ref.md as reference

## Keep in Mind
- please keep clean code structure
- add comments / documentations in critical sections
- keep the changes as simple as you could
