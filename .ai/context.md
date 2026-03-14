# Project Context

Project Name: FreeStyle App

Tech Stack:
- Flutter
- Dart
- Cubit (Bloc)
- Dio
- GoRouter

Architecture:
Feature-based architecture.

lib/
├── views
├── network_class
├── utils
├── routes

Common Features:
- Authentication
- Profile
- Dashboard
- Challenges

Network Layer:
All APIs go through DioClient.

Retry System:
- Offline request queue
- Auto retry when internet returns


# UI System

The project uses a centralized UI utility system.

All UI must use components from:

lib/utils/

Especially:
- common_widgets
- common_decorations
- common_methods
- common_constants