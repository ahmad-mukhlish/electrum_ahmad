# Promotions Brief

## Context
- we will create plans UI and integration to firestore
- create plan entity (id (int), name, tagline, pricePerDay(int), pricePerWeek(int), 
  pricePerMonth(int), bestFor, terms (listOfStrings), hexColor(default : white)), freezed
- create plan dto (id (int), name, tagline, price-per-day(int), price-per-week(int), price-per-month(int), best-for, terms (listOfStrings), hex-color)
- create plan state for UI, include all entity + percentagePlanDiscount (calculated by price percentage margin user get for choosing weekly or monthly)
- the card background would be determined by the field hexColor, but it is in hex, create helper class for converting string hex into color
- would be implemented in web (horizontally) and mobile (vertically)
- integrate to firestore (collection name : plans)

## Scope
- resides in home screen (both mobile and web), in the below of promotions
- implement UI
- implement firestore integration
- use offline cache for firestore

## Requirements
- user could see list of carousel if connected or have offline cached
- the UI would be hidden if somehow there is an error and show snackbar error fetching promotions

## Clues
- see the current promotion data flow for reference
- for UI, see the references/plans.png

## Keep in Mind
- please keep clean code structure
- add comments / documentations in critical sections
- keep the changes as simple as you could
- implement DRY and YAGNI
