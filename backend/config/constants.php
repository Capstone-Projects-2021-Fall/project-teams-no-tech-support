<?php

//  Define global constants here
return [
    //  Define Bing endpoint constants here
    'bing' => [
        'base' => 'https://api.bing.microsoft.com/',
        'search' => 'v7.0/search',
        'autosuggest' => 'v7.0/suggestions'
    ],
    'azureCognitive' => [
        'base' => 'https://ntsazurecognitive.cognitiveservices.azure.com/',
        'keyPhrases' => 'text/analytics/v3.1/keyPhrases',
        'namedEntityRecognition' => 'text/analytics/v3.1/entities/recognition/general'
    ],
    'googleLanguage' => [
        'base' => 'https://language.googleapis.com/v1/',
        'syntax' => 'documents:analyzeSyntax'
    ]
];