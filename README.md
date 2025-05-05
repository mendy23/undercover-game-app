
## How to Run the App

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) (or another IDE like VSCode with Flutter plugin)
- An Android emulator or a physical Android device

### Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/mendy23/uncover-game-app.git
   cd uncover-game-app/android_app_v2
   ```

2. **Open in Your Preferred IDE**
   Open the project in **Android Studio** or **VSCode**.

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Start an Emulator or Connect a Device**
   - Launch an Android emulator using Android Studio  
     **or**
   - Connect a physical Android device with USB debugging enabled.

5. **Run the App**
   ```bash
   flutter run
   ```

# Undercover Game App

A Flutter implementation of Undercover game where players have to identify the infiltrators among them based on word describtions. 

## App Structure

The app consists of 5 main screens:

1. **Home Setup Screen** - Configure the number of players
2. **Role & Word Distribution Screen** - Enter player names and distribute roles and words
3. **Game Room Screen** - View game state (alive/eliminated players)
4. **Voting Screen** - Cast votes to identify the undercover player
5. **Result Screen** - Display voting results and game outcome

## Game Flow

1. Set the number of players in the Home Setup Screen → Proceed to Role Word Distribution Screen
2. Enter names and receive assigned roles and words → Start the game - Proceed to Game Room Screen
3. Players describe their words verbally → Proceed to Voting Screen
4. Each player votes secretly → View results - Proceed to Result Screen
5. If game continues → Return to Game Room Screen
6. If game ends → Return to Home Setup Screen for a new game
