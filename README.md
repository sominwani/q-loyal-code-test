## 🌦️ Weather API Test Suite with Cucumber, JUnit, and RestAssured  

### 🚀 Overview  
This project is a comprehensive API test suite for the **Weather API**, built with:  
- **Java (17+)** — Core language  
- **JUnit** — Assertions and reporting  
- **Cucumber** — BDD for readable tests  
- **RestAssured** — For making HTTP requests  
- **Maven** — Build and dependency management  

---

### 📁 Project Structure  
```bash
weather-api-tests/
│
├── pom.xml  # Maven dependencies
│
├── src/
│   ├── main/java/       # (Not needed for this project - pure test project)
│   └── test/
│       ├── java/
│       │   ├── steps/WeatherApiSteps.java    # Step definitions
│       │   └── runners/CucumberTestRunner.java # Test runner
│       └── resources/features/weatherApi.feature  # Cucumber scenarios
│
└── README.md  # This file!
```

---

### 🛠️ Setup Instructions  

1. **Clone the project:**  
   ```bash
   git clone https://github.com/your-repo/weather-api-tests.git
   ```

2. **Open the project in your favorite IDE (IntelliJ, Eclipse, etc.)**  

3. **Ensure you have JDK 17+ installed:**  
   ```bash
   java --version
   ```

4. **Install Maven (if not already installed):**  
   ```bash
   mvn --version
   ```

5. **Install project dependencies:**  
   ```bash
   mvn clean install
   ```

---

### 🧪 Running Tests  

1. **Run the Cucumber suite:**  
   ```bash
   mvn test
   ```

2. **Generate HTML and JSON reports:**  
   - **HTML Report:** `target/cucumber-report.html`  
   - **JSON Report:** `target/cucumber-report.json`  

---

### 🔥 Test Scenarios  

The feature file covers a wide range of positive, negative, boundary, and error handling tests, including:  
- ✅ **Valid and invalid cities**  
- ✅ **Latitude/longitude combinations**  
- ✅ **Postcode-based weather queries**  
- 🚫 **Missing or malformed API keys**  
- 🔥 **Boundary tests** (short/long city names, extreme lat/lon)  
- 🔒 **Security checks** (SQL Injection, XSS, Path Traversal)  
- 🌍 **Localization tests** (special characters, multilingual cities)  
- 🔄 **Resilience tests** (network delays, API downtime simulation)  

---

### 🔧 Extending the Suite  

1. **Add more scenarios** to `src/test/resources/features/weatherApi.feature`.  
2. **Implement extra steps** in `WeatherApiSteps.java`.  
3. **For parallel execution:**  
   - Add the Maven Surefire or Cucumber Parallel plugin.  
4. **Move api url, api key into a yaml file.**

---

### 📌 Author  

Created by: **Somin Wani**

### 📌 ROLE Applying For

**Senior Quality Engineer – Qantas Hotels**

