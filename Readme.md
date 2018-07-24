#My ios App : University Housing

This application acts as a platform for students looking for housing which includes rent, sublet
and roommate requests. Currently there is no such existing housing application which acts as a
common platform for students from a particular university.

# Implemented Features

## Database
The extra feature which we implemented in our project was using “Firebase” as the
database for the application. “Firebase” is a mobile and web application development platform.
“Firebase” provides a lot of features significant for application development. The
following features from “Firebase” were used in our application:
– Authentication
The login/register feature for the application mentioned in section 2 uses the Authentication
feature provided by the “Firebase”.
– Database
The data required for the application is saved in “Firebase” database. All the data about
the apartment listings are saved in the database. The data is stored in JSON format.
– Storage
The images for the apartments are stored in "Storage" feature of Firebase. Firebase
provides a download URL for the

## Login/Register
The users can login/register using the Login page. For registering, the user needs to provide
the email id and password. The login system for the project was implemented using the
“Email and password” based authentication provided by Firebase. The login page prompts
the user to enter the user name and password for login. A new user needs to register in
the application using email id and password. Once logged in, the user will be redirected to
the initial page discussed in the next section 2. The username and password are stored in
the userdefaults so that the user does not need to enter the login credentials again. The
screenshot of the login page can be seen in 1.
## Initial Page
The initial page has two text fields which displays the country and the college name. The
country and college name will be auto-populated. The country is obtained from the current
location. The college text will be auto populated by the nearest college. The college details
are saved in the database 2. The users current location is identified by the CoreLocation
feature available in Swift. The university details is saved in the database. The university
location is identified from the university address stored using geocoder feature available in
CoreLocation. By calculating the distance between the university and current location, the
nearest university is identified. There is a search button available in the page. On clicking
on the search button, the application is redirected the Listing page 2. The Initial page has
the option to logout from the system. Once the user clicks the Logout button, the user will
be logged out and redirected to the Login/Register page. The screenshot of initial page can
be seen in 2.
## Listing Page
The listing page lists all the listings/apartments available near the user. Apartments within
25 mile range will only be displayed. The apartment name, address, rent, distance from the
current location and an image of the apartment can be seen in the Listing page. The user
will have the provision to sort the listing based on two parameters which are price and listing.
The list can be sorted in ascending and descending order based on price and distance. The
distance is computed from by calculating the distance between the current location and the
location obtained from the address provided in the listing. Clicking on any row will redirect
the user to a listing detail page which shows all the details related to the selected apartment
2. The screenshot of listing page can be seen in 3.
## Listing Detail page
The specific details about the listing/apartment is listed in this page. All the details including
price, description, contact details etc will be shown in this page. The user can contact the
user via various means. The user can also navigate to the apartment location from the current
location using the from this page. The apartment listing can be saved to favorites from this
page. The features available in this page are discussed in detail below:
– Contact
The user can email the owner by clicking on the “Email” button available next to the
email id. The button click will pop up the mailing page. The phone number of the user
is also listed in the listing detail page. The user can call/message the user by clicking
on the CALL/MESSAGE button available next to the contact number. The application
throws an alert if the user is not capable of doing any of these(call/message/email).
– Maps and Navigation
A map showing the location of the apartment is available in the listing detail page. A
pin is placed on top of the apartment listed. On clicking on the pin, the user will be
prompted to navigate to the apartment location. On clicking, the navigation page will
be opened driving directions from current location to apartment location will be shown.
– Favorites
If the user wants to save an apartment listing for future, he/she can add it to his
favorites. There is an add to Favorites button available in the page. An alert message
saying "Added to Favorites" will be popped while clicking on the button so that the
user gets the notification that listing is added to his favorites.
The images in the listing detail page are shown using a “ImageSlideShow”. This allows to
show multiple images of the listing as a slide show. The user can swipe left or right to see the
next images [4]. The images are fetched from the url using Alamofire [2]. The screenshots of
listing detail page can be seen in 4 and 5.
## Favorites Page
The Favorites tab will show all the listings which are marked as favorite by the user. On
clicking a row/apartment listing from this page, the application redirects to the Listing
detail page discussed in section 2. The user also has the option to delete the listings from his
favorites. On clickin on the edit button available at top right corner of the favorites page,
the user can delete the listings from his/her favorites. The screenshot of listing page can be
seen in 7.
## Posting Page
The user will be able to post details about the apartment to be rented. The username will
be auto populated. The user can enter the rent details, address, availability date, contact
details and many more details. The user can also upload pictures of the apartment being
posted. Once posted, the user can navigate to My Listings page to view his/her listings
2. There are different UI controls which we have used for user’s ease of use like switch,
slider , UIPickerView and DatePickerView.We have also included validaton so that the user
can’t post a posting with empty values.Also Once a user posted his posting and in future
he wants to edit that posting he can always go to the mylistings page and edit any of his
postings and after submitting the firbase database will be update accordingly. The user will
not be able to post a listing if he enter invalid address. The application checks the address
within CoreLocation.
## My Listings page.
The user can see the postings made by him in the My Listings page. The user can edit his/her
post from this page. Clicking on a row/listing will redirect to the “Edit post” page. The user
can make any changes for his post in this page. The user can also reaarange his/her mylisting
sequence in the table.He can also delete a listing and it will also permanently delete that
listing from the firebase database and reload the listings and mylistings page consequently.
## Edit post page
The Edit post page will be same as the Post page. If we are redirecting from the mylistings
page, all the controls will be auto populated. The existing post can be reordered/deleted on
clicking the edit button.We can also go inside each of the mylisting values and even edit it
to update the database simultaneously.
