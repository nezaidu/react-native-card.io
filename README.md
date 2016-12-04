<h2 align="center">react-native-card.io</h2>

<p align="center">
A <CardIO> component for react-native (iOS only) for <a href="https://www.card.io/" target="_blank">card.io</a>
</p>

<p align="center">
  <a href="http://badge.fury.io/js/react-native-card.io"><img alt="npm version" src="https://badge.fury.io/js/react-native-card.io.svg?1.3.1"></a>
  <a href="https://npmjs.org/package/react-native-card.io"><img alt="Downloads" src="http://img.shields.io/npm/dm/react-native-card.io.svg?1.3.1"></a>
</p>


### TODO
- [ ] Support Android
- [x] Support for overiding the `detectionMode`
- [x] Support for overiding the `scanOverlayView`

### Installation

#### iOS

A walkthrough with screenshots of each of the steps can be found [on my blog](http://ollie.relph.me/blog/credit-card-scanning-in-react-native/).

1. `npm i react-native-card.io --save`
1. Add the .xcodeproj from `node_modules/react-native-card.io/` to your .xcodeproj
1. Add libBBBCardIO.a to "Build Phases -> Link Binary With Libraries"
1. Add "-lc++" to "Other Linker Flags"
USE COCOAPODS


### Usage

[Example App](https://github.com/BBB/react-native-card.io-example) 

You can see the specific api usage [here](https://github.com/BBB/react-native-card.io-example/blob/master/src/containers/App.jsx)

**Please don't forget to respect [card.io](https://www.card.io/) [open source contributors](https://github.com/card-io/card.io-iOS-SDK#with-or-without-cocoapods) by putting the acknowledgments in your app**

```JSX
import React, {
  Component,
  View,
} from 'react-native';

import CardIO from 'react-native-card.io';

export default class App extends Component {
  render() {
    return (
      <View
        style={
          {
            position: 'absolute',
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
          }
        }
      >
        <CardIO
          style={
            {
              flex: 1,
              backgroundColor: 'black',
            }
          }
          hideCardIOLogo={ true }
          onSuccess={
            ( cardInfo ) => console.log(cardInfo)
          }
          onFailure={
            ( err ) => console.error(err)
          }
        />
      </View>
    );
  }
}
```

### Methods

`preload`

The preload method prepares card.io to launch faster. Calling preload is optional but suggested.
On an iPhone 5S, for example, preloading makes card.io launch ~400ms faster.
The best time to call preload is when displaying a view from which card.io might be launched.

### Options

Configuration options are specified as attributes on the `<CardIO />` element.

#### Language or Locale

Prop: `languageOrLocale`

**Defaults to the device's current language setting**

Can be specified as a language code ("en", "fr", "zh-Hans", etc.) or as a locale ("en\_AU", "fr\_FR", "zh-Hant\_HK", etc.).

If card.io does not contain localized strings for a specified locale, then it will fall back to the language. E.g., "es\_CO" -> "es".

If card.io does not contain localized strings for a specified language, then it will fall back to American English.

If you specify only a language code, and that code matches the device's currently preferred language, then card.io will attempt to use the device's current region as well.
E.g., specifying "en" on a device set to "English" and "United Kingdom" will result in "en\_GB".

##### These localizations are currently included:

`ar`, `da`, `de`, `en`, `en_AU`, `en_GB`, `es`, `es_MX`, `fr`, `he`, `is`, `it`, `ja`, `ko`, `ms`, `nb`, `nl`, `pl`, `pt`, `pt_BR`, `ru`, `sv`, `th`, `tr`, `zh-Hans`, `zh-Hant`, `zh-Hant_TW` 


#### Detection Mode

Prop `detectionMode`

##### One of:

`DETECTION_MODE.IMAGE_AND_NUMBER`: the scanner must successfully identify the card number.

`DETECTION_MODE.IMAGE`: don't scan the card, just detect a credit-card-shaped card.

`DETECTION_MODE.AUTOMATIC`: start as `IMAGE_AND_NUMBER`, but fall back to `IMAGE` if scanning has not succeeded within a reasonable time.

#### Guide Color

Prop `guideColor`

**Defaults to lime green**

Alter the card guide (bracket) color. Opaque colors recommended.

#### Use Card.io Logo

Prop `useCardIOLogo`

**Defaults to `false`**

Set to `true` to show the card.io logo over the camera instead of the PayPal logo.

#### Hide Card.io Logo

Prop: `hideCardIOLogo`

**Defaults to `false`**

Hide the PayPal or card.io logo in the scan view.

#### Allow Freely Rotating Card Guide

Prop: `allowFreelyRotatingCardGuide`

**Defaults to `true`**

By default, in camera view the card guide and the buttons always rotate to match the device's orientation.

All four orientations are permitted, regardless of any app or viewcontroller constraints.

If you wish, the card guide and buttons can instead obey standard iOS constraints, including the UISupportedInterfaceOrientations settings in your app's plist.

Set to `false` to follow standard iOS constraints. (Does not affect the manual entry screen.)

#### Scan Instructions

Prop: `scanInstructions`

**Defaults to `null`**

Set the scan instruction text. If `null`, use the default text.
Use newlines as desired to control the wrapping of text onto multiple lines.

#### Scan Expiry

Prop: `scanExpiry`

**Defaults to `true`**

Set to`false` if you don't want the camera to try to scan the card expiration.


#### Scanned Image Duration

Prop: `scannedImageDuration`

**Defaults to 1.0**

After a successful scan, the CardIOView will briefly display an image of the card with the computed card number superimposed. This property controls how long (in seconds) image will be displayed. 

Set this to 0.0 to suppress the display entirely.


---


#### Scan Overlay View

This can be achieved by nesting a `<View />` within the `CardIO` view.

```JSX
<CardIO
  ...props
>
  <View
    style={
      {
        flex: 1,
        backgroundColor: 'rgba(0,255,0,0.2)',
      }
    }
  >
  </View>
</CardIO>
```

---

#### Success Callback

Prop: `onSuccess`

**Defaults to `null`**

A callback for successful card number scan.

#### Failure Callback

Prop: `onFailure`

**Defaults to `null`**

An error callback for a failed card number scan.

