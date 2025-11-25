# ChampagneAntostk

## Overview

The **ChampagneAntostk** package simulates champagne consumption at parties based on glass profiles and weather conditions. It was created for a Data and Management course assignment. The package allows users to model glasses, compute volumes, estimate expected attendance from weather, and run Monte Carlo simulations to estimate champagne usage.

---

## Project Structure

```
ChampagneAntostk/
│
├─ data-raw/
│   ├─ weather_full.json          # Raw weather data from JSON
│   └─ data_transformation.R      # Script to process raw JSON into usable dataset
│
├─ data/
│   └─ processed_data.rda         # Processed dataset (loaded in package)
│
├─ R/
│   ├─ glass.R                     # GlassProfile constructor + methods (volume, radius)
│   ├─ radius_fun.R                # S(), r_scalar(), r_vec_for_integrate() functions
│   ├─ weather.R                   # CityWeather class + print method
│   ├─ expected_lambda.R           # Function to compute expected number of guests
│   ├─ simulate.R                  # simulate_party() function
│   └─ processed_data_documentation.R  # Documentation for processed dataset
│
├─ man/                            # Auto-generated documentation
├─ DESCRIPTION                     # Package metadata
├─ NAMESPACE                        # Auto-generated exports
└─ ChampagneAntostk.Rproj          # RStudio project file
```

---

## Key Components

### 1. Glass Profiles

* `GlassProfile()` constructor defines a champagne glass with foot, stem, bowl, and rim dimensions.
* `radius_cone()` computes the radius at any height along the glass.
* `volume_between()` computes the volume of champagne between two heights.
* `S()`, `r_scalar()`, and `r_vec_for_integrate()` define the radius transitions for smooth glass shapes.

### 2. Weather and Expected Guests

* `CityWeather()` defines weather conditions for a city (temperature, humidity, pressure).
* `expected_lambda()` calculates expected number of guests using weather-based formulas.

### 3. Simulation

* `simulate_party()` runs Monte Carlo simulations to estimate:

  * Number of guests
  * Glasses poured per guest
  * Total liters and bottles of champagne required
* Users can customize the number of simulations, bottle sizes, and glass parameters.

### 4. Data

* Raw weather data is stored in `data-raw/weather_full.json`.
* Processed data (`processed_data`) is generated with `data_transformation.R` and stored in `data/`.

---

## Installation

Clone the repository:

```bash
git clone https://github.com/Antostk/ChampaigneAntostk.git
```

Open the project in RStudio and install dependencies:

```r
install.packages(c("jsonlite", "devtools"))
```

Build and load the package locally:

```r
devtools::document()   # Generate documentation
devtools::load_all()   # Load package functions
```

---

## Usage

### Load processed weather data

```r
data(processed_data)
```

### Define a glass and compute volume

```r
glass <- GlassProfile(a = 2, b = 10, x_1 = 1, x_2 = 2, x_3 = 8, x_4 = 12,
                      r_foot = 3, r_stem = 0.4, r_bowl = 3.5, r_rim = 4)
volume_between(glass)   # Compute volume in cm³
```

### Estimate expected guests

```r
bern_weather <- processed_data[["Bern"]]
bern_city <- CityWeather(city = "Bern", 
                         temperature = bern_weather$temperature,
                         humidity = bern_weather$humidity,
                         pressure = bern_weather$pressure)
expected_lambda(bern_city)
```

### Run a simulation

```r
sim <- simulate_party("Bern", processed_data, N = 1000, bottle_L = 0.75)
sim$total_liters
sim$total_bottles
```

---

## Documentation

* Functions are documented using **roxygen2**. Access help in R:

```r
?GlassProfile
?expected_lambda
?simulate_party
```

* Processed dataset documentation:

```r
?processed_data
```

---

## Testing

* Tests are implemented using `testthat` in the `tests/` folder.
* Run tests locally:

```r
devtools::test()
```

---

## Notes

* Weather-based attendance formulas can be adjusted for realism.
* Glass parameters can be modified to simulate different champagne flutes.
* The package is designed as a teaching project but can be extended for more complex simulations.

---

## Author

**Antoine Standke**
HEC Lausanne – Master in Management, Business Analytics

GitHub: [https://github.com/Antostk/ChampaigneAntostk](https://github.com/Antostk/ChampaigneAntostk)
