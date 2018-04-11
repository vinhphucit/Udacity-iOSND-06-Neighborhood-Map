# Finding nearby restaurants

### This app was built for project 6 of Udacity's iOS Developer Nanodegree
A neighborhood map built with AppleMap that shows locations of nearby restaurants. Restaurants will be got from FourSquare API, users can preview the restaurants and add them to their favourite list.

# Project Details

### User Interface
* Five main View Controllers:
  - Map View Controller
  - Preview View Controller
  - Favourite View Controller
  - Restaurant Photos View Controller
  - Favourite Map View Controller
* The Map View Controller and Favourite Map View Controller are using Map Kit View
* Favourite View Controller are using Table View
* Restaurant Photos View Controller are using Collection View to show the restaurant's photos
* Map View Controller and Favourite View Controller are embeded in Tab View Controller 
* Map View Controller and Preview View Controller are embeded in Navigation View Controller
* Favourite View Controller and Restaurant Photos View Controller and Favourite Map View Controller are embeded in Navigation View Controller

### Networking

* FourSquare API is used to retrieve restaurants and photos:
  - https://api.foursquare.com/v2/venues/search
  - https://api.foursquare.com/v2/venues/VENUE_ID/photos

* While an online search is in progress, an Activity Indicator is displayed
* An alert view will be displayed, if there was a network error
* When user choose load restaurants in Map View Controller, app will make an api call to Foursquare's search api and if the restaurants are loaded successfully, they will be shown on Map
* In the favourite table view, when user click into each row, app will check if that favourite restaurant's photos weren't loaded, app will call Foursquare's photos api and get photos of that restaurant.

### Persistence

* Favourite restaurants and their photos are stored in Core Data
* the coordinate of current location on map is saved in NSUserDefaults, the next time when user get back, app will automatically come back to last coordinate
