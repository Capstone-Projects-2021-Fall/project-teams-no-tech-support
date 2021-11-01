# project-teams-no-tech-support

## Overview

This application proposes a search tool intended to act as an alternative to traditional technical support. The tool will be developed as a web application. The application will allow users to fill in blanks in relevant prompts to formulate a search query and aggregate results for the user. Users will be able to rate results of their search. Search data will be stored to aid in future search suggestions. Brand data will also be stored, and users will be directed to relevant technical support if needed.

Users will access No Tech Support from a standard web browser on either a mobile phone, desktop, or laptop. They will first be prompted for their problem device and will then be given further prompts based on input to previous prompts. The user will be provided autocorrect and text suggestions when typing into each prompt area. Once enough detail has been given or a user is no longer able to provide other details, the user can click a button to perform a web search. The user will be provided with sorted search results with the most relevant or recommended at the top. An overlay will allow the user to rank their current link for helpfulness. A bar with the final query and brand-relevant tech support information will be displayed, if possible, for the information provided.

## Release Notes for v2.0 (Milestone 2) 

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

Please see the [releases page](https://github.com/Capstone-Projects-2021-Fall/project-teams-no-tech-support/releases) for information on non-visual changes such as work on the backend and database

## Link to Web App

[notech.aidanbuehler.net](http://notech.aidanbuehler.net)

## Usage and Testing

**Usage Guide**

Please note that web application does not return any live search results at the time of this release.

Users can begin by visiting the No Tech 
Support homepage at [notech.aidanbuehler.net](http://notech.aidanbuehler.net) from any web browser. The application is intended to be usable on a wide variety of devices but is best viewed on a laptop or desktop computer at this time. From there, the "Search" links in the navigation bar or center of the home page will bring the user to the search page. 

The search page is the page where the majority of data is collected from the user regarding their problem. Text boxes are intended to be filled out top to bottom starting with the box containing the text "Select the device." The device, brand, and model prompts have autocomplete enabled and pull results from our API as the user types. Suggestions are filtered based on the contents of the previous textbox.

After device information is recorded, the user is asked to fill in what they think the problem is, when it occurs, and what they believe caused it. At this time data is recorded in these boxes but they are placeholders.

Clicking search will bring the user to the "Question Optimization" page. On this page the user is able to see the initial search query that they have formed as well as a list of similar questions that might better reflect their situation. They are asked to either choose a suggestion or search using their current query. The user can go back to a previous revision of their query at any time by selecting the box surrounding their preferred query. The cancel button would revert to the original query and search would bring the user to the results page, but neither button is enabled at the time of this release.

**Testing Guide**

Please utilize the [Jira issue collector form](https://notechsupport.atlassian.net/rest/collectors/1.0/template/form/c2b63cc0) to report bugs and provide usage feedback to the development team. Thank you!

Although No Tech Support will work on any browser, testing should focus on desktop computers or other devices with large screens at this time due to rendering issues. Testing of the autocomplete functionality on the main search page is a top priority for this milestone. We have included relevant functional requirements from our testing document below.

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

## Contributors

* Aidan Buehler
* Dajun Lin
* Jixi Hi
* Yangimiao Wu
* Henry Kombem

## Previous Release Notes

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