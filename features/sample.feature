# https://github.com/HackerNews/API
Feature: Hacker News REST API validation

  @scenario1
  Scenario: Verify top stories JSON schema
    When I send and accept JSON
   # And I send a GET request to "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"
   # And I send a GET request to "https://blogname.blogspot.com/feeds/posts/default?alt=json-in-script&callback=myFunc"
   # And I send a GET request to "http://jsonplaceholder.typicode.com/posts"
    And I send a GET request to "http://forecast.weather.gov/MapClick.php?lat=38.4247341&lon=-86.9624086&FcstType=json"
    Then the response status should be "200"
    And the JSON response should follow "features/schemas/feed.json"
  # When I grab "$["Mostly Cloudy", "Partly Sunny", "Mostly Clear" , "Sunny" , "Clear" , "Sunny" , "Mostly Clear" , "Sunny" , "Mostly Clear" , "Sunny" , "Mostly Clear" , "Sunny" , "Partly Cloudy" , "Slight Chance T-storms"]" as "weather"
  # Then I grab "$[KHNB]" as "currentobservation"
  #  And the JSON response should have "crh" key "location" of type "region"
    Then the JSON response root should be object
    Then the JSON response should have optional key "elevation" of type object or null
  #Then the JSON response should have (required|optional) key "location" of type object or null
    Then the JSON response should have value "Tonight"
    When I send a GET request to "http://forecast.weather.gov/MapClick.php?lat=38.4247341&lon=-86.9624086&FcstType=json" with:
       | time            | pretty |
       | Tonight        | true   |


  
  @scenario2
  Scenario Outline: Verify item JSON schema
    When I send and accept JSON
    And I send a GET request to "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"
    Then the response status should be "200"
    And the JSON response root should be array
    When I grab "$[0]" as "id"
    And I send a GET request to "https://hacker-news.firebaseio.com/v0/item/{id}.json" with:
      | print  |
      | pretty |
    Then the response status should be "200"
    And the JSON response root should be object
    And the JSON response should have <optionality> key "<key>" of type <value type>

    Examples:
      | key   | value type | optionality |
      | id    | numeric    | required    |
      | score | numeric    | required    |
      | url   | string     | optional    |
