package steps;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

public class WeatherApiSteps {

    private String apiKey;
    private Response response;

    @Given("the API key is {string}")
    public void the_api_key_is(String key) {
        this.apiKey = key;
    }

    @When("I request weather data for field {string} and value {string}")
    public void i_request_weather_data_for_city_with(String type, String value) {
        response = RestAssured.given()
                .queryParam(type, value)
                .queryParam("key", apiKey)
                .get("http://api.weatherbit.io/v2.0/current");
    }

    @Then("the status code should be {int}")
    public void the_status_code_should_be(int statusCode) {
        assertEquals(statusCode, response.getStatusCode(), "Status code mismatch! with response body " + response.getBody().prettyPrint());
    }

    @Then("the response should contain {string}")
    public void the_response_should_contain(String expectedContent) {
        String responseBody = response.getBody().asString();
        assertTrue(responseBody.contains(expectedContent), "Expected response to have " + expectedContent + " but got " + response.getBody().prettyPrint());
    }

    @When("I request weather data with the following parameters:")
    public void i_request_weather_data_with_parameters(DataTable dataTable) {
        List<Map<String, String>> rows = dataTable.asMaps(String.class, String.class);

        RequestSpecification request = RestAssured.given().queryParam("key", apiKey);

        // Loop through each row and add query parameters dynamically
        for (Map<String, String> row : rows) {
            request.queryParam(row.get("type"), row.get("type_value"));
        }

        response = request.get("http://api.weatherbit.io/v2.0/current");
    }
}


