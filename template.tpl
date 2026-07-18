___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Consorm Consent Optimization",
  "categories": ["TAG_MANAGEMENT", "PERSONALIZATION"],
  "brand": {
    "id": "github.com_consorm-cmp",
    "displayName": "Consorm"
  },
  "description": "Official Consorm CMP integration. Loads the Consorm consent banner and sets the Google Consent Mode v2 default state (denied by default, configurable per category) before any other tag fires. Learn more at https://consorm.ca. — Intégration officielle de la CMP Consorm. Charge la bannière de consentement Consorm et définit l'état par défaut du mode de consentement Google v2 (refusé par défaut, configurable par catégorie) avant le déclenchement de toute autre balise. En savoir plus sur https://consorm.ca. Developed by Oriana Solutions (https://orianasolutions.ca).",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "siteId",
    "displayName": "Consorm Site ID / Identifiant de site Consorm",
    "simpleValueType": true,
    "help": "Your unique Site ID, provided in your Consorm dashboard (https://consorm.ca). — Votre identifiant de site unique, fourni dans votre tableau de bord Consorm (https://consorm.ca).",
    "valueHint": "e.g. abc123",
    "notSetText": "Please enter the Site ID provided in your Consorm dashboard. — Veuillez saisir l'identifiant de site fourni dans votre tableau de bord Consorm.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "defaultConsent",
    "displayName": "Default Consent State / État de consentement par défaut",
    "groupStyle": "ZIPPY_CLOSED",
    "help": "Consent state applied before the visitor makes a choice in the banner. — État de consentement appliqué avant que le visiteur ne fasse un choix dans la bannière.",
    "subParams": [
      {
        "type": "SELECT",
        "name": "marketingDefaultState",
        "displayName": "Marketing (ad_storage, ad_user_data, ad_personalization)",
        "macrosInSelect": false,
        "selectItems": [
          { "value": "denied", "displayValue": "Denied / Refusé" },
          { "value": "granted", "displayValue": "Granted / Accordé" }
        ],
        "simpleValueType": true,
        "defaultValue": "denied"
      },
      {
        "type": "SELECT",
        "name": "analyticsDefaultState",
        "displayName": "Analytics (analytics_storage)",
        "macrosInSelect": false,
        "selectItems": [
          { "value": "denied", "displayValue": "Denied / Refusé" },
          { "value": "granted", "displayValue": "Granted / Accordé" }
        ],
        "simpleValueType": true,
        "defaultValue": "denied"
      },
      {
        "type": "SELECT",
        "name": "preferencesDefaultState",
        "displayName": "Preferences (functionality_storage, personalization_storage)",
        "macrosInSelect": false,
        "selectItems": [
          { "value": "denied", "displayValue": "Denied / Refusé" },
          { "value": "granted", "displayValue": "Granted / Accordé" }
        ],
        "simpleValueType": true,
        "defaultValue": "denied"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const gtagSet = require('gtagSet');
const setDefaultConsentState = require('setDefaultConsentState');
const injectScript = require('injectScript');
const queryPermission = require('queryPermission');
const encodeUriComponent = require('encodeUriComponent');

gtagSet('developer_id.dMWUyMT', true);

const siteId = data.siteId;

const scriptUrl = 'https://cdn-consorm.com/t/' + encodeUriComponent(siteId) + '/bootstrap.js';

setDefaultConsentState({
  'ad_storage': data.marketingDefaultState,
  'ad_user_data': data.marketingDefaultState,
  'ad_personalization': data.marketingDefaultState,
  'analytics_storage': data.analyticsDefaultState,
  'functionality_storage': data.preferencesDefaultState,
  'personalization_storage': data.preferencesDefaultState,
  'security_storage': 'granted',
  'wait_for_update': 500
});

if (queryPermission('inject_script', scriptUrl)) {
  injectScript(scriptUrl, data.gtmOnSuccess, data.gtmOnFailure);
} else {
  data.gtmOnFailure();
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "write_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "developer_id.dMWUyMT"
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
                "string": "https://cdn-consorm.com/*"
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
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
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
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 7/17/2026, 10:17:18 PM


