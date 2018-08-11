//
//  RGBViewController.m
//  FingerPaint
//
//  Created by Bennett on 2018-08-10.
//  Copyright © 2018 Bennett. All rights reserved.
//

#import "RGBViewController.h"

@interface RGBViewController ()
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UISlider *RSlider;
@property (weak, nonatomic) IBOutlet UISlider *GSlider;
@property (weak, nonatomic) IBOutlet UISlider *BSlider;


@end

@implementation RGBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    self.RSlider.value = [self.color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    self.RSlider.value = red;
    self.GSlider.value = green;
    self.BSlider.value = blue;
    
    [self.colorView setBackgroundColor:self.color];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNewColorFromSlider {
    UIColor *newColor = [UIColor colorWithRed:self.RSlider.value green:self.GSlider.value blue:self.BSlider.value alpha:1.0];
    [self.colorView setBackgroundColor:[UIColor colorWithRed:self.RSlider.value green:self.GSlider.value blue:self.BSlider.value alpha:1.0]];
    self.color = newColor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)RSliderChanged:(UISlider *)sender {
    [self setNewColorFromSlider];
}
- (IBAction)GSliderChanged:(UISlider *)sender {
    [self setNewColorFromSlider];
}

- (IBAction)BSliderChanged:(UISlider *)sender {
    [self setNewColorFromSlider];
}
- (IBAction)dismissDialog:(UIButton *)sender {
    NSDictionary *userInfo = @{@"color" : self.color };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RGBColorChanged" object:self userInfo:userInfo];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
