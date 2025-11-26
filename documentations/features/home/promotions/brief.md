# Promotions Brief

## Context
- we will create promotions UI and integration to firestore
  - create entity promotion (title, shortCopy, validity) with default values of empty strings, freezed
  - create entity dto (title, shortCopy (json annotated with name short-copy), validity)
  - create promotion card consist of title, short copy and validity
  - the card background would be randomly colored with the theme.of color primary, color seed and color secondary, change the alpha to made the text still visible
  - create UI (autoscroll carousel)
  - integrate to firestore (collection name : promotions)

## Scope
- resides in home screen (both mobile and web)
  - implement UI
  - implement firestore integration
  - use offline cache for firestore

## Requirements
- user could see list of carousel if connected or have offline cached
  - the UI would be hidden if somehow there is an error and show snackbar error fetching promotions

## Clues
- see at root/ref/firebase-ref.md as reference
  - use this library for carousel https://pub.dev/packages/carousel_slider

## Keep in Mind
- please keep clean code structure
  - add comments / documentations in critical sections
  - keep the changes as simple as you could
  - implement DRY and YAGNI
