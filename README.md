# JLImageDownloader

Simple Swift Library for downlosding PNG and JPEG images from a given URL address. 
The library also caches images after they are downloaded so that if the same image needs to be displayed multiple times, it doesn't download the same image more than once. 

**Example UIKit Usage**

```
@IBOutlet var testImageView: UIImageView!
testImageView.setImage(urlString: "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg")
```

**Example SwiftUI Usage**

```
JLImage(urlString: "https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg").frame(height: 200)
```

The Included Sample 'TestApp' and 'TestAppSwiftUI' projects construct a list of dog images from an array of hardcoded URL strings.


![Simulator Screenshot - iPhone 15 - 2024-08-17 at 19 39 27](https://github.com/user-attachments/assets/38b23720-02d7-4f5d-b43e-4108e16918dd)
