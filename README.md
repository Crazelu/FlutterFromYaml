# FlutterFromYaml

An experiment born out of a simple curious question: *What if you could build a screen in Flutter code using yaml?*

The answer? Well yes you can!

This project demonstrates how the default Flutter counter app can be generated from a YAML configuration file.
State variables and functions can be injected into widgets using bindings to make them reactive and have them execute functions (e.g onTap of GestureDetector).

## How To Use 🏗️
- Clone the project
- Open the project directory in your terminal
- Run the following command to generate the `main.dart` file

```dart
dart run lib/build.dart
```
- Run the app on your device

## Supported Widgets ✅
[x] Center
[x] Column
[x] FloatingActionButton
[x] GestureDetector
[x] Icon
[x] ListeableBuilder
[x] Row
[x] Scaffold
[x] AppBar
[x] SizedBox
[x] Text
[x] StatelessWidget
[x] StatefulWidget
[ ] TextButton
[ ] Container
[ ] Image

## Supported injectable bindings 💉
[x] State variables (implemented as ValueNotifiers) of a StatefulWidget. They are also auto disposed.
[x] Functions defined for the State of a StatefulWidget

### Bindings in YAML
```yaml
StatefulWidget:
  name: GeneratedYamlHomePage
  state:
    - counter:
        type: int
        defaultValue: 0
    - multiplier:
        type: String
        defaultValue: "''"
  functions:
    increment: "counter.value += 1;"
    decrement: "counter.value -= 1;"
```

Then use in widgets like so:

```yaml
    Column:
        mainAxisAlignment: center
        children:
        - Text:
            value: "Hello from Yaml\\nYou've pressed this button"
            textAlign: center
            style:
                fontSize: 24
                fontWeight: 500
        - SizedBox:
            height: 12
        - ListenableBuilder:
            listenable: "@@state.counter" #This will be injected
            child:
                Text:
                value: "${counter.value} times"
                style:
                    fontSize: 20
        - SizedBox:
            height: 12
        - ListenableBuilder:
            listenable: ["@@state.multiplier", "@@state.counter"] #This will be injected
            child:
                Text:
                value: "${counter.value} x ${counter.value} is ${multiplier.value}"
                style:
                    fontSize: 20
        - SizedBox:
            height: 32
        - GestureDetector:
            bind: true
            onTap: "@@function.increment" #This will be injected since 'bind' is true
            child:
            Icon:
                iconData:
                codePoint: 0xe047
```

## Contributions 🫱🏾‍🫲🏼

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/Crazelu/flutterfromyaml/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/Crazelu/flutterfromyaml/pulls).