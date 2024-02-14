
var existingApiManagementName = 'DEVAPIINFAM1401'
var aLapiName = 'address-lookup-v12'
resource addressLookupAPI 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  name: '${existingApiManagementName}/${aLapiName}'
  properties: {
    description: 'The DEFRA Address Lookup REST API provides a method to search for a list of addresses  by Postal Code or UPRN (Unique Property Reference Number)'
    type: 'https'   
    apiVersion: 'v2.0'
    subscriptionRequired: true
    subscriptionKeyParameterNames: {
      header: 'Ocp-Apim-Subscription-Key'
      query: 'subscription-key'
    }
    isCurrent: true
    license: {
      name: 'DEFRA API License Agreement'
      url: 'https://www.gov.uk/government/organisations/department-for-environment-food-rural-affairs/license/url'
    }
    contact: {
      email: 'defra.helpline@defra.gsi.gov.uk'
      name: 'Department for Environment, Food and Rural Affairs - GOV UK'
      url: 'https://www.gov.uk/government/organisations/department-for-environment-food-rural-affairs'
    }
    displayName: 'Address Lookup'
    serviceUrl: 'https://devapiinfam1401.azure-api.net/api/address-lookup/v2.0'
    path: 'api/address-lookup'
    protocols: [
      'https'
    ]
  }
}

var addressesOperationName = '${addressLookupAPI.name}/addresses'

resource apimanagementapioperationposttransaction 'Microsoft.ApiManagement/service/apis/operations@2020-06-01-preview' = {
  name: addressesOperationName
  properties: {
    description: 'Search the Address service for Postal codes or URPN'
    displayName: 'Address search by Postcode or UPRN'
    method: 'GET'
    urlTemplate: '/addresses'
    request: {
      description: 'Search the Address service for Postal codes or URPN'
      queryParameters: [
        {
          description: 'The PostCode to be used in lookup'
          name: 'postcode'
          type: 'string'
        }
        {
          description: 'The UPRN to be used in lookup'
          name: 'uprn'
          type: 'string'
        }
        {
          description: 'The maxresults parameter defines how many results will be returned (limit is 100). When searching by UPRN this parameter will be ignored. Default setting is 100.'
          name: 'maxresults'
          type: 'integer'
        }
        {
          description: 'If results set is greater than the maxresults this parameter can be used to offset the results so that the result sets can be concatenated.'
          name: 'offset'
          type: 'string'
        }
        {
          description: 'Language paramter is used to indecate which language is required. Valid languages are English (EN) and Welsh (CY). This filter is only applicable to DPA dataset'
          name: 'language'
          type: 'string'
        }
        {
          description: 'Specifies which dataset is required, Delivery Point Addresses (DPA) or Local Property Identifier (LPI).'
          name: 'dataset'
          type: 'string'
        }
      ]
    }
    responses: [
      {
        statusCode: 202
        description: 'Success'
      }
      {
        statusCode: 400
        description: 'Bad Request - There are miscellaneous errors with the request, for example, mismatches between the request and what is allowed for the operation.'
      }
      {
        statusCode: 403
        description: 'Unauthorized or 403 Forbidden - Authentication errors.'
      }
      {
        statusCode: 404
        description: 'Not Found - Invalid URL path.'
      }
      {
        statusCode: 500
        description: 'Internal Server Error - This generic error message appears when an unexpected condition was encountered and a more specific message is not suitable.'
      }
      {
        statusCode: 503
        description: 'Service Unavailable - The caller has hit a throttle or the request was rejected because the service is starting or stopping.'
      }
    ]
  }
}

resource aLApiPolicies 'Microsoft.ApiManagement/service/apis/policies@2020-12-01' = {
  name: 'policy'
  parent: addressLookupAPI
  properties: {
    value: '<!--\r\n    IMPORTANT:\r\n    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.\r\n    - To remove a policy, delete the corresponding policy statement from the policy document.\r\n    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.\r\n    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.\r\n    - Policies are applied in the order of their appearance, from the top down.\r\n    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.\r\n-->\r\n<policies>\r\n  <inbound>\r\n    <base />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
    format: 'xml'
  }
}
