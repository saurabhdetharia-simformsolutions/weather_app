# Weather App

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/562b615376a54a11aff54e33625f7165)](https://app.codacy.com/gh/saurabhdetharia-simformsolutions/weather_app/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)

Video preview: [Preview.mp4](https://github.com/saurabhdetharia-simformsolutions/weather_app/blob/main/preview/weather_app_preview.mp4)

Android apk: [Weather App](https://github.com/saurabhdetharia-simformsolutions/weather_app/blob/main/preview/weather_app_saurabh.apk)


## Requirements
- IDE: An Integrated Development Environment to view and run the code.
  - Recommended: Android Studio Giraffe (2022.3.1 Patch 4) or higher
- Android SDK (Required for Android apps)
  - NOTE: If you are using Android Studio as IDE, you won't need to do any additional setup for this.
- Flutter 3.13.0
  - Check [this](https://docs.flutter.dev/get-started/install) flutter setup guide to properly install flutter.
- XCode: 15.0 or Higher (Required for iOS apps)


## Minimum requirements

- Android Kitkat 4.4 or higher
- iOS 12 or higher

## Setup & Run
Make sure all the required components are installed and properly setup before running below steps. And you are at the root directory of project.

- Step 1: Run flutter doctor by executing following command and make sure it has no issues. If there are fix those issues before moving to next step.
  ```shell
  flutter doctor
  ```

- Step 2: Clone repository from github using below command.
    ```shell
    git clone https://github.com/saurabhdetharia-simformsolutions/weather_app
    ```

- Step 3: Open the project in your preferred IDE.

- Step 4: Get the API key from *[OpenWeather](https://openweathermap.org/api)* and set the `appId` variable at *`lib > values > constants.dart`* file.
    ```dart
   static const appId = '[Paste your key here]';

    /// If the api key is "XXXXXXXXXX", it will be like following after pasting it.
    ///    static const appId = 'XXXXXXXXXX';

    ```
- Step 5: Run `flutter pub get`.
- Step 6: Generate all the required files by running following command.
    ```shell
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
- Step 7: Make sure an emulator is running. OR a physical device is connected with the system.
- Step 8: Run the flutter app using following command.
    ```shell
    flutter run
    ```
## APIs
We've used OpenWeather API to get the weather data. Make sure you have startup subscription plan of this API.

Also, we have used Open Meteo API to get the location data.

## Resources & References
- [OpenWeather](https://openweathermap.org/)
- [Open-Meteo](https://open-meteo.com/)
- UI Reference: Android's weather app.
- CLEAN Architecture
- BLoC state management

## Development Tools:
- Android Studio Giraffe
- Flutter SDK 3.13.0
- XCode 15.0
- Postman