
# 🚀 ProFIT: Your Ultimate Fitness Solution 📱💪

**ProFIT** is a Flutter-based mobile application that offers comprehensive fitness coaching tools for trainees, trainers, and admins. It provides real-time communication, personalized fitness plans, and user-friendly features to help you track and achieve your fitness goals. Developed as part of our graduation project, ProFIT is designed to help users stay motivated and connected throughout their fitness journey.

## 🌟 Overview

### Key Features for Trainees:
- **Comprehensive Fitness Tracking**: Track steps, heart rate, sleep patterns, and water intake.
- **Goal Setting & Motivation**: Set daily fitness goals, participate in challenges, and earn achievements.
- **Personalized Plans**: Access workout and diet plans, with real-time feedback from trainers.
- **Real-Time Chat**: Communicate with trainers using chat, powered by socket technology.

### Key Features for Trainers:
- **Manage Trainees**: Access and update trainee profiles, and provide feedback on their performance.
- **Performance Analytics**: Monitor progress using analytics and deliver data-driven insights.

### Key Features for Admins:
- **User & Trainer Management**: Approve trainer profiles and manage user accounts efficiently.

## 📂 Project Structure

Here’s the structure of the `lib` folder in this Flutter app:

```
lib/
├── Views/
│   ├── pages/
│   │   ├── Diet/
│   │   ├── Explore/
│   │   ├── Features/
│   │   ├── More/
│   │   ├── Onboarding/
│   │   ├── Profile/
│   │   ├── Registration/
│   │   ├── Tabs/
│   │   ├── Workout/
│   │   └── ai/
│   ├── widgets/          # Custom widgets used across the app
│   └── services/         # Services for handling data and API calls
├── utils/                # Utility classes and helper functions
├── main.dart             # Main entry point for the Flutter app
```

### Key Folder Descriptions:
- **Views/pages/**: Contains the UI pages of the app, such as the Diet page, Explore page, Onboarding, Registration, etc.
- **Views/widgets/**: Houses reusable widgets that are used across various parts of the app.
- **services/**: Includes service classes responsible for interacting with APIs, handling data logic, and more.
- **utils/**: Holds utility functions and constants that are used throughout the project.

## 🛠️ Technologies Used

- **Frontend**:
  - **Flutter**: Cross-platform mobile development framework.
  - **Dart**: Programming language for Flutter apps.
  - **GetX**: State management for managing the app state efficiently.

- **Backend**:
  - **Node.js**: Server-side development for handling API logic.
  - **Express.js**: For creating RESTful APIs.
  - **MongoDB**: NoSQL database for data storage.

- **Real-Time Communication**:
  - **Socket.io**: Enables real-time chat and communication between trainees and trainers.

## 🚀 Getting Started

### Prerequisites

To run this project locally, ensure you have the following installed:
- **Flutter** (latest stable version)
- **Dart SDK**
- **Node.js** (for the backend)
- **MongoDB** (locally installed or MongoDB Atlas for cloud database)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Ahmed55714/ProFIT.git
   ```

2. **Install Flutter dependencies**:
   Navigate to the root of the Flutter app and install dependencies:
   ```bash
   cd ProFIT
   flutter pub get
   ```

6. **Run the Flutter app**:
   Make sure you have a device or emulator running, and execute:
   ```bash
   flutter run
   ```

### Running Tests

Run Flutter unit and widget tests using the following command:
```bash
flutter test
```


## 🔒 License

This project is licensed under the **Alpha Team License**. See the [LICENSE](LICENSE) file for more details.

---

Thank you for exploring **ProFIT**! We hope this app will help you stay motivated on your fitness journey. For any questions or issues, feel free to reach out.

