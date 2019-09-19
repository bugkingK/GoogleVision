## GoogleVision
Integrates Google Vision features, including image labeling, face, logo, and landmark detection, optical character recognition (OCR), and detection of explicit content, into applications.

A framework to use <a href="https://cloud.google.com/vision/docs/">Cloud Vision API by Google</a> in Swift.


## Installation
<b>CocoaPods:</b>
<pre>
pod 'GoogleVision'
</pre>
<b>Manual:</b>
<pre>
Copy <i>GoogleVision.swift</i> to your project.
</pre>

## Initialization

First of all you have to generate API key to use Google Cloud services in the <a href="https://cloud.google.com/translate/">console</a>.
And then use the following code:
```swift
GoogleVision.init(apiKey: "")
```

## Using

```swift
let gv = GoogleVision.init(apiKey: "")
let img = UIImage(named: "Image")
gv.run(image:img) { (text, err) in
    guard let text = text, err == nil else {
        print(err?.localizedDescription)
        return
    }

    print(text)
}
```

## License

<i>GoogleVision</i> is available under the MIT license. See the LICENSE file for more info.
