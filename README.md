# Take Note!

A simple notes app, set colours for notes, share notes, temporarily delete notes & archive your notes.

![Screenshot 2022-09-20 at 15 10 59](https://user-images.githubusercontent.com/97199759/191280698-561a6630-ebed-486f-9c74-f8c5dc9d454a.png)

<img src=![Screenshot_20220920_133707](https://user-images.githubusercontent.com/97199759/191282016-4843187b-daeb-49f6-9308-b4d91cc98cd7.png width=250)/>
![Screenshot_20220920_133746](https://user-images.githubusercontent.com/97199759/191282022-1e4c2705-a9b7-4065-a468-136516ae3203.png)
![Screenshot_20220920_133838](https://user-images.githubusercontent.com/97199759/191282028-7f05da9d-6437-4072-857f-b8db6562c316.png)
![Screenshot_20220920_134021](https://user-images.githubusercontent.com/97199759/191282031-58a27b8e-8901-4c8b-b7ae-05becc13dda4.png)
![Screenshot_20220920_134037](https://user-images.githubusercontent.com/97199759/191282033-fda0df48-08e9-4bad-ad39-c5a1273c9722.png)
![Screenshot_20220920_134056](https://user-images.githubusercontent.com/97199759/191282038-cdb06bd7-60a1-47b2-a658-159cba12e515.png)
![Screenshot_20220920_134111](https://user-images.githubusercontent.com/97199759/191282039-30741af1-c7df-413e-b0d2-ba1add640a3f.png)
![Screenshot_20220920_134224](https://user-images.githubusercontent.com/97199759/191282040-8b99c969-82da-4df1-a546-c3130034f516.png)


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
