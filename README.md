ASPolylineView
==============

[![Badge w/ Version](http://cocoapod-badges.herokuapp.com/v/ASPolylineView/badge.png)](http://cocoadocs.org/docsets/ASPolylineView)
[![Badge w/ Platform](http://cocoapod-badges.herokuapp.com/p/ASPolylineView/badge.png)](http://cocoadocs.org/docsets/ASPolylineView) 
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


Drop-in replacements for MKPolylineRenderer and MKPolylineView with more customisation options.

Primarily let's you draw a coloured border around a line.

Can be used instead of `MKPolylineRenderer` or `MKPolylineView`. Adds the border by default. To change the colour supply the `borderColor` property. The `borderMultiplier` controls the width of that border.

## Installation

### Cocoapods

Add this to your `Podfile`:

```ruby
  pod 'ASPolylineView'
```

Then run `pod update`

### Carthage

Add this to your `Cartfile`:

```
github "nighthawk/ASPolylineView"
```

Then run `carthage update` and add the framework to your project as described in the [Carthage docs](https://github.com/Carthage/Carthage).
