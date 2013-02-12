## Pod Installation

The preferred way of installation is via [CocoaPods](http://cocoapods.org). Just add

``` ruby
pod 'AppXperience'
```
and run `pod install`. It will install the most recent version of AppXperience.

If you would like to use the latest code of AppXperience use:

``` ruby
pod 'AppXperience', :head
```
#### Add font support
You need to edit the plist to support a custom font. Add an entry with key:`UIAppFonts` (or `Fonts provided by application` if you are not using the raw key) and set as `itemx` value:`AppXperience.bundle/Passing Notes.ttf`.

## Normal Installation
- Add `AppXperience.framework` to your project.
- In `Build Phases`, make sure its listed in `Link Binary With Libraries`, along with:
  - `QuartzCore.framework`
  - `UIKit.framework`
  - `CoreGraphics.framework`
  - `Foundation.framework`
- In `Build Settings`:
  - Under `Framework Search Paths` make sure the (parent) directory to `AppXperience.framework` is listed.
  - Under `Other Linker Flags` in your target, add `-ObjC` and `-all_load`

#### Dependencies:

You just need to import the files coming from the following projects:
 - MKNetworkKit ~> 0.85
   [here](https://github.com/MugunthKumar/MKNetworkKit)

 - SDWebImage ~> 3.1
   [here](https://github.com/rs/SDWebImage)

#### Add font support
You need to edit the plist to support a custom font. Add an entry with key:`UIAppFonts` (or `Fonts provided by application` if you are not using the raw key) and set as `itemx` value:`AppXperience.bundle/Passing Notes.ttf`.

## Usage

- Import the header in your .h:
``` objective-c
#import <AppXperience/AppXperience.h>
```

- Call the singleton to set your developer key:
``` objective-c

	[[AppXperience sharedManager] setDeveloperKey:@"ABCDEF"];
```

####Recover AppXperienceInterstitiel and show it:

``` objective-c
       [[AppXperience sharedManager] prepareInterstitialWithCompletion:^(UIViewController *interstitialViewController) {
              [self presentViewController:interstitialViewController animated:YES completion:nil];
       } error:^(NSError *error) {
       }];
```

####Recover AppXperienceOfferwall and show it:

- First way: From a tabulation bar

``` objective-c
     [[AppXperience sharedManager] offerWallViewControllerFromTabBar];
```

- Second way: From modal

``` objective-c
     UIViewController *offerWallViewController = [[AppXperience sharedManager] offerWallViewControllerFromModal];
     [self presentViewController:offerWallViewController animated:YES completion:nil];
```

## Debug
No logs are displayed by default except errors.
To have more informations about what is going on, define `kAXlogOn` to 1
``` objective-c
	#define kAXlogOn 1	// activate debug logs. Disabled by default
```

## Demo project
A demo project is available to test and check the configuration.