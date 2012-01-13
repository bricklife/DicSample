//
//  ViewController.h
//  DicSample
//
//  Created by 大庭 慎一郎 on 12/01/14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UISearchBarDelegate>

@property (strong, nonatomic) UIReferenceLibraryViewController *referenceLibraryViewController;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
