___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "BoostYourLeads Pixel",
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

___SANDBOXED_JS_FOR_GTM___

const injectScript = require('injectScript');
const copyFromWindow = require('copyFromWindow');
const setInWindow = require('setInWindow');
const logToConsole = require('logToConsole');

const trackingUrl = 'https://boostyourleads-backend-910265023456.us-central1.run.app/byl-tag.js';

// Inject the core tracking script on the user's webpage
injectScript(trackingUrl, () => {
  const byl = copyFromWindow('byl');
  if (byl) {
    byl('init', data.clientId);
    
    if (data.trackPageview) {
      byl('track', 'pageview');
    }
    
    if (data.trackForms) {
      byl('track', 'forms');
    }
  } else {
    logToConsole('BYL Tracker failed to initialize.');
  }
  data.gtmOnSuccess();
}, data.gtmOnFailure);

___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "value": "https://boostyourleads-backend-910265023456.us-central1.run.app/byl-tag.js"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "key": "byl",
                "read": true,
                "write": true,
                "execute": true
              }
            ]
          }
        }
      ]
    },
    "isRequired": true
  }
]
