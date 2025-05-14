#  BlueSky Weather App

- A sleek Flutter app that displays weather for a particular city using OpenWeather API 
- 5-day forecast using the OpenWeatherMap API and 
- Includes offline support and error handling.


---

##  Features

- View current weather and forecast for any city in a friendly UI 
- Search by city name
- Populates the next five days forecast for searched city.
- Offline support with cached data
- Responsive UI with loading and error states

---
## Approach
- Used provider for state management
- Designed a simple but responsive UI with Flutter’s Material components
- Offline caching achieved via shared_preferences

Error handling integrated at both API and UI level
- OpenWeatherMap API
- `connectivity_plus` for network checks
  
##  Challenges
 
- Outdated dependencies and Ndk versions conflicts that gave errors initially.
- Fixed by upgrading dependencies and the NDK version in build.gradle

- Challenge with public api key storage (future use of flutter_dotenv to better obfuscate the keys)

##  UI 
![Splashscreen](https://github.com/user-attachments/assets/46bf88c9-64ec-42d1-afd1-c558c578a493)



![Homescreen](https://github.com/user-attachments/assets/b7e6fcdc-cfee-4404-adf3-6a0569046105)



---

## How to Run
Clone the repository
```bash
git clone https://github.com/Munira12345/bluesky.git
cd bluesky
