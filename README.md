# Try 🍀

A [Flutter](https://flutter.dev) application designed to assist in preparing for English speaking tests (TOEFL) using the [OpenAI GPT API](https://openai.com/api/).

> This repository focuses on the front-end implementation. For the Spring Boot server and AI prompt engineering, please refer to the [back-end repository](https://github.com/TRY-growth/BE_public).

## 📁 Project Structure

```
lib/
├── main.dart                      # The entry point of the application
├── src/
│   ├── repository/                # Handles data management and interaction with data sources
│   │   ├── task1_repository.dart    
│   │   ├── task2_repository.dart   
│   │   ├── task3_repository.dart    
│   │   ├── task4_repository.dart     
│   │   ├── news_repository.dart     
│   │   └── home_repository.dart    
│   ├── model/                     # Defines the data structures
│   │   ├── task1_model.dart      
│   │   ├── task2_model.dart         
│   │   ├── task3_model.dart       
│   │   ├── task4_model.dart         
│   │   ├── news_model.dart        
│   │   └── report_model.dart       
│   └── view/                      # Contains the UI components
│       ├── base_view.dart           
│       ├── auth/                  # Contains authentication views and view models
│       │   ├── login_view.dart           
│       │   └── login_view_model.dart 
│       ├── home/
│       │   ├── home_view.dart          
│       │   ├── home_view_model.dart    
│       │   ├── rotation_3d.dart        
│       │   └── learning_history_view.dart 
│       ├── test/
│       │   ├── common/            # Shared widgets for test and news
│       │   │   ├── microphone_test_widget.dart    
│       │   │   ├── reading_material_widget.dart  
│       │   │   ├── loading_view.dart            
│       │   │   ├── feedback_view.dart           
│       │   │   ├── question_widget.dart       
│       │   │   └── listening_material_widget.dart 
│       │   ├── test_view.dart        
│       │   ├── task1/
│       │   │   ├── task1_view.dart          
│       │   │   └── task1_view_model.dart 
│       │   ├── task2/
│       │   │   ├── task2_view.dart        
│       │   │   └── task2_view_model.dart    
│       │   ├── task3/
│       │   │   ├── task3_view.dart        
│       │   │   └── task3_view_model.dart   
│       │   ├── task4/
│       │   │   ├── task4_view.dart         
│       │   │   └── task4_view_model.dart    
│       ├── news/
│       │   ├── news_view.dart            
│       │   ├── news_view_model.dart      
│       │   ├── drop_cap_text.dart      
│       │   ├── news_detail_view.dart     
│       │   └── news_learning_view.dart  
```

## 🚀 Build and Run Instructions

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Visual Studio Code](https://code.visualstudio.com/) or another Flutter-supported IDE

### Installation and Execution

1. Clone the repository:

```sh
git clone <repository-url>
cd try_app
```

2. Install dependencies:

```sh
flutter pub get
```

3. Set up the `.env` file:

Create a `.env` file in the project root with the following content:

```
BASE_URL=your_server_cloud_url
DEEPGRAM_API_KEY=your_deepgram_api_key
```

You can get your API key from [Deepgram](https://deepgram.com/).

4. Run the app:

```sh
flutter run
```

## 🧪 Running Tests

To execute the test suite, use the following command:

```sh
flutter test
```

## 📊 Asset Information

- The `assets/` folder contains audio files generated using [Deepgram TTS](https://deepgram.com/).
- Icons are sourced from [Icons8](https://icons8.com/) through the [GitHub Student Pack](https://education.github.com/pack).
- Font information is specified in `pubspec.yaml`.

## 🛠️ Referenced Open Source Projects

- [flutter_vignettes](https://github.com/gskinnerTeam/flutter_vignettes): Referenced for UI elements such as drop_cap_text, rotation_3d.
- [diff-match-patch](https://github.com/google/diff-match-patch): Used for comparing feedback before and after edits. The dependency [`diff_match_patch`](https://pub.dev/packages/diff_match_patch) is based on this code.

### Key Dependencies

- [`provider`](https://pub.dev/packages/provider): State management library to manage application state.
- [`http`](https://pub.dev/packages/http): HTTP client for making API requests.
- [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv): Manage environment variables in a `.env` file.
- [`dynamic_color`](https://pub.dev/packages/dynamic_color): Provides dynamic theming capabilities.
- [`intl`](https://pub.dev/packages/intl): Supports internationalization and localization, particularly for date and number formatting.
- [`fluid_bottom_nav_bar`](https://pub.dev/packages/fluid_bottom_nav_bar): Customizable bottom navigation bar.
- [`diff_match_patch`](https://pub.dev/packages/diff_match_patch): Library for text diffing, useful for comparing text differences.
- [`permission_handler`](https://pub.dev/packages/permission_handler): Handles permissions, such as microphone access.
- [`sound_stream`](https://pub.dev/packages/sound_stream): Used for audio streaming, particularly for capturing microphone input for Deepgram STT.
- [`web_socket_channel`](https://pub.dev/packages/web_socket_channel): Provides WebSocket support, used for real-time communication with Deepgram API.
- [`rxdart`](https://pub.dev/packages/rxdart): A reactive programming library for managing asynchronous data streams.
- [`audioplayers`](https://pub.dev/packages/audioplayers): Used for audio playback within the app.

### Development Dependencies

- [`flutter_test`](https://pub.dev/packages/flutter_test): Testing framework for writing and running tests.
- [`flutter_lints`](https://pub.dev/packages/flutter_lints): Provides linting rules for Flutter projects to maintain code quality.
- [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons): Generates custom launcher icons for the app.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.