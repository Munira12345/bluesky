# bluesky

A flutter app that displays weather using OpenWeather API

#  BlueSky Weather App

A sleek Flutter app that displays weather for a particular city,
5-day forecast using the OpenWeatherMap API and 
Includes offline support and error handling.


---

##  Features

- View current weather and forecast for any city in a friendly UI 
- Search by city name
- Populates the next five days forecast for searched city.
- Offline support with cached data
- Responsive UI with loading and error states

---
## Approach
Used provider for state management
Designed a simple but responsive UI with Flutter’s Material components
Offline caching achieved via shared_preferences

Error handling integrated at both API and UI level
- OpenWeatherMap API
- `connectivity_plus` for network checks
- 
##  Challenges
 
- Outdated dependencies and Ndk versions conflicts that gave errors initially.
- Fixed by upgrading dependencies and the NDK version in build.gradle

- Challenge with public api key storage (future use of flutter_dotenv to better obfuscate the keys)

---

## How to Run
Clone the repository
```bash
git clone https://github.com/Munira12345/bluesky.git
cd bluesky
