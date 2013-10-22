## Introduction
AppXperience is an **iOS framework** to promote other applications inside your app. It is working for iPad, iPhone3.5"&4". The screens are designed in portrait mode.
The SDK has been validated on iOS5 & iOS6.

Four distincts components are available:
  - an **interstitial** that present an app. It can be launched when the app start or anytime you want. 
  - a **banner** that present one or many app. It can be launched anytime you want.
  - an **app discovery screen** that will present applications grouped by categories with a detail mode. This can be used as a modal view or include it in a tabbar.
  - an **app discovery detail screen** that will present one application's categories in a detail mode. This can be used as a modal view or include it in a tabbar.

## Demo project
An iOS demo project is available to test the different usages and check the configuration with a default API key. 
**Takes care to open the workspace** ("AppXperienceDemo.xcworkspace") and not the project.

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

### AppXperienceBanner
It is made to display something only if the user has network and the service is reachable. If something goes wrong banner view not return.

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
You can use the pre-fetching of data so your users won't wait to display the offerwall.

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
### Pod Installation (recommanded)

The recommanded way of installation is via [CocoaPods](http://cocoapods.org). 
Pods takes care of downloading and integrating in your xCode project AppXperience in less than 1 minute.  
If you are not using it, you should, **don't waste time managing manually your frameworks** (not only AppXperience).

#### 0) Install cocoapods

CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFNetworking in your projects.

CocoaPods is distributed as a ruby gem, and is installed by running the following commands in Terminal.app:

``` bash
$ sudo gem install cocoapods
$ pod setup
```

#### 1) Create or update existing podfile

Create if not existing a "Podfile" file. The "Podfile" is at the same level as your *.xcodeproj.
Then add the dependancy with AppXperience like following (you can remove the version argument to always have the latest version of the fmk).

``` ruby
platform :ios, '5.0'
pod 'AppXperience', '~> 1.9.5'
```

#### 2) Install Dependencies

Now you can install the dependencies in your project:

``` bash
$ pod install
```

From now on, be sure to always open the generated Xcode workspace (.xcworkspace) instead of the project file when building your project.

####3) Dive In!

At this point, everything's in place for you to start using AppXperience. Just #import the headers for the classes you need and get to it!

_Theses are classic steps with cocoapods, you'll become familiar very easily with it but it is worth spending a minute reading the instructions: [http://cocoapods.org](http://cocoapods.org)._


### Manual Installation
Because the manual installation make integration more complicated and complexe for managing upgrade of frameworks we recommand you to use the "Pod Installation". If you have a good reason not using it, here are the steps:

- Add `AppXperience.framework` and `AppXperience.bundle` to your project.
- In `Build Phases`, make sure its listed in `Link Binary With Libraries`, along with:
  - `QuartzCore.framework`
  - `CoreGraphics.framework`
  - `MediaPlayer.framework`
  - `CoreText.framework`
  - `ImageIO.framework`
  - `Foundation.framework` (should be already there)
  - `UIKit.framework` (should be already there)
  
- In `Build Settings`:
  - Under `Framework Search Paths` make sure the (parent) directory to `AppXperience.framework` is listed.
  - Under `Other Linker Flags` in your target, add `-ObjC` and `-all_load`

#### Dependencies:

You just need to import the files coming from the two following projects:

 - [SDWebImage](https://github.com/rs/SDWebImage#installation) ~> 3.1 (Powerfull image caching fmk - use ARC)
 
   Just [download](https://github.com/rs/SDWebImage/releases) the release and drag the "SDWebImage.framework" to your project.
   
   
 - [MKNetworkKit](https://github.com/MugunthKumar/MKNetworkKit) ~> 0.85 (Powerfull network and caching  fmk - use ARC)

   The official installation procedure is only supporting pods, so here are the steps:
   - [Download](https://github.com/MugunthKumar/MKNetworkKit/releases/) the release
   - Import in your project the **MKNetworkKit/MKNetworkKit/** folder containing all the headers and sources.
  

## Code documentation
Have a look at the AppXperience.h's headers which are documented and self explanatory.