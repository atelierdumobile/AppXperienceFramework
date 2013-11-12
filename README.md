## Introduction
AppXperience is an **iOS framework** that lets you promote other applications within your app. It is working on iPad, iPhone 3, 4 and 5. The screens are designed in portrait mode.
The SDK has been validated on iOS5 & iOS6.

Four different types of ad units are available:

  - an **interstitial** : full-screen format presenting an app (you can choose between static, dynamic or/and mp4). You decide when you want it to be displayed : when the app is launched,…
  - a **banner** presenting one or many apps. It is displayed whenever you decide.
  - an **app discovery screen** : the Offerwall presenting applications sorted by thematical categories and including a detail mode. It can be used as a modal view or included in a tab bar.
  - an **app discovery detail screen** : the Offerpage presenting one category of applications in a detail mode. It can be used as a modal view or included in a tab bar.

## Demo project
An iOS demo project is available to test the different usages and check the configuration with a default API key. 
**Do make sure that you open the workspace** ("AppXperienceDemo.xcworkspace") and not the project.

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
It is made to be displayed if and only if the user has network and the service is reachable. If something goes wrong then the user won't be bothered with an incomplete screen.

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

### AppXperienceBanner
It is made to be displayed if and only if the user has network and the service is reachable. If something goes wrong the banner view will not be returned. You can position the banner wherever you want in your app, using a setframe.

``` objective-c
       //Do your own loading if need to.
      [[AppXperience sharedManager] prepareBannerWithCompletion:^(UIView *view) {
        // We fetched with success the data, you can do post treatment data.
        // Present the banner when you are ready in our case with an addSubview:
        // It's a view, you are free to put them anywhere. Design on iPhone to be 640x100 and ipad:1536x122.
        [self.view addSubview:view];
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
You can use the pre-fetching of data so that your users won't wait to see the offerwall.

``` objective-c
    // call this in your viewDidLoad or anyplace you want
    [[AppXperience sharedManager] prepareOrRefreshOfferWallDataWithCompletion:^(NSNumber *numberNewApps) {
        //Data are fetched correctly
        //numberNewApps : get the number of new apps since last fetch of data. Use this to notify the user. 
    } error:^(NSError *error) {
         // No network or server unavailable, loading failed
    }];
```

### AppXperienceOfferpage

#### First way: from a tabulation bar

``` objective-c
     UIViewController *appXperienceVC = [[AppXperience sharedManager] offerPageViewControllerFromTabBar];

     //add it to your tabBarViewControllers
     self.tabBarController.viewControllers = @[xxx, appXperienceVC];
```

#### Second way: from modal

``` objective-c
     UIViewController *offerPageViewController = [[AppXperience sharedManager] offerPageViewControllerFromModal];
     [self presentViewController:offerPageViewController animated:YES completion:nil];
```

#### Prefetching of data : 
You can use the pre-fetching of data so that your users won't wait to view the offerwall.

``` objective-c
    // call this in your viewDidLoad or anyplace you want
    [[AppXperience sharedManager] prepareOrRefreshOfferPageDataWithCompletion:^(NSNumber *numberNewApps) {
        //Data are fetched correctly
        //numberNewApps : get the number of new apps since last fetch of data. Use this to notify the user. 
    } error:^(NSError *error) {
         // No network or server unavailable, loading failed
    }];
```

### Debug
To have displayed log you need to have the flag `DEBUG=1` in your Preprocessor Macros in your Build settings

## Installation
### Pod Installation (recommended)

The recommended way of installation is via [CocoaPods](http://cocoapods.org). 
Pods lets you download and integrate Appxperience in your  xCode project in less than 1 minute.  
If you are not using it, you should, **don't waste time manually managing your frameworks** (and not only AppXperience!).

#### 0) Install cocoapods

CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AppXperience in your projects.

CocoaPods is distributed as a ruby gem, and is installed by running the following commands in Terminal.app:

``` bash
$ sudo gem install cocoapods
$ pod setup
```

#### 1) Create or update existing podfile

Create if not existing a "Podfile" file. The "Podfile" is at the same level as your *.xcodeproj.
Then add the dependency with AppXperience like shown below (you can remove the version argument to always have the latest version of the fmk).

``` ruby
platform :ios, '5.0'
pod 'AppXperience', '~> 1.9.5'
```

#### 2) Install Dependencies

Now you can install the dependencies in your project:

``` bash
$ pod install
```

From now on, make sure to always open the generated Xcode workspace (.xcworkspace) and not the project file when building your project.

####3) Dive In!

At this point, everything is ready for you to start using AppXperience. Just #import the headers for the classes you need and get to it!

_These are classic steps with cocoapods, you'll become familiar with them very easily but it is worth spending a minute reading the instructions: [http://cocoapods.org](http://cocoapods.org)._


### Manual Installation
Because the manual installation makes integration more complicated and more complex to manage upgrades of frameworks we recommend you to use the "Pod Installation". If you have a good reason not using it, here are the steps:

- Add `AppXperience.framework` and `AppXperience.bundle` to your project.
- In `Build Phases`, make sure its listed in `Link Binary With Libraries`, along with:
  - `QuartzCore.framework`
  - `CoreGraphics.framework`
  - `MediaPlayer.framework`
  - `CoreText.framework`
  - `ImageIO.framework` (SDWebImage)
  - `CFNetwork.framework` (MKNetworking)
  - `Security.framework` (MKNetworking)
  - `Foundation.framework` (should be already there)
  - `UIKit.framework` (should be already there)
  
- In `Build Settings`:
  - Under `Framework Search Paths` make sure the (parent) directory to `AppXperience.framework` is listed.
  - Under `Other Linker Flags` in your target, add `-ObjC` and `-all_load`

#### Dependencies:

You just need to import the files coming from the two following projects:

 - [SDWebImage](https://github.com/rs/SDWebImage#installation) ~> 3.1 (Powerful image caching fmk - use ARC)
 
   Just [download](https://github.com/rs/SDWebImage/releases) the release and drag the "SDWebImage.framework" to your project.
   
   
 - [MKNetworkKit](https://github.com/MugunthKumar/MKNetworkKit) ~> 0.85 (Powerful network and caching  fmk - use ARC)

   The official installation procedure is only supporting pods, so here are the steps:
   - [Download](https://github.com/MugunthKumar/MKNetworkKit/releases/) the release
   - Import in your project the **MKNetworkKit/MKNetworkKit/** folder containing all the headers and sources.
  

## Code documentation
Do have a look at the AppXperience.h's headers which are documented and self-explanatory.