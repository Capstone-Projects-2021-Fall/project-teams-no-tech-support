# project-teams-no-tech-support

## Overview

This application proposes a search tool intended to act as an alternative to traditional technical support. The tool will be developed as a web application. The application will allow users to fill in blanks in relevant prompts to formulate a search query and aggregate results for the user. Users will be able to rate results of their search. Search data will be stored to aid in future search suggestions. Brand data will also be stored, and users will be directed to relevant technical support if needed.

Users will access No Tech Support from a standard web browser on either a mobile phone, desktop, or laptop. They will first be prompted for their problem device and will then be given further prompts based on input to previous prompts. The user will be provided autocorrect and text suggestions when typing into each prompt area. Once enough detail has been given or a user is no longer able to provide other details, the user can click a button to perform a web search. The user will be provided with sorted search results with the most relevant or recommended at the top. An overlay will allow the user to rank their current link for helpfulness. A bar with the final query and brand-relevant tech support information will be displayed, if possible, for the information provided.

## Release Notes for v4.0 (Final Release) 

* Updated Domain database structure
* Added TrustedDomain and InteractiveDomain models and backend logic to match new database structure
  * No user impact at this time
* Reformatted the Question Optimization page for better visuals
* Added a failure / technical support information page
* Added video results
  * Can switch between text links and video results on the results page after searching
* Added ability to like / dislike domains
  * Liked domains are saved on each device
* Fixed bug relating to "Expanded" widget on some pages
  * App now renders in production mode
* PWA compliance updates
  * Added new icons with the NTS logo in multiple sizes (favicons)
  * Switched all requests to use HTTPS for security and PWA (Progressive Web App) compliance
  * Updated manifest
  * Configured service worker
* Upgraded installed experience (as PWA)
  * Can now install on mobile devices as well as desktop web browsers
  * Once installed, can now detect if a device is offline and inform the user and suggest fixes

Please see the [releases page](https://github.com/Capstone-Projects-2021-Fall/project-teams-no-tech-support/releases) for information on non-visual changes such as work on the backend and database

## Link to Web App

[notech.aidanbuehler.net](https://notech.aidanbuehler.net)

## Usage and Testing

**Usage Guide**

Users can begin by visiting the No Tech 
Support homepage at [notech.aidanbuehler.net](https://notech.aidanbuehler.net) from any web browser. The application is intended to be usable on a wide variety of devices but is best viewed on a laptop or desktop computer at this time. The application can be installed as a PWA (Progressive Web App) on mobile devices and PWA-supporting desktop web browsers such as Google Chrome. From the homepage, the user has access to a search bar in which they can input their initial query and begin their search.

If the user has not entered a device, brand, and model in their query, they will be brought to an intermediate search page and prompted for the missing information with suggestions in each prompt. Any present information will be pre-filled. These fields are optional and a user that does not possess further device information will not be prevented from continuing their search.

Clicking search will bring the user to the "Question Optimization" page. On this page the user is able to see a refined version of their original search query as well as a list of similar questions that might better reflect their situation. They are asked to either choose a suggestion or search using their current query. The user can go back to a previous revision of their query at any time by selecting the box surrounding their preferred query. 

Clicking search will bring the user to the results page. On this page the user can browse a sorted list of results based on their final query. A "Video" button is provided to switch to video results as well. Users can click on any of the videos or links to be brought to a new browser tab displaying the linked page. Users can also rate the search results on the list by clicking the thumbs-up or thumbs-down buttons to the right of each page-link or underneath each video-link.

The application can be used offline once it is installed with limited functionality. Only internet connectivity suggestions are provided at this time in offline mode.

**Testing Guide**

Please utilize the [Jira issue collector form](https://notechsupport.atlassian.net/rest/collectors/1.0/template/form/c2b63cc0) to report bugs and provide usage feedback to the development team. Thank you!

PLEASE NOTE: Clicking on the "My Device Info" link on the No Tech Support Homepage will lead to a dead-end in some browsers. This page is not currently functional on any version of the web application and should not be tested in this release.

Testing of the new features for this release are the top priority. These include PWA-installed functionality, the offline mode, video results, and result ratings. However, this is a full release of the app and all feedback is appreciated for any future improvements that can be made.

In order to effectively test this release, we have included the following relevant requirements from the No Tech Support testing procedures document:

1. No Tech Support will allow users to utilize prompts to refine their search query 
   * Task 1: Users can enter an initial query “My computer has an orange light” in the search box on the homepage 
     * Pass Condition: User can see the query in the search box exactly as written 
   * Task 2: User can see device details on the device information collection page 
     * Pass Condition: User can see “Computer” in the top text box after being redirected to the information collection page when search is clicked on the homepage 
   * Task 3: Users can select from a list of automatic suggestions for device details
     * Pass Condition: User types at least one character in the brand box and is provided a list of brand suggestions 
   * Task 4: Users can optimize their query 
     * Pass Condition: After clicking “Continue”, the user can click "View/select question..." to choose from a list of related queries which then appears under their initial query in the boxes above 
   * Task 5: Users can clear all prompts 
     * Pass Condition: User has filled selected at least one query suggestion and upon clicking “cancel”, all suggestions disappear from the boxes directly below the initial query 
   * Task 6: Users can perform a search 
     * Pass Condition: After clicking “Get results” the user is redirected to a results page where their “Final question” is displayed as selected on the previous page 
2. No Tech Support will allow users to browse from a list of search results  
   * Task 1: Users can view the web page at each link. 
     * Pass condition: User needed to complete the steps on functional requirements 1 in order to view the web page at each link 
   * Task 2: Users can return to the list of results. 
     * Pass condition: User completed the steps on functional requirements 1, and currently on a result page, user can return to the list of results by clicking on the “back” button. 
3. No Tech Support will give users the option to rate their search results 
   * The rating overlay will provide “helpful” and “unhelpful” options for each search result 
   * User completed the steps on functional requirements 1 & 2, and able click on the button “Helpful” or “Unhelpful” near each of the result links 
   * Users can see the current helpfulness rating of the site and page 
   * User completed the steps on functional requirements 1 & 2, and able to see a helpfulness rating near each result link 
4. No Tech Support will provide users with brand-specific tech-support contact information  
   * Task 1: Users browse the web page of each link 
     * Pass Condition: User needed to complete the steps on functional requirements 1 to view the web page at each link 
   * Task 2: Users select a brand from the brand list. 
     * Pass Condition: User select one brand from the return list of brands to pick a model.  
   * Task 3: Users can type a brand when they cannot find the brand in the list. 
     * Pass Condition: User need to type at least one character when they cannot find any match data. 
   * Task 4: Users can review the detailed information about the selected brand. 
     * Pass Condition: User need to select or type at least one character, then check the link with an official support page or a box requesting more information 
   * Task 5: Users can see the current helpfulness rating of the site and page 
     * Pass Condition: User completed all steps and able to see a helpfulness rating near the result link 
5. No Tech Support will provide suggestions for an internet connection issue when offline on the downloaded PWA-version of No Tech Support 
   * Task 1: User can download the PWA on a mobile phone   
     * Pass Condition: User can save the No Tech Support site to their phone (add to home screen) 
   * Task 2: Users can open the PWA when offline 
     * Pass Condition: User can open No Tech Support when offline and can view the homepage 
   * Task 4: Users are notified that they are offline and provided with basic tips 
     * Pass Condition: User can enter a problem in the homepage and is provided with a page informing the user of their offline status with basic internet-connectivity troubleshooting tips 

## Contributors

* Aidan Buehler
* Dajun Lin
* Jixi Hi
* Yangimiao Wu
* Henry Kombem

## Previous Release Notes

### Release Notes for v3.0 (Milestone 3)

* Updated home page layout
  * Added search bar
* Changed search flow
  * Device, brand, and model are now detected from an initial query
  * If device, brand, and model are present, the query is refined and the user is brought to the refining page
  * If the device, brand, or model is missing, the user is brought to a page and missing information is requested but not required before the user is allowed to continue to the query refining page
* Added language detection to the backend
  * Google's Cloud Natural Language API has been added but not fully implemented into logic
  * Added MySQL-based device, brand, and model recognition
    * Device and brand can be found if a model is present that exists in the No Tech Support database
* Improved related search suggestions
* Improved About Us page

### Release Notes for v2.0 (Milestone 2)

* Fixed links on home page
* Populated database with brands and models for use with autocompletion
  * Brands for both phones and computers are included
  * Brands all have tech support numbers included for later use
  * Multiple common models are included for each brand
* Improved main search page (iTechSupport titled page)
  * Added What/When/Why text boxes for collecting information
  * Enabled auto-complete functionality for device, brand, and model prompts
  * Enabled filtering autocompletion results from previous prompt input
    * Brands are filtered by device type
    * Models are sorted by brand and device type
* Updated backend API for stability and expanded API documentation
  * Greatly expanded unit tests
  * Improved error checks for bad input and feedback

* Added to the results page
  * Results are gotten from the backend based on the question string from the Query Filtering vue
  * Ued results to buil a generic seaarch results page
* Link API data to Query Filtering Page
* Synchronized all pages and the required data

### Release Notes for v1.0 (Milestone 1) 

* Project frontend created in Flutter framework
* Configured testing web server for frontend and backend / database
* Created homepage
  * Added logo
  * Added introductory blurb
  * Added search button
* Created navigation bar (present on the homepage and "About Us page")
  * Added application name
  * Added "Home" link
    * Links to homepage
  * Added "About Us" link
    * Links to "About Us" page
  * Added "Search" link
    * Links to "Search"
  * Added "Get Started" link
    * Temporarily links to homepage
* Created "About Us" page
  * Added placeholder text
* Created "Search" page
  * Added back button
  * Added placeholder text in navigation bar
  * Added "Search Something" (initial query) text field
  * Added "Select the Device" text field
  * Added "Select the Brand" text field
  * Added "Select the Model" text field
  * Added "Search!" button
 * Created "QueryOptimization" page
   * Added cancel button
   * Added get results button
   * Added Progressive question log view 
   * Added question suggestions dropdowns
   * Implemented dropdown on change events
   * Added event for Query Log to navigate to any prior question
   * Added styling 
   * Linked this page to search page
   * Link search page to all necessary buttons on homepage
* Miscellaneous
   * Added Frontend Classes  as per the class diagrams
   * Linked this page to search page
   * Link search page to all necessary buttons on homepage
