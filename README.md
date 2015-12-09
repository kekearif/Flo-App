# Flo-App

Flo is a water tracking app created from a tutorial from Ray wenderlich at : http://www.raywenderlich.com/90690/modern-core-graphics-with-swift-part-1. Highly recommended for anyone getting to grips with Core Graphics concepts.

Code converted from Swift to Objective-C. Hopefully others who work in Objective-C will find it useful.

Note that it is possible to use IBInspectables in Objective-C however default values cannot be set. Even if you set them in `initWithCoder:(NSCoder *)coder` they won’t show in the interface builder. It is better just to set them in the interface builder (i.e. not choosing default and choosing a value or color).

The app uses test data for 7 days of water drinking. It doesn’t actually save the data, just demonstrates some of the features of Core Graphics.

Optimised for iOS8+, iPhone5 - iphone6S+

<img src="https://github.com/kekearif/Flo-App/blob/master/Screenshots/screen1.png?raw=true" alt="Counter View" align="left">
<img src="https://github.com/kekearif/Flo-App/blob/master/Screenshots/screen2.png?raw=true" alt="Counter View" align="center">







