Feature: Weather API test

  Scenario Outline: Test Current Weather Endpoint with City
    Given the API key is "<apiKey>"
    When I request weather data with the following parameters:
      | type     | type_value   |
      | city     | <city_name>  |
  Then the status code should be <status>
  And the response should contain "<expected>"

  Examples:
   # ✅ Positive Test Cases
  | apiKey                                   | city_name     | status | expected              |
  | 956efdce7e574f15b3a0592d2d82d812         | London        | 200    | London                |
  | 956efdce7e574f15b3a0592d2d82d812         | New York      | 200    | New York              |
  | 956efdce7e574f15b3a0592d2d82d812         | Tokyo         | 200    | Tokyo                 |
  | 956efdce7e574f15b3a0592d2d82d812         | São Paulo     | 200    | São Paulo             |

  # ❌ Negative Test Cases (Invalid API key, malformed request)
  Examples:
  | apiKey                                   | city_name     | status | expected              |
  | invalid_api_key                          | London              | 403    | API key not valid, or not yet activated. If you recently signed up for an account or created this key, please allow up to 30 minutes for key to activate.    |
  #DEFECT - Invalid city request returns a response with weather for MidCity
  | 956efdce7e574f15b3a0592d2d82d812         | InvalidCity       | 404    | city not found.                   |
  | 956efdce7e574f15b3a0592d2d82d812         |                   | 400    | Invalid Parameters supplied.      |
  | 956efdce7e574f15b3a0592d2d82d812         | 12345             | 400    | No Location Found. Try lat/lon.   |
  # DEFECT - z@#%^&*!() is returning a city and status code 200
  | 956efdce7e574f15b3a0592d2d82d812         | z@#%^&*!()        | 404    | No Location Found. Try lat/lon.   |
  # DEFECT - Loooooooooooooong is returning a city and status code 200
  | 956efdce7e574f15b3a0592d2d82d812         | Loooooooooooooong  | 404   | No Location Found. Try lat/lon.  |

  # 🔍 Validation Test Cases (Special characters, spaces, and numeric cities)
  Examples:
  | apiKey                                   | city_name     | status | expected              |
  | 956efdce7e574f15b3a0592d2d82d812         | New York            | 200    | New York              |
  | 956efdce7e574f15b3a0592d2d82d812         | Los Angeles         | 200    | Los Angeles           |


  Scenario Outline: Scenario Outline: Test Current Weather Endpoint with Postcode
    Given the API key is "<apiKey>"
    When I request weather data with the following parameters:
      | type        | type_value  |
      | postal_code | <postcode>  |
    Then the status code should be <status>
    And the response should contain "<expected>"

    Examples:
     ✅ Positive Test Cases (Valid postcodes)
    | apiKey                                   | postcode     | status | expected              |
#   Maybe DEFECT - city is being returned as Weehawken instead of New York
    | 956efdce7e574f15b3a0592d2d82d812         | 10001        | 200    | New York              |
    | 956efdce7e574f15b3a0592d2d82d812         | SW1A 1AA     | 200    | London                |
    | 956efdce7e574f15b3a0592d2d82d812         | 90210        | 200    | Beverly Hills         |

    # ❌ Negative Test Cases (Invalid postcodes or bad requests)
    Examples:
    | apiKey                                   | postcode     | status | expected              |
    | invalid_api_key                          | 10001        | 403    | API key not valid, or not yet activated. If you recently signed up for an account or created this key, please allow up to 30 minutes for key to activate.    |
    #DEFECT - this postal code returns "city_name": "Rovaniemi",
    | 956efdce7e574f15b3a0592d2d82d812         | 999999999999 | 404    | No Location Found. Try lat/lon.  |
    | 956efdce7e574f15b3a0592d2d82d812         | ABCDE        | 400    | No Location Found. Try lat/lon.  |
    | 956efdce7e574f15b3a0592d2d82d812         | ""           | 400    | No Location Found. Try lat/lon.  |

    # 🛠️ Boundary Test Cases (Edge scenarios)
    Examples:
    | apiKey                                   | postcode     | status | expected              |
    | 956efdce7e574f15b3a0592d2d82d812       | 1            | 400    | No Location Found. Try lat/lon.    |
    | 956efdce7e574f15b3a0592d2d82d812       | 00000        | 400    | No Location Found. Try lat/lon.    |
    | 956efdce7e574f15b3a0592d2d82d812       | !@#$%        | 400    | No Location Found. Try lat/lon.    |
    #DEFECT - this postal code returns "city_name": "Sydney",
    | 956efdce7e574f15b3a0592d2d82d812       | 12 34 56     | 400    | No Location Found. Try lat/lon.    |


  Scenario Outline: Scenario Outline: Test Current Weather Endpoint with Postcode and country
    Given the API key is "<apiKey>"
    When I request weather data with the following parameters:
      | type        | type_value  |
      | postal_code | <postcode>  |
      | country     | <country>   |
    Then the status code should be <status>
    And the response should contain "<expected>"

    # ✅ Positive and ❌ Negative Test Cases Test Cases (Postcode and Country combination)
    Examples:
      | apiKey                                   | postcode     | country     | status | expected                          |
      | 956efdce7e574f15b3a0592d2d82d812         | 3000         |australia    | 200    | Melbourne                         |
      | 956efdce7e574f15b3a0592d2d82d812         | 3000         |paris        | 400    | No Location Found. Try lat/lon.   |
#     DEFECT - This is throwing 500 Internal Server Error
      | 956efdce7e574f15b3a0592d2d82d812         | 3000         |             | 400    | No Location Found. Try lat/lon.   |
      | 956efdce7e574f15b3a0592d2d82d812         |              |australia    | 400    | Invalid Parameters supplied.      |


  Scenario Outline: Test Weather API with Latitude and Longitude inputs
    Given the API key is "956efdce7e574f15b3a0592d2d82d812"
    When I request weather data with the following parameters:
      | type      | type_value  |
      | lat       | <latitude>  |
      | lon       | <longitude>   |
    Then the status code should be <status>
    And the response should contain "<expected>"

    # ✅ Positive Test Cases
    Examples:
      | latitude | longitude | status | expected   |
      | 51.5074  | -0.1278   | 200    | London     |
      | 40.7128  | -74.0060  | 200    | New York   |
      | -33.8688 | 151.2093  | 200    | Sydney     |
      | 35.6895  | 139.6917  | 200    | Tokyo      |

    # ❌ Negative Test Cases
    Examples:
      | latitude | longitude | status | expected                                            |
      | 500      | -74.0060  | 400    | Invalid lat supplied. Must be between -90 and +90   |
      | 40.7128  | 2000      | 400    | Invalid lon supplied. Must be between -180 and +180 |
      | abc      | -74.0060  | 400    | Invalid lat/lon supplied.                           |
      | 40.7128  | xyz       | 400    | Invalid lat/lon supplied.                           |
      |          | -74.0060  | 400    | Invalid Parameters supplied.                        |
      | 40.7128  |           | 400    | Invalid Parameters supplied.                        |

    # 🔥 Boundary Test Cases
    Examples:
      | latitude | longitude | status | expected              |
      # DEFECT - Getting weather for Longyearbyen instead of North Pole
      | 90.0000  | 0         | 200    | North Pole            |
      # DEFECT - Getting weather for Grytviken instead of South Pole
      | -90.0000 | 0         | 200    | South Pole            |
      # DEFECT - Getting weather for Takoradi instead of Null Island
      | 0        | 0         | 200    | Null Island           |
      | 91       | 0         | 400    | Invalid lat supplied. Must be between -90 and +90  |
      | 0        | 181       | 400    | Invalid lon supplied. Must be between -180 and +180|