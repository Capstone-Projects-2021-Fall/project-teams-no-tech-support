# project-teams-no-tech-support

## Overview

This application proposes a search tool intended to act as an alternative to traditional technical support. The tool will be developed as a web application. The application will allow users to fill in blanks in relevant prompts to formulate a search query and aggregate results for the user. Users will be able to rate results of their search. Search data will be stored to aid in future search suggestions. Brand data will also be stored, and users will be directed to relevant technical support if needed.

Users will access No Tech Support from a standard web browser on either a mobile phone, desktop, or laptop. They will first be prompted for their problem device and will then be given further prompts based on input to previous prompts. The user will be provided autocorrect and text suggestions when typing into each prompt area. Once enough detail has been given or a user is no longer able to provide other details, the user can click a button to perform a web search. The user will be provided with sorted search results with the most relevant or recommended at the top. An overlay will allow the user to rank their current link for helpfulness. A bar with the final query and brand-relevant tech support information will be displayed, if possible, for the information provided.

## Release Notes for v1.0 (Milestone 1) 

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

Please see the the [releases page](https://github.com/Capstone-Projects-2021-Fall/project-teams-no-tech-support/releases) for information on non-implemented changes such as work on the backend and database

## Link to Web App

[notech.aidanbuehler.net](http://notech.aidanbuehler.net)

## Usage and Testing

**Usage Guide**

Please note that application does not return any live search results at the time of this release.

Users can begin by visiting the No Tech 
Support homepage at [notech.aidanbuehler.net](http://notech.aidanbuehler.net) from any web browser. The application is intended to be usable on a wide variety of devices. From there, the "About Us" and "Search" links in the navigation bar are functional. The linked pages include at least placeholder content and are available for testing.

**Testing Guide**

Being that the frontend of No Tech Support is the main subject of this first release, testing should focus on the navigability and accessability of the web app. We have included relevant functional requirements from our testing document below.

1. No Tech Support will have a simple and easy to use interface 
   1. Task: No Tech Support should be easy to use and should not need any tutorial  
   1. Question: Are the Pages fully rendered with no misplaced? 
   2. Question: Are there any unnecessary buttons? 
   3. Question: Are the pages has clear, visible text and proper font size
   4. Question: Are the buttons easy to find? 
      1. “NoTechSupport” link on top left-hand corner will bring user back to homepage 
      2. Home, about us, search, get started link are located on the top right-hand corner 
   5. Are there any misspelled words from user input that are not underlined or automatically corrected? 
   6. Are there any friendly warning messages after the errors occurred in processing data such as “no result”? 
2. No Tech Support will allow users to answer prompts to form a search query 
   1. Task: Answer simple prompts one at a time 
      1. Pass Condition: User typed at least one character on the search query 
   2. Task: Users can select from a list of automatic suggestions. 
      1. Pass Condition: User typed at least one character on the search query in order to activate a selectable drop-down suggestion. 
   3. Task: Users can perform a search 
      1. Pass Condition: User typed at least one character on all the search query in order to activate the “search” button. 
   4. Task: Users can clear all prompts
      1. Pass Condition: User typed at least one character on the search query in order to activate the “clear” button to clear all the input on the search query. 

## Contributors

* Aidan Buehler
* Dajun Lin
* Jixi Hi
* Yangimiao Wu
* Henry Kombem
