//
//  ViewController.m
//  DicSample
//
//  Created by 大庭 慎一郎 on 12/01/14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface UIWebView (reference)
- (void)loadReferenceHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;
@end

@implementation UIWebView (reference)
- (void)loadReferenceHTMLString:(NSString *)string baseURL:(NSURL *)baseURL
{
    NSLog(@"loadReferenceHTMLString:%@ baseURL:%@", string, baseURL);
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:string, @"html", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadReferenceHTMLString" object:self userInfo:userInfo];
    
    //[self loadReferenceHTMLString:string baseURL:baseURL];
}
@end


@implementation ViewController
@synthesize referenceLibraryViewController;
@synthesize searchBar;
@synthesize webView;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        Class class = [UIWebView class];
        Method originalMethod = class_getInstanceMethod(class, @selector(loadHTMLString:baseURL:));
        Method newMethod = class_getInstanceMethod(class, @selector(loadReferenceHTMLString:baseURL:));
        method_exchangeImplementations(originalMethod, newMethod);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadReferenceHTMLString:) name:@"loadReferenceHTMLString" object:nil];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([UIReferenceLibraryViewController dictionaryHasDefinitionForTerm:searchText]) {
        self.referenceLibraryViewController = [[UIReferenceLibraryViewController alloc] initWithTerm:searchText];
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"", @"html", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadReferenceHTMLString" object:self userInfo:userInfo];
    }
}

#pragma mark - Notification

- (void)loadReferenceHTMLString:(NSNotification *)notification
{
    NSString *html = [notification.userInfo objectForKey:@"html"];
    [self.webView loadReferenceHTMLString:html baseURL:nil];
}

@end
