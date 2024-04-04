<p align="center">
  <img src="assets/svg/imagotype_dark.svg">
</p>

<p align="center">An accessible e-learnign app for visually impaired people</p>

## About

This application is part of the project "Accessibility applied to the creation of digital content for visually impaired people"

## Requirements

- Flutter SDK: https://docs.flutter.dev/get-started/instal

- Google Firebase Project with the following services enabled:
  > - Firebase Authentication
  > - Firebase Storage
  > - Firestore Database

## Getting Started

To run the project, follow these steps

1. Clone the project repository to your local machine.
2. Navigate to the root of the project.

3. If you haven't already, <a href="https://firebase.google.com/docs/cli#setup_update_cli">Install the Firebase CLI</a>

4. Log into Firebase using your Google Account

```bash
firebase login
```

6. Install the FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

7. Configure your app, select your firebase project and then select the android platform

```bash
flutterfire configure
```

8. Install the required dependencies by executing the following command

```bash
flutter pub get
```

## Running the project

Select the device of your preference and copy its id

```bash
flutter devices
```

Run the following command with your actual device id

```bash
flutter run -d [your-device-id]
```

## Testing

### Unit Testing

Unit tests are placed inside the folder:

> test/{feature}/unit_testing/

Where `feature` is the tested feature

To run unit tests, write the following command

```bash
flutter test test/{feature}/unit_testing/{test_name}.dart -r expanded
```

### Integration Testing

Integration testing are placed inside the folder:

> integration_test/

To run integration tests, write the following command

```bash
flutter test integration_test/{test_name}.dart -r expanded -d {your_device_id}
```
