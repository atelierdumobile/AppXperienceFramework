## Introduction
AppXperience is an **iOS framework** to promote other applications inside your app. It is working starting iOS5 and support the iPhone 5 resolution. 

Two distincts components are available:
  - an **interstitial** that present an app. It can be launched when the app start or anytime you want. 
  - an **app discovery screen** that will present applications grouped by categories with a detail mode. This can be used as a modal view or include it in a tabbar.

## Demo project
An iOS demo project is available to test the different usages and check the configuration with a default API key.

## Usage

- Import the header in your .h:
``` objective-c
#import <AppXperience/AppXperience.h>
```

- Call the singleton to set your developer key:
``` objective-c
        //Set your own key if you have it
	[[AppXperience sharedManager] setDeveloperKey:@"ABCDEF"];
```

### AppXperienceInterstitial
It is made to display something only if the user has network and the service is reachable. If something goes wrong then won't bother the user with incomplet screen.

``` objective-c
       //Do your own loading if need to.
       [[AppXperience sharedManager] prepareInterstitialWithCompletion:^(UIViewController *interstitialViewController) {
              // We fetched with success the data, you can do post treatment data.
              // Present the interstitial when you are ready in our case with a presentViewController:
              [self presentViewController:interstitialViewController animated:YES completion:nil];
       } error:^(NSError *error) {
           // No network or server unavailable, we do not display the ad
       }];
```

### AppXperienceOfferwall

#### First way: from a tabulation bar

``` objective-c
     UIViewController *appXperienceVC = [[AppXperience sharedManager] offerWallViewControllerFromTabBar];

     //add it to your tabBarViewControllers
     self.tabBarController.viewControllers = @[xxx, appXperienceVC];
```

#### Second way: from modal

``` objective-c
     UIViewController *offerWallViewController = [[AppXperience sharedManager] offerWallViewControllerFromModal];
     [self presentViewController:offerWallViewController animated:YES completion:nil];
```

#### Prefetching of data : 
You can use the pre-fetching of data so your users won't wait to display the offerwall.

``` objective-c
    // call this in your viewDidLoad or anyplace you want
    [[AppXperience sharedManager] prepareOrRefreshOfferWallDataWithCompletion:^(NSNumber *numberNewApps) {
        //Data are fetched correctly
        //numberNewApps : get the number of new apps since last fetch of data. Use this to notify the user. 
    } error:^(NSError *error) {
         // No network or server unavailable, loading failed
    }];
```
#### Debug
No logs are displayed by default except errors.
To have more informations about what is going on, define `kAXlogOn` to 1
``` objective-c
	#define kAXlogOn 1	// activate debug logs. False by default
```

## Installation
### Pod Installation

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
You need to edit the plist to support a custom font. Add an entry with key:`UIAppFonts` (or `Fonts provided by application` if you are not using the raw key) and set as `itemx` value:`AppXperience.bundle/Passing Notes.ttf`. That's all.

### Normal Installation
- Add `AppXperience.framework` and `AppXperience.bundle` to your project.
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
You need to edit the plist to support a custom font. Add an entry with key:`UIAppFonts` (or `Fonts provided by application` if you are not using the raw key) and set as `itemx` value:`AppXperience.bundle/Passing Notes.ttf`. That's all.

## Code documentation
The framework's headers are documented and self explanatory.