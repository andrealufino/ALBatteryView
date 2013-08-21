//
//  ALBatteryView.m
//  ALBattery
//
//  Created by Andrea Mario Lufino on 06/08/13.
//  Copyright (c) 2013 Andrea Mario Lufino. All rights reserved.
//

#import "ALBatteryView.h"

@implementation UIDevice (Battery)

- (CGFloat)batteryLevelInPercentage {
    self.batteryMonitoringEnabled = YES;
    return self.batteryLevel * 100;
}

@end

/*! The max width of the view */
#define kMaxWidth 128

/*! The x coordinate of the fill view */
#define kBatteryFillX 11 * self.width / kMaxWidth
/*! The y coordinate of the fill view */
#define kBatteryFillY (self.width / 2) - ((self.height * kBatteryFillMaxHeight / kMaxWidth) / 2)
/*! The height of the fill view */
#define kBatteryFillHeight self.height * kBatteryFillMaxHeight / kMaxWidth
/*! The width of the fill view */
#define kBatteryFillWidth self.width * kBatteryFillMaxWidth / kMaxWidth
/*! The max width of the fill view */
#define kBatteryFillMaxWidth 104.0f
/*! The max height of the fill view */
#define kBatteryFillMaxHeight 58

/*! The max corner radius of the fill view */
#define kMaxCornerRadius 8
/*! The corner radius of the fill view, calculated basing on the max value */
#define kCornerRadius kMaxCornerRadius * self.width / kMaxWidth

/*! The value of one percent of battery fill, calculated basing on the view width */
#define kOnePercent kBatteryFillWidth / 100

@implementation ALBatteryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // If the width and height values are bigger than 128
        // then set these values to 128 (max size of the image)
        if (frame.size.width > 128 || frame.size.height > 128) {
            self.width = kMaxWidth;
            self.height = kMaxWidth;
        }
        // If the view isn't a square raise an exception
        if (self.width != self.height)
            [NSException raise:@"ALBatteryView frame error" format:@"The width and the height values have to be the same"];
        // Create the image view containing the battery image and
        // add it to the view
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"battery.png"]];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setFrame:CGRectMake(0, 0, self.width, self.height)];
        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        [self addSubview:imageView];
        // Create the view which will fill the battery
        batteryFill = [[UIView alloc] init];
        [batteryFill setFrame:CGRectMake(kBatteryFillX, kBatteryFillY, 20, kBatteryFillHeight)];
        [batteryFill setBackgroundColor:[UIColor greenColor]];
        [[batteryFill layer] setCornerRadius:kCornerRadius];
        // Insert the fill view (batteryFill) as first subview,
        // so the battery image will not be covered
        [self insertSubview:batteryFill atIndex:0];
    }
    return self;
}

#pragma mark - Battery level set

- (void)setBatteryLevelWithAnimation:(BOOL)isAnimated forValue:(CGFloat)batteryLevel inPercent:(BOOL)inPercent {
    // Declare the newWidth and save the correct battery level
    // based on inPercent value
    CGFloat newWidth;
    CGFloat newBatteryLevel = (inPercent) ? batteryLevel : batteryLevel * 100;
    // Set the new width
    newWidth = kOnePercent * newBatteryLevel;
    // If animated proceed with the animation
    // else assign the value without animates
    if (isAnimated)
        [UIView animateWithDuration:2.0 animations:^{
            /* This direct assignment is possible
             * using the UIView+ALQuickFrame category
             * http://github.com/andrealufino/ALQuickFrame */
            batteryFill.width = newWidth;
            // Set the color based on battery level
            batteryFill.backgroundColor = [self setColorBasedOnBatteryLevel:newBatteryLevel];
        }];
    else
        batteryFill.width = newWidth;
}

- (void)reload {
    // Reset the width of the fill view
    batteryFill.width = 0.0f;
    // Set the fill of the view to redo the animation
    [self setBatteryLevelWithAnimation:YES forValue:[UIDevice currentDevice].batteryLevelInPercentage inPercent:YES];
}

#pragma mark - Private method

// Returns an UIColor object based on the passed battery level
- (UIColor *)setColorBasedOnBatteryLevel:(CGFloat)batteryLevel {
    UIColor *backgroundColor;
    if (batteryLevel <= 20)
        backgroundColor = [UIColor redColor];
    if (batteryLevel > 20 && batteryLevel <= 30)
        backgroundColor = [UIColor orangeColor];
    if (batteryLevel > 30)
        backgroundColor = [UIColor greenColor];
    return backgroundColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
