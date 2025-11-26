# Core Module Brief

## Context
- user go_router for main routing in this app.
- we will leverage go_router parameterized url for dynamic links
- we will use simple boolean with riverpod (authProvider) for maintaining state
- for now create simple local service with shared_preferences to save the user state (is logged in or not) at local db
- for now use this credentials : email : alice@gmail.com pass : 123456 as hardcoded when user submit.

## Scope        
- for now we just need to routing 2 page, login page and home page
- if user have shared pref isLoggedIn true then just route to home or anywhere in the app (assume user uses dynamic / parameterized link), else route to login

## Requirements
- create blank home page    
- change the routing in main.dart
- create routing.dart in lib/core/routing
- create full fledged data flow from repository, datasource and service (create local_db_service implementing shared_pref)
- remove unneeded boiler plate onSubmit and onSignUp, we will use provider so we only need to call it in login_form 

## Clues
- see this ref at ref/router-ref.md 

## Keep in Mind
- keep the clean architecture in tact
- use DRY and YAGNI principle (keep the changes as in the scope)