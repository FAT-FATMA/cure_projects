# Cure — Healthcare & Medication Companion

Cure is a Flutter healthcare application prototype focused on medication planning and daily tracking. It combines Firebase email/password authentication with local SQLite storage and a medication dashboard.

## Implemented Features

### Authentication
- Welcome, registration, and login screens.
- Firebase Authentication with email and password.
- Password reset by email.
- Patient/Doctor account-type selection during registration.
- Basic profile preferences and session state stored locally with SharedPreferences.

> Patient and Doctor selection is currently an account preference only. Separate role-based screens, permissions, and workflows are not implemented.

### Medication Tracking
- Add medication records with a name, dose, start date, end date, time, and frequency.
- Daily, weekly, and monthly frequency options.
- Local persistence using SQLite and sqflite.
- View medication records, mark doses as taken, and remove records.
- Track progress against the configured treatment period.
- Display the next scheduled medication and a countdown on the dashboard.

## Technology Stack

- **Flutter & Dart** — cross-platform application UI.
- **Firebase Authentication** — email/password authentication and password reset.
- **Riverpod** — reactive state management for medication records.
- **SQLite / sqflite** — local medication persistence.
- **SharedPreferences** — local session and profile preferences.
- **Intl** — date formatting.

## Project Structure

```text
lib/
├── buisness/
│   └── medicine/       # Medicine model and Riverpod notifier
├── database/           # SQLite database and data access object
├── models/             # Data models
├── screens/            # Authentication, dashboard, and medication screens
├── services/           # Firebase options and service prototypes
└── widgets/             # Reusable UI components
```

## Setup

### Requirements
- Flutter SDK compatible with the Dart constraint in `pubspec.yaml`.
- Android Studio or VS Code with Flutter and Dart extensions.
- A Firebase project with Email/Password sign-in enabled.

### Run

1. Clone the repository:

   ```bash
   git clone https://github.com/FAT-FATMA/cure_projects.git
   cd cure_projects
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Configure Firebase for your own project with FlutterFire CLI. Generate the platform options file and register the matching Android/iOS application identifiers. Do not commit private service credentials.

4. Start the app:

   ```bash
   flutter run
   ```

## Current Scope and Limitations

This repository is a learning/prototype application, not a production-ready healthcare system.

- Medication data is stored locally on the device; it is not synchronized to a backend or across devices.
- Patient/Doctor selection is saved locally, but distinct role-based experiences are not implemented.
- The hospital map screen is a placeholder. The hospital service still contains a placeholder API endpoint.
- The appointments screen is a static UI demonstration, not a live appointment-booking feature.
- Alarm/notification service code is present but is not connected to the medication creation flow. Do not rely on it for medication reminders.
- Medication records are stored locally and are not account-scoped. To reduce the risk of exposing one account's records to another person on the same device, signing out currently clears the local medication table. Data is not recoverable from the app after sign-out.

## Attribution

This repository is a personal portfolio adaptation of the original Cure project:
[Adham-Elnomairy/Cure](https://github.com/Adham-Elnomairy/Cure).

The source project is credited here; this repository documents the current implementation and changes made in this copy.

## Author

**Fatma Mohsen Gad**

[GitHub Profile](https://github.com/FAT-FATMA)
