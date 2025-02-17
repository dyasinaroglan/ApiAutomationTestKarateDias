Feature: All Booking Test Scenario

  Background:
    * url baseApiUrl
    * configure ssl = true
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario: Test Basic Auth API
    Given path '/auth'
    * header Authorization = autHeader
    And request { username: '#(username)', password: '#(password)' }
    When method POST
    Then status 200
    * print 'Token yanıtı : ', response
    * def token = response.token
    * def response = { token: token }

  Scenario:Booking Test
    Given path '/booking'
    When method GET
    Then status 200
    * def responseItem =
    """
    {
    "bookingid": "#number"
    }
    """
    * match each response == responseItem

  Scenario: Creates a new booking in the API
    Given path '/booking'
    And request {"firstname" : "Yasinad","lastname" : "adrog","totalprice" : 113,"depositpaid" : true,"bookingdates" : {"checkin" : "2025-01-01","checkout" : "2025-03-01"},"additionalneeds" : "Breakfast"}
    When method POST
    Then status 200
    * def expectedResponses = read('classpath:data/bookingExpectedResponse.json')
    And match response == expectedResponses

    * def createdId = response.bookingid
    * print 'Created booking ID:', createdId

    Given path 'booking', createdId
    * def Username = username
    * def Password = password
    * def credentials = Username + ':' + Password
    * def Base64 = Java.type('java.util.Base64')
    * def encodedCredentials = Base64.getEncoder().encodeToString(credentials.getBytes('UTF-8'))
    * def basicAuthHeader = 'Basic ' + encodedCredentials
    * header Authorization = basicAuthHeader
    * print 'id', createdId
    And request {"firstname" : "Yasin","lastname" : "adrog degistirme","totalprice" : 113,"depositpaid" : true,"bookingdates" : {"checkin" : "2025-01-01","checkout" : "2026-03-01"},"additionalneeds" : "Breakfast"}
    When method PUT
    Then status 200
    * print response

