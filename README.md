### Search Photos using Flickr API
• This Swift project contains simple search Flickr images and display  in UICollectioView grid.

### Features
1. Shows the results in a 2- column scrollable view.

2. Autocomplete list of history of past search terms using SearchTextField library

3. Lazy image loading using SDWebImage library

4. Load more: It starts by loading only enough photos e.g 20, and automatically request and display more images when the user scrolls to the bottom of the view. 

### Architecture
MVVM-C architecture for this project and adding closures to perform binding between View and ViewModel (MVVM).

C- Coordinator for managing app navigation flow.

### Language 
Swift 5

### Required third party libraries
[SDWebImage](https://github.com/SDWebImage/SDWebImage)

[SearchTextField](https://github.com/apasccon/SearchTextField)



### Getting Started
1. Clone the repo

2. In terminal, navigate to root folder of repo

3. Run below command

```sh
pod install
```
Cheers!
