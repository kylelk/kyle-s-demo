//
//  ViewController.m
//  kyle's demo
//
//  Created by Kyle on 1/5/14.
//  Copyright (c) 2014 Kyle kersey. All rights reserved.
//

#import "ViewController.h"
#include <CommonCrypto/CommonDigest.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize output;
@synthesize input;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [input addTarget:self action:@selector(updateLabelUsingContentsOfTextField:) forControlEvents:UIControlEventEditingChanged];
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    if (theTextField == self.input) {
        
        [theTextField resignFirstResponder];
        
    }
    
    return YES;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)calculateSHA:(NSString *)yourString
{
    const char *ptr = [yourString UTF8String];
    
    int i =0;
    int len = strlen(ptr);
    Byte byteArray[len];
    while (i!=len)
    {
        unsigned eachChar = *(ptr + i);
        unsigned low8Bits = eachChar & 0xFF;
        
        byteArray[i] = low8Bits;
        i++;
    }
    
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(byteArray, len, digest);
    
    NSMutableString *hex = [NSMutableString string];
    for (int i=0; i<20; i++)
        [hex appendFormat:@"%02x", digest[i]];
    
    NSString *immutableHex = [NSString stringWithString:hex];
    
    return immutableHex;
}

- (void)updateLabelUsingContentsOfTextField:(id)sender {
    NSString *data = [NSString stringWithFormat:@"%@", ((UITextField *)sender).text];
    
    [output setText:[self calculateSHA:data]];
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    NSSet *touchedViews = [touches valueForKeyPath:@"view"];
    if ([touchedViews containsObject:self.output]) {
        // do something
        NSString *TheHash = [self calculateSHA:input.text];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = TheHash;
    }
}


@end
