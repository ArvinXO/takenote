# Take Note

A simple notes app, set colours for notes, share notes, temporarily delete notes & archive your notes.

![Screenshot 2022-09-20 at 15 10 59](https://user-images.githubusercontent.com/97199759/191280698-561a6630-ebed-486f-9c74-f8c5dc9d454a.png)

![Screenshot_20220920_133707](https://user-images.githubusercontent.com/97199759/191280885-d86976e0-2790-447e-8e1e-ab5c227e8596.png)
![Screenshot_20220920_133746](https://user-images.githubusercontent.com/97199759/191280890-37d08f96-bd2f-4768-8135-77dca959d2c3.png)
![Screenshot_20220920_133838](https://user-images.githubusercontent.com/97199759/191280893-f3c8eb6d-64e1-4f23-a533-4516b1a6c934.png)
![Screenshot_20220920_134021](https://user-images.githubusercontent.com/97199759/191280901-8e993199-dbbe-45ce-9923-72d3ba42077b.png)
![Screenshot_20220920_134037](https://user-images.githubusercontent.com/97199759/191280904-8e4139f4-c80a-4e9f-970c-62dcc81acf18.png)
![Screenshot_20220920_134056](https://user-images.githubusercontent.com/97199759/191280910-3e734c4f-23b1-4f6a-97a5-80af198067f9.png)
![Screenshot_20220920_134111](https://user-images.githubusercontent.com/97199759/191280912-4a39accb-2e1d-4049-a6e3-734d10a760b7.png)
![Screenshot_20220920_134224](https://user-images.githubusercontent.com/97199759/191280914-39b20185-36e0-46fe-a3ea-c2c2c1495fa8.png)


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
