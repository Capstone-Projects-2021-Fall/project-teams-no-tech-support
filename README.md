# project-teams-no-tech-support

## Overview

This application proposes a search tool intended to act as an alternative to traditional technical support. The tool will be developed as a web application. The application will allow users to fill in blanks in relevant prompts to formulate a search query and aggregate results for the user. Users will be able to rate results of their search. Search data will be stored to aid in future search suggestions. Brand data will also be stored, and users will be directed to relevant technical support if needed.

Users will access No Tech Support from a standard web browser on either a mobile phone, desktop, or laptop. They will first be prompted for their problem device and will then be given further prompts based on input to previous prompts. The user will be provided autocorrect and text suggestions when typing into each prompt area. Once enough detail has been given or a user is no longer able to provide other details, the user can click a button to perform a web search. The user will be provided with sorted search results with the most relevant or recommended at the top. An overlay will allow the user to rank their current link for helpfulness. A bar with the final query and brand-relevant tech support information will be displayed, if possible, for the information provided.

## Release Notes for v3.0 (Milestone 3) 

* Updated home page layout
  * Added search bar
* Changed search flow
  * Device, brand, and model are now detected from an initial query
  * If device, brand, and model are present, the query is refined and the user is brought to the refining page
  * If the device, brand, or model is missing, the user is brought to a page and missing infomation is requested but not required before the user is allowed to continue to the query refining page
* Added language detection to the backend
  * Google's Cloud Natural Language API has been added but not fully implemented into logic
  * Added MySQL-based device, brand, and model recognition
    * Device and brand can be found if a model is present that exists in the No Tech Support database
* Improved related search suggestions
* Improved About Us page

Please see the [releases page](https://github.com/Capstone-Projects-2021-Fall/project-teams-no-tech-support/releases) for information on non-visual changes such as work on the backend and database

## Link to Web App

[notech.aidanbuehler.net](https://notech.aidanbuehler.net)

## Usage and Testing

**Usage Guide**

Users can begin by visiting the No Tech 
Support homepage at [notech.aidanbuehler.net](https://notech.aidanbuehler.net) from any web browser. The application is intended to be usable on a wide variety of devices but is best viewed on a laptop or desktop computer at this time. From the homepage, the user has access to a search bar in which they can input their initial query and begin their search.

If the user has not entered a device, brand, and model in their query, they will be brought to an intermediate search page and prompted for the missing information with suggestions in each prompt. Any present information will be pre-filled. These fields are optional and a user that does not posess further device information will not be prevented from continuing their search.

Clicking search will bring the user to the "Question Optimization" page. On this page the user is able to see the a refined version of their original search query as well as a list of similar questions that might better reflect their situation. They are asked to either choose a suggestion or search using their current query. The user can go back to a previous revision of their query at any time by selecting the box surrounding their preferred query. 

Clicking search will bring the user to the results page. On this page the user can browse a sorted list of results based on their final query. A "Video" button is provided to switch to video results, but only web page results are available at the time of this release.

**Testing Guide**

Please utilize the [Jira issue collector form](https://notechsupport.atlassian.net/rest/collectors/1.0/template/form/c2b63cc0) to report bugs and provide usage feedback to the development team. Thank you!

PLEASE NOTE: Clicking on the "My Device Info" link on the No Tech Support Homepage will lead to a dead-end in some browsers. This page is not currently functional on any version of the web application and should not be tested in this release.

Testing of the device/brand/model detection from the initial query as well as the related searches are the main priorities for this release. The site can be tested on any device from a web browser. The web application is also downloadable as a progressive web app, but this functionality is still being developed and does not support all features. However, all reported bugs are appreciated!

In order to effectively test this release, we have included the following relevant requirements from the No Tech Support testing procedures document:

1. No Tech Support will have a simple and easy to use interface 
   1. Task: No Tech Support should be easy to use and should not need any tutorial  
   2. Question: Are the Pages fully rendered with no misplaced? 
   3. Question: Are there any unnecessary buttons? 
   4. Question: Are the pages has clear, visible text and proper font size
   5. Question: Are the buttons easy to find? 
      1. “NoTechSupport” link on top left-hand corner will bring user back to homepage 
      2. Home, about us, search, get started link are located on the top right-hand corner 
   6. Are there any misspelled words from user input that are not underlined or automatically corrected? 
   7. Are there any friendly warning messages after the errors occurred in processing data such as “no result”? 
2. No Tech Support will allow users to answer prompts to form a search query 
   1. Task: Answer simple prompts one at a time 
      1. Pass Condition: User typed at least one character on the search query 
   2. Task: Users can select from a list of automatic suggestions. 
      1. Pass Condition: User typed at least one character on the search query in order to activate a selectable drop-down suggestion. 
   3. Task: Users can perform a search 
      1. Pass Condition: User typed at least one character on all the search query in order to activate the “search” button. 
   4. Task: Users can clear all prompts
      1. Pass Condition: User typed at least one character on the search query in order to activate the “clear” button to clear all the input on the search query. 
3. No Tech Support will allow users to optimize queries gotten form the data collection(currently named search page) page, based on question suggestions from the API
   1. Task: User find it easy navigating through the current page
      1. Pass Condition: User doesn't have a hard time understanding what is going on within the page 
   2. Task: Users can select suggestion and add to the query log
      1. Pass Condition: user selects a dropdown if any item and the query log is updated
   3. Task: Users can  remove suggestions from the query log
      1. Pass Condition: user clicks on a prior question version  and the preceding ones disappear
   4. Task: Users can roll back to older question versions and get other suggestions if available
      1. Pass Condition: User clicked on a prior question version and got suggestions for the selected question version
   5. Task: Users get some kind of alert when they a selected question suggestion had no child suggestions
      1. Pass Condition: User sees a message then the current query has no suggestions.
4. No Tech Support will have advanced search and an auto-suggestion filtering feature   
   1. Task: No Tech Support should provide the advanced search 
      1. Pass Condition: Users can utilize optional prompts to provide further details about their situation
   2. Task: No Tech Support should provide an auto-filter feature 
      1. Pass Condition: Suggestions are relevant to the user's responses to previous prompt(s)
   3. Task: No Tech Support should sort search results
      1. Pass Condition: The most likely solutions appear first on the results screen based on a rating system
5. No Tech Support will allow users to browse from a list of search results  
   1. Task: Users can view the web page at each link. 
      1. Pass condition: User needed to complete the steps on functional requirements 1 in order to view the web page at each link 
   2. Task: Users can return to the list of results. 
      1. Pass condition: User completed the steps on functional requirements 1, and currently on a result page, user can return to the list of results by clicking on the “back” button. 

## Contributors

* Aidan Buehler
* Dajun Lin
* Jixi Hi
* Yangimiao Wu
* Henry Kombem

## Previous Release Notes

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
