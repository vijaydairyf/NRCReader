//
//  EPToast.h
//  Planning Design Survey System
//
//  Created by flame_thupdi on 13-4-21.
//  Copyright (c) 2013年 flame_thupdi. All rights reserved.
//

#import <UIKit/UIKit.h>
enum TimeType
{
    LongTime,
    ShortTime
};

@interface EPToast : UIView
{
    UILabel* _label;
    NSString * _text;
    enum TimeType _time;
}
+(EPToast *)makeText:(NSString *)text WithError:(BOOL)isError;
+(EPToast *)makeText:(NSString *)text;
-(void)showWithType:(enum TimeType)type;
@end
