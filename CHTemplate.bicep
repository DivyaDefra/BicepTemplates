
var existingApiManagementName = 'DEVAPIINFAM1401'
var cHapiNamev2 = 'companies-house-v2'
var cHapiNamev21 = 'companies-house-v21'
var serviceurlv2 = 'https://integration-snd.azure.defra.cloud/ws/rest/DEFRA/v2/CompaniesHouse/'
var serviceurlv21 = 'https://integration-snd.azure.defra.cloud/ws/rest/DEFRA/v2.1/CompaniesHouse/'
var boomicertificateName = 'BOOMI-SND-CERTIFICATE'

resource cHAPIv2 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  name: '${existingApiManagementName}/${cHapiNamev2}'
  properties: {
    description: 'DEFRA Companies House Lookup REST API provides a method to retrieve details about a company and its officers by using the company registration id.'
    type: 'https'   
    apiVersion: 'v2'
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
    displayName: 'Companies House'
    serviceUrl: serviceurlv2
    path: 'api/companies-house'
    protocols: [
      'https'
    ]
  }
}

var appointmentOperationNamev2 = '${cHAPIv2.name}/officers/{officerId}/appointments'

resource apimanagementapioperationappointmentv2 'Microsoft.ApiManagement/service/apis/operations@2020-06-01-preview' = {
  name: appointmentOperationNamev2
  properties: {
    description: 'Returns a list of companies where an officer holds or has held a position.'
    displayName: 'Get a list of all the appointments of an officer using an officer id'
    method: 'GET'
    urlTemplate: '/officers/{officerId}/appointments'
    request: {
      description: 'Search the Address service for Postal codes or URPN'
      queryParameters: [
        {
          description: 'Officer Id'
          name: 'officerId'
          type: 'string'
          required:true
        }
      
      ]
    }
    responses: [
      {
        statusCode: 202
        description: 'Success'
        representations:[
          
        ]
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
resource cHApiPoliciesv2 'Microsoft.ApiManagement/service/apis/policies@2020-12-01' = {
  name: 'policy'
  parent: cHAPIv2
  properties: {
    value: '<<policies>\r\n  <inbound>\r\n    <base />\r\n  <authentication-certificate certificate-id="${boomicertificateName}" /> </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
    format: 'xml'
  }
}

resource cHAPIv21 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
  name: '${existingApiManagementName}/${cHapiNamev21}'
  properties: {
    description: 'DEFRA Companies House Lookup REST API provides a method to retrieve details about a company and its officers by using the company registration id.'
    type: 'https'   
    apiVersion: 'v2.1'
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
    displayName: 'Companies House'
    serviceUrl: serviceurlv21
    path: 'api/companies-house'
    protocols: [
      'https'
    ]
  }
}

var appointmentOperationNamev21 = '${cHAPIv21.name}/officers/{officerId}/appointments'

resource apimanagementapioperationappointment 'Microsoft.ApiManagement/service/apis/operations@2020-06-01-preview' = {
  name: appointmentOperationNamev21
  properties: {
    description: 'Returns a list of companies where an officer holds or has held a position.'
    displayName: 'Get a list of all the appointments of an officer using an officer id'
    method: 'GET'
    urlTemplate: '/officers/{officerId}/appointments'
    request: {
      description: 'Search the Address service for Postal codes or URPN'
      queryParameters: [
        {
          description: 'Officer Id'
          name: 'officerId'
          type: 'string'
          required:true
        }
      
      ]
    }
    responses: [
      {
        statusCode: 202
        description: 'Success'
        representations:[
          
        ]
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
resource cHApiPoliciesv21 'Microsoft.ApiManagement/service/apis/policies@2020-12-01' = {
  name: 'policy'
  parent: cHAPIv21
  properties: {
    value: '<<policies>\r\n  <inbound>\r\n    <base />\r\n  <authentication-certificate certificate-id="${boomicertificateName}" /> </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
    format: 'xml'
  }
}


