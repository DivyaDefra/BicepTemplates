
var existingApiManagementName = 'DEVAPIINFAM1401'
var apiName = 'address-lookup-v12'
resource apimanagementApi 'Microsoft.ApiManagement/service/apis@2020-06-01-preview' = {
  name: '${existingApiManagementName}/${apiName}'
  properties: {
    description: 'The DEFRA Address Lookup REST API provides a method to search for a list of addresses  by Postal Code or UPRN (Unique Property Reference Number)'
    type: 'http'   
    subscriptionRequired: true
    isCurrent: true
    displayName: 'Address Lookup'
    serviceUrl: 'https://devapiinfam1401.azure-api.net/api/address-lookup/v2.0'
    path: 'api/address-lookup'
    protocols: [
      'https'
    ]
  }
}
