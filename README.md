# College Application

A full-featured Flutter application for college students to manage their academic activities.

## Features

- Firebase Authentication (Email & Password)
- Dashboard with student information
- Attendance tracking
- Exam and class timetables
- Study materials access
- Fee payment portal
- Hostel menu viewing

## Setup Instructions

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Configure Firebase:
    - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
    - Add Android and iOS apps to your Firebase project
    - Download the configuration files:
        - `google-services.json` for Android (place in `android/app/`)
        - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)
4. Enable Authentication in Firebase Console:
    - Go to Authentication > Sign-in method
    - Enable Email/Password authentication
5. Set up Firestore Database:
    - Create a Firestore Database
    - Start in test mode or with appropriate security rules
6. Run the app: `flutter run`

## Firebase Structure

```
/users/{userId}
  - name: String
  - email: String
  - department: String
  - dob: Timestamp
  - profileImage: String (URL)

/attendance/{userId}
  - totalClasses: Number
  - attendedClasses: Number
  - subjects: {
      subject1: { total: Number, attended: Number },
      subject2: { total: Number, attended: Number },
      ...
    }

/exams/{examId}
  - title: String
  - date: Timestamp
  - time: String
  - venue: String
  - subject: String
  - department: String

/timetable/{departmentId}
  - monday: [{ subject: String, time: String, room: String }]
  - tuesday: [...]
  ...

/studyMaterials/{materialId}
  - title: String
  - description: String
  - uploadDate: Timestamp
  - fileUrl: String
  - subject: String
  - department: String

/fees/{userId}
  - totalAmount: Number
  - paidAmount: Number
  - pendingAmount: Number
  - transactions: [{ date: Timestamp, amount: Number, receipt: String }]

/hostelMenu/
  - monday: { breakfast: String, lunch: String, dinner: String }
  - tuesday: { ... }
  ...
```