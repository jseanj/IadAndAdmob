//
//  ViewController.h
//  IadAndAdmob
//
//  Created by jins on 14-4-11.
//  Copyright (c) 2014年 BlackWater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "GADBannerView.h"

@interface ViewController : UIViewController <ADBannerViewDelegate, GADBannerViewDelegate>
@property (nonatomic, strong) ADBannerView *iAdBannerView;
@property (nonatomic, strong) GADBannerView *gAdBannerView;
@end
