# Core Module Brief

## Context
- we will implement main-screen navigation
- for the webview we will use sidebar
- for the mobile view we will use bottom navbar
- mobile and webview should be referencing to one provider (navigatorProvider)
- the menus : home, bikes, profile
- move current home screen implementation to profile page (including logout)

## Scope        
- create routing for each menu navigation, we should make every navigation accessible from external link (provided user has logged in)
- every menus have proper icon and have different icon (outlined and filled) based on user selection
- no need to fill anything yet in every menu layout except the profile

## Requirements
- create main feature
- create separate screen file for mobile view and web view
- create proper routing

## Clues
- see this library for sidebar in webview https://pub.dev/packages/easy_sidemenu

## Keep in Mind
- keep the clean architecture in tact
- keep webview still needs to be responsive