# City Sights App
This app displays the best restaurants and sights near the current user as shown by Yelp. It is  
 based on the https://codewithchris.com iOS Foundations Module 6. Highly recommend Code with Chris+, which teaches you 
 the fundamentals and beyond for iOS development. It also provides a thriving community.


# Getting User Location
Add to the pslist, or the Info target tab a new key explaining the use of this information:
`Privacy - Location When In use ...`

![Shows settings for the Location Usage](img/pslist_location.png)

You can set in the simulator a few locations to artificially display:
![Simulator Location](img/location_simulator.png)

# Interacting with Yelp API
Anyone can sign up for a free API key for Yelp https://www.yelp.com/developers/documentation/v3/get_started.

## Keeping Credentials Secure
Setup your credentials in the `ProdEnv.swift` file. See `ProdEnvExample.swift` for exactly what you need to do. 

## Viewing web Request Details
There is an excellent tool that allows us to view the raw network traffic from the iOS Simulator, [Proxyman](http://proxyman.io).

Once downloaded, and installed, you should add Proxyman's root SSL certificate to your MacOS Trust Chain, so that it can decrypt HTTP
traffic. 

Make a web request with your iOS simulator. Then, Proxyman will detect this request, open the Apps window on the left to view this. 
From here, click your app. After this, click the request that Proxyman detected. You may have to run this request again for it to work. 
Then, click the install SSL Certificate button for the app. This certificate will last the duration of this particular iOS Simulator. So once
you destory this Simulator, you may need to repeat these steps:

![SSL Certificate setup in Proxyman](img/proxy_man_ios_ssl_setup.png)

After installing the certificate, restart your app, then make the request a final time. Click the latest request in Proxyman, it will show
you the raw headers used for your Simulator, the response returned from the API, the rate limit from the API (5000 daily requests for Yelp) 
and the time it took to grab the response along with much more data.

![Proxyman stats page](img/proxy_man_stats.png)


# App Design

## LaunchView
This view asks for the user's permission, and explains why we need it. It will handle situations, where the user denies access to the location
as well. 

![Displays the first launch view](img/launchView1.png)

![Launch view 2](img/launchView2.png)

### DeniedView
If the user does not give the location, then we show this view. This tells the user the app cannot function. It allows him or her to 
change the previously chosen location permission.

![Display the denied view](img/deniedView.png)

### Launching the Settings from the app
The following code block shows how to open the settings for your particular app.
```
// Open settings
if let url = URL(string: UIApplication.openSettingsURLString) {

// Determines whether/ not it can open the URL
if UIApplication.shared.canOpenURL(url) {
    // Open the URL 
    UIApplication.shared.open(url)
}
```


## HomeView
This view displays a list of restaurants as well as sights in the area based on the closest distance to the user. 
It only displays after determining the user's permission to locate them, and loads the closest destinations based on the Yelp
API.

![HomeView screenshot](img/home_view.png)

## Business Detail View
Shows details on the business itself, closed/ open, hours, phone, etc.

![Displays the details for a business](img/business_detail_view.png)

### Launching Other Apps
You can use one of the URLSchemes shown in the following document in order to open the phone, Messages,
Maps, or other app: https://developer.apple.com/documentation/swiftui/link.  

### DirectionsView
In a Link, we can open an Apple map by passing in one of these URL schemes:
 https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html. 

For example, we use the one in this project for latitude/ longitude:
```
http://maps.apple.com/?ll=50.894967,4.341626
```

Meanwhile, if we want calculated directions we refer to the `MKDirections` class: 
https://developer.apple.com/documentation/mapkit/mkdirections.

The `BusinessDetailView` provides this directions button as well. You can see how it was made in the `DirectionsMap` View in 
`Views -> Home -> Map -> DirectionsMap`. It plots annotations on the map with an overlay (a line in Apple terms) on how to 
reach a particular destination with a given starting point.

![Map directions view](img/mapDirectionsView.png)

## Business Map View
The `BusinessMap` View marks on the map the 10 destinations found in the `HomeView` screen from the Yelp API. It uses Apple's 
`annotations` to display the business name above each point as well.

![Business map view](img/businessMap.png)

If you click the point, then you can click the `i` icon it will bring up the Business Details view shown above.
  
