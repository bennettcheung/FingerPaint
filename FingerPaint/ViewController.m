//
//  ViewController.m
//  FingerPaint
//
//  Created by Bennett on 2018-08-10.
//  Copyright © 2018 Bennett. All rights reserved.
//

#import "ViewController.h"
#import "LineSegmentDataModel.h"
#import "DrawingView.h"
#import "RGBViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet DrawingView *drawingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeColorOnDrawView:) name:@"RGBColorChanged" object:nil];

}

-(void)changeColorOnDrawView:(NSNotification *)notification{
    NSDictionary* userInfo = notification.userInfo;
    self.drawingView.color = (UIColor*)userInfo[@"color"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showColorDialog"])
    {
        RGBViewController *rgbViewController = [segue destinationViewController];
        rgbViewController.color = self.drawingView.color;
    }
    
}
- (IBAction)clearDrawing:(UIButton *)sender {
    [self.drawingView clearDrawings];
}
- (IBAction)changeToEraseMode:(UIButton *)sender {
    self.drawingView.drawingMode = NO;
}
- (IBAction)changeToLineMode:(UIButton *)sender {
    self.drawingView.drawingMode = YES;
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:@"RGBColorChanged"];
    
}
@end
