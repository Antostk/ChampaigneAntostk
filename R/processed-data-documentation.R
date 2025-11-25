#processed data documentation

#' Process raw weather data from JSON file
#'
#' @param json_path Path to the raw JSON file
#' @return Processed data frame with weather information
#'
#' @examples
#' \dontrun{
#' processed_data <- process_weather_data("data-raw/weather_full.json")
#' }
#'
# processed data documentation

#' Processed weather data
#'
#' A dataset containing the processed weather information.
#'
#' @format A data frame with 10 rows and 4 variables:
#' \describe{
#'   \item{city}{Character string with city name}
#'   \item{temperature}{Numeric temperature (°C)}
#'   \item{humidity}{Numeric humidity (%)}
#'   \item{pressure}{Numeric pressure (hPa)}
#' }
#'
#' @source Automatically generated from raw JSON in data-raw/weather_full.json
#'
#' @usage data(processed_data)
#'
#' @export
processed_data


