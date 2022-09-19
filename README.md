# Take Note

A simple notes app, set colours for notes & archive your notes.

## Features
- Supports Android/iOS (iOS not published yet but works fine)
- List/grid view for notes
- Archive notes


## To-do
- [ ] Search notes
- [ ] Lock Notes - Local Auth
- [ ] Desktop Support
- [ ] Web Support

## Platform
 - Android
 - iOS ```not published```
 - Desktop ```work in progress```


## Compiling the app
Before anything, be sure to have a working flutter sdk setup.If not installed, go to [Install - Flutter](https://docs.flutter.dev/get-started/install).

Be sure to disable signing on build.gradle or change keystore to sign the app.

For now the required flutter channel is master, so issue those two commands before starting building:
```
$ flutter channel master
```
```
$ flutter upgrade
```

After that, building is simple as this:
```
$ flutter pub get
```
```
$ flutter run
```
```
$ flutter build apk
```

## Contributing

Feel free to open a PR to suggest fixes, features or whatever you want, just remember that PRs are subjected to manual review so you gotta wait for actual people to look at your contributions.
