# Cure — Healthcare & Medication Companion

Cure is a Flutter mobile application prototype designed to help users manage medication routines and keep track of upcoming doses. It combines Firebase email/password authentication with locally stored medication data and a simple health-focused dashboard.

## Features

### Authentication & Profile
- Welcome, sign-up, and login screens.
- Firebase Authentication with email and password.
- Password-reset email flow.
- Patient/Doctor role selection during registration.
- Local session and basic profile preferences stored with SharedPreferences.
- Sign-out functionality.

### Medication Management
- Add medicines with a name, dose, start date, end date, time, and frequency.
- Support for daily, weekly, and monthly schedules.
- Store medication records locally in SQLite.
- View the medication list, mark a dose as taken, and remove medicines.
- Track taken doses against the configured medication period.

### Medication Dashboard
- Display the next medication and its dose.
- Show a live countdown to the next scheduled dose.
- Present a simple overview of sample nearby-hospital information.

## Tech Stack

- **Flutter & Dart** — cross-platform application UI.
- **Firebase Authentication** — email/password sign-up, login, and password reset.
- **Riverpod** — application state management for medication data.
- **SQLite (\`sqflite\`)** — local persistence for medication records.
- **SharedPreferences** — local session and profile-preference storage.
- **Intl** — date formatting and parsing.

The repository also contains early alarm/notification service code and a hospital data-service scaffold. These components are not yet connected to the main medication workflow or a live hospital API.

## Project Structure

\`\`\`text
lib/
├── buisness/
│   └── medicine/       # Medicine model and Riverpod notifier
├── database/           # SQLite database and medicine DAO
├── models/             # Data models, including Hospital
├── screens/            # Authentication, dashboard, medicine, and prototype screens
├── services/           # Firebase options, alarm, and hospital service code
└── widgets/             # Reusable form fields and UI components
\`\`\`

## Getting Started

### Prerequisites
- Flutter SDK (Dart SDK compatible with the constraint in \`pubspec.yaml\`).
- Android Studio or VS Code with the Flutter and Dart extensions.
- A Firebase project with **Email/Password** sign-in enabled in Firebase Authentication.

### Run Locally

1. Clone the repository:
   \`\`\`bash
   git clone https://github.com/FAT-FATMA/cure_projects.git
   cd cure_projects
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   flutter pub get
   \`\`\`

3. Configure Firebase for your own Firebase project using the FlutterFire CLI. Generate/update \`lib/services/firebase_options.dart\` and make sure the Android and iOS app registrations match your application identifiers.

4. Run the application:
   \`\`\`bash
   flutter run
   \`\`\`

## Current Scope & Notes

Cure is a learning/prototype project, and some areas are still in progress:

- Patient/Doctor selection is saved locally; separate doctor and patient feature workflows are not implemented yet.
- The hospital map screen is currently a placeholder. Hospital cards show sample data, and the hospital service still points to a placeholder API URL.
- The appointments screen is a static UI demonstration, not a live booking system.
- Alarm and local-notification code exists, but medication creation does not currently schedule alarms through that service.

These limitations are documented to distinguish implemented functionality from planned or prototype UI.

## Author

**Fatma Mohsen Gad**

GitHub: [FAT-FATMA](https://github.com/FAT-FATMA)

---

Built with Flutter.
