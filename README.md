# Flutter Video Chat w/ Agora.io

flutter_video_chat is a simple front-end combining text-messaging (using Google Firebase) and video chat (using Agora.io for Flutter).

![Alt Text](https://media.giphy.com/media/kHCkBvBVbuOhfOQgwL/giphy.gif)

##Collaborators

- [Jeremy Friesen](https://github.com/jeremydavidfriesen)
- [Tamilselvan Balasuntharam](https://github.com/MegaTlash)
- [Harry Thasarathan](https://github.com/Harry-Thasarathan)
- [Spencer Denford](https://github.com/spencerdenford)


## Setup

### Firebase
- In the cloned repository, replace the package names with your own
	- applicationId in build.gradle (android\app)
	- package in MainActivity.kt (android\app\src\main\kotlin\com\example\video_chat)
	- package in all three AndroidManifest.xml files (android\app\src\main, android\app\src\debug, android\app\src\profile)
  
- go to https://console.firebase.google.com/
- create a project
- register project for android (use the package name you chose earlier)
- Download 'google-services.json'
- move 'google-services.json' to android > app
- change pubspec.yaml and both gradle files to include firebase
- run 'flutter pub get' to import dependencies

- in the firebase console, under "Develop" select "Authentication"
- Click "Set up sign-in method"
- Enable "Email/Password" sign-in method

- in the firebase console, under "Develop" select Database
- Click "Create Database"
- Accept defaults

### Agora.io

- go to Agora's website, https://www.agora.io/
- sign up
- create project
- copy App ID and set the const APP_ID in lib\video_room.dart 