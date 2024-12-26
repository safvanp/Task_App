Task App
Overview
Task App is a simple and efficient task management application built using Flutter. It leverages the power of Flutter Bloc for state management, providing a clean architecture and seamless user experience.

Features
Home Page: View and manage your tasks efficiently.
Create Task Page: Add new tasks to the list.
State Management: Powered by flutter_bloc for reactive updates and scalable architecture.
Requirements
Flutter SDK
Dart
A code editor (e.g., VS Code or Android Studio)
Installation
Clone the repository:
bash
Copy code
git clone https://github.com/your-repository/task-app.git
cd task-app
Install dependencies:
bash
Copy code
flutter pub get
Run the app:
bash
Copy code
flutter run
File Structure
graphql
Copy code
lib/
├── bloc/               # Contains TaskBloc for state management
├── constants.dart      # Stores application constants
├── repository/         # Contains TaskRepository for managing data
├── screens/            # UI screens (HomePage, CreateTask)
└── main.dart           # Application entry point
Key Packages
flutter_bloc: For state management using the BLoC pattern.
material: For UI components.
Routes
/: Home Page
/create: Create Task Page
How It Works
State Management:

TaskBloc manages the application state.
Tasks are fetched and updated through TaskRepository.
UI:

HomePage displays the list of tasks.
CreateTask allows users to add new tasks.
Dependency Injection:

BlocProvider initializes TaskBloc with TaskRepository.
Getting Started
Open the app and view existing tasks on the Home Page.
Navigate to the Create Task page using the app's navigation system.
Add a new task and see it reflected on the Home Page.
