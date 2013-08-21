//
//  ALBatteryView.h
//  ALBattery
//
//  Created by Andrea Mario Lufino on 06/08/13.
//  Copyright (c) 2013 Andrea Mario Lufino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIView+ALQuickFrame.h"

/*!
 * This class uses the UIView+ALQuickFrame category
 * available here : http://github.com/andrealufino/ALQuickFrame
 */

/*! 
 * Category for UIDevice to get quickly the battery level in percentage
 */
@interface UIDevice (Battery)

/*!
 The battery level in percentage
 @return CGFloat represents the battery level in percentage
 */
- (CGFloat)batteryLevelInPercentage;

@end

/*!
 * This class shows a battery using the battery.png image in the bundle.
 * The battery image can be filled with the current battery level of the
 * device simply calling the setBatteryLevelWithAnimation:forValue:inPercent method
 */
@interface ALBatteryView : UIView {
    /*! The view that fill the battery */
    UIView *batteryFill;
}

/*!
 Fill the battery with the passed battery level
 @param isAnimated If yes there will be an animation when the battery is filled
 @param batteryLevel The battery level to show in the view
 @param inPercent If the battery level passed is in percent or not
 */
- (void)setBatteryLevelWithAnimation:(BOOL)isAnimated forValue:(CGFloat)batteryLevel inPercent:(BOOL)inPercent;

/*!
 Reload the animation which fill the battery view with the current battery level
 */
- (void)reload;

@end
