___TERMS_OF_SERVICE___
By creating or modifying this file you agree to Google Tag Manager's Community Template Gallery Developer Terms of Service available at https://developers.google.com/tag-manager/gallery-tos (or such other URL as Google may provide), as modified from time to time.

___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "BoostYourLeads Pixel",
  "categories": [
    "ANALYTICS",
    "ATTRIBUTION",
    "LEAD_GENERATION"
  ],
  "brand": {
    "id": "brand_boostyourleads",
    "displayName": "BoostYourLeads"
  },
  "description": "The official BoostYourLeads Pixel for web attribution, B2B firmographics resolution, and automated lead scoring.",
  "containerContexts": [
    "WEB"
  ]
}

___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "clientId",
    "displayName": "BoostYourLeads Client ID (User UID)",
    "simpleValueType": "STRING",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "helpHint": "Your unique BYL account identifier, found in the Co-Pilot settings portal."
  },
  {
    "type": "CHECKBOX",
    "name": "trackPageview",
    "displayName": "Automatically Track Pageviews",
    "checkboxText": "Capture page visits, referrers, and UTM parameters",
    "simpleValueType": "BOOLEAN"
  },
  {
    "type": "CHECKBOX",
    "name": "trackForms",
    "displayName": "Automatically Capture Form Fills",
    "checkboxText": "Securely match and attribute form submissions for lead scoring",
    "simpleValueType": "BOOLEAN"
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const copyFromWindow = require('copyFromWindow');
const callInWindow = require('callInWindow');
const logToConsole = require('logToConsole');

const trackingUrl = 'https://back-end.boostyourleads.ca/byl-tag.js';

// Inject the core tracking script on the user's webpage
injectScript(trackingUrl, () => {
  const byl = copyFromWindow('byl');
  if (byl) {
    callInWindow('byl', 'init', data.clientId);
    
    if (data.trackPageview) {
      callInWindow('byl', 'track', 'pageview');
    }
    
    if (data.trackForms) {
      callInWindow('byl', 'track', 'forms');
    }
  } else {
    logToConsole('BYL Tracker failed to initialize.');
  }
  data.gtmOnSuccess();
}, data.gtmOnFailure);
