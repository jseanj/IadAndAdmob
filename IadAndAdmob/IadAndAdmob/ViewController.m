//
//  ViewController.m
//  IadAndAdmob
//
//  Created by jins on 14-4-11.
//  Copyright (c) 2014年 BlackWater. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initiAdBanner];
    [self initgAdBanner];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)initiAdBanner
{
    if (!self.iAdBannerView) {
        //CGRect rect = CGRectMake(0, self.view.frame.size.height, 0, 0);
        self.iAdBannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
        self.iAdBannerView.frame = CGRectOffset(self.iAdBannerView.frame, 0, -50);
        self.iAdBannerView.delegate = self;
        self.iAdBannerView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierLandscape];
        self.iAdBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
        self.iAdBannerView.hidden = YES;
        [self.view addSubview:self.iAdBannerView];
    }
}

- (void)initgAdBanner
{
    if (!self.gAdBannerView) {
        self.gAdBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerLandscape];
        self.gAdBannerView.translatesAutoresizingMaskIntoConstraints = NO;
        self.gAdBannerView.adUnitID = @"a153466fdba92fc";
        self.gAdBannerView.delegate = self;
        self.gAdBannerView.rootViewController = self;
        self.gAdBannerView.hidden = YES;
        [self.view addSubview:self.gAdBannerView];
    }
}

-(void)hideBanner:(UIView*)banner
{
    //如果有banner，并且正在显示，那么将该banner移走
    if (banner && ![banner isHidden])
    {
        [UIView beginAnimations:@"hideBanner" context:nil];
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        banner.hidden = YES;
    }
}

-(void)showBanner:(UIView*)banner
{
    //如果有banner，并且没有显示，那么就将该banner显示出来
    if (banner && [banner isHidden])
    {
        [UIView beginAnimations:@"showBanner" context:nil];
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        banner.hidden = FALSE;
    }
}

// Called before the add is shown, time to move the view
- (void)bannerViewWillLoadAd:(ADBannerView *)banner
{
    NSLog(@"iAd load");
    [self hideBanner:self.gAdBannerView];
    [self showBanner:self.iAdBannerView];
}

// Called when an error occured
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"iAd error: %@", error);
    [self hideBanner:self.iAdBannerView];
    [self.gAdBannerView loadRequest:[GADRequest request]];
}

// Called before ad is shown, good time to show the add
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"Admob load");
    [self hideBanner:self.iAdBannerView];
    [self showBanner:self.gAdBannerView];
}

// An error occured
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"Admob error: %@", error);
    [self hideBanner:self.gAdBannerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
