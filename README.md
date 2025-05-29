# Flutter News App 📰

A Flutter application that allows users to view top headlines, bookmark articles, and read full content via WebView. Includes login, dark mode, pull-to-refresh, and search functionality.

## 🚀 Setup Instructions

1. **Clone the repo**  
```bash
https://github.com/GurparteekSingh23/News-App-Flutter.git



Screenshots

![news feed screen](https://github.com/user-attachments/assets/7c584987-edb0-4095-b6be-2ef8328549fc)
![dark mode screen](https://github.com/user-attachments/assets/47c3a8cc-6c05-42b7-acd6-167991b69bb0)
![login screen](https://github.com/user-attachments/assets/083b8e3d-36cb-48db-9230-0abf0473c991)
![bookmark screen](https://github.com/user-attachments/assets/09664192-42c1-4b79-a53a-77498c150a49)

ARCHITECURE CHOICES

Separation of Concerns:
UI components are placed in individual widgets (NewsScreen, BookmarksScreen, etc.), while logic such as data fetching and persistence is handled in the respective screen states or helper methods.

State Management:
Minimal built-in StatefulWidget state management is used, as the app is small and doesn’t require complex reactivity. SharedPreferences handles persistence .
Provider is used for changing the theme mode dark and light

Navigation:
Navigator.push is used to navigate to the WebView screen.
DefaultTabController is used to manage tab navigation between News and Bookmarks pages.

No Backend:
Since no backend is required, user login sessions and bookmarks are handled locally using SharedPreferences.

 List of Third-Party Packages Used and Why
Package	                           Use Case
dio	                               For making HTTP requests to the News API with ease and advanced options.
shared_preferences	               To store user session and bookmarks locally on device.
webview_flutter	                   To show full news article content in an in-app browser (WebView).
intl	                             For formatting published dates into a human-readable format.

google drive link
https://drive.google.com/file/d/1skszL0olr8-bGLKTZTQQFtQpxSo_7re-/view?usp=drive_link







