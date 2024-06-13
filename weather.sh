#!/bin/bash

# Your OpenWeatherMap API key
source ~/.config/api.keys
API_KEY="$OWM_API_KEY"

# Function to install npm if not installed
install_npm() {
  if ! command -v npm &> /dev/null
  then
    echo "npm not found. Installing..."
    # For macOS, you can install npm via Homebrew
    if command -v brew &> /dev/null
    then
      brew install node
    else
      echo "Homebrew not found. Please install npm manually."
      exit 1
    fi
  fi
}

# Function to install location-cli if not installed
install_location_cli() {
  if ! command -v location &> /dev/null
  then
    echo "location-cli not found. Installing..."
    npm install -g location-cli
    if [ $? -ne 0 ]; then
      echo "Failed to install location-cli. Please install it manually."
      exit 1
    fi
  fi
}

# Function to install jq if not installed
install_jq() {
  if ! command -v jq &> /dev/null
  then
    echo "jq not found. Installing..."
    # For macOS, you can install jq via Homebrew
    if command -v brew &> /dev/null
    then
      brew install jq
    else
      echo "Homebrew not found. Please install jq manually."
      exit 1
    fi
  fi
}

# Function to get device location using location-cli
get_device_location() {
  location_data=$(location)
  if [ $? -ne 0 ]; then
    echo "Error getting location data."
    exit 1
  fi

  lat=$(echo $location_data | jq -r '.latitude')
  lon=$(echo $location_data | jq -r '.longitude')
  echo "Detected location: Latitude $lat, Longitude $lon"
}

# Function to get weather data using OpenWeatherMap One Call API
get_weather() {
  local lat=$1
  local lon=$2

  response=$(curl -s "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely,hourly,alerts&units=metric&appid=$API_KEY")
  if [ $? -ne 0 ]; then
    echo "Failed to retrieve weather data."
    exit 1
  fi

  temp=$(echo $response | jq -r '.current.temp')
  humidity=$(echo $response | jq -r '.current.humidity')
  weather=$(echo $response | jq -r '.current.weather[0].description')

  echo "Temperature: ${temp}°C"
  echo "Humidity: ${humidity}%"
  echo "Weather: ${weather^}"
}

# Check and install npm if necessary
install_npm

# Check and install location-cli if necessary
install_location_cli

# Check and install jq if necessary
install_jq

# Get device location
get_device_location

# Get weather data
get_weather $lat $lon

