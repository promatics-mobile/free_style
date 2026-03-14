# Project Architecture

Feature-based architecture.

Example:

lib/
├── views/
│   └── profile/
│        ├── profile_screen.dart
│        ├── profile_cubit.dart
│        ├── profile_state.dart
│        └── widgets/
│
├── network_class/
│      dio_client.dart
│      api_service.dart
│
├── utils/
│      common_widgets
│      common_methods
│
└── routes/
    route.dart