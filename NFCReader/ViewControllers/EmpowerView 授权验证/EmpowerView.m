//
//  EmpowerView.m
//  NFCReader
//
//  Created by 李黎明 on 2019/9/4.
//  Copyright © 2019 李黎明. All rights reserved.
//

#import "EmpowerView.h"

@implementation EmpowerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)OKAction:(id)sender {
    [EPSound playWithSoundName:@"click_sound"];
    if ([[self.accountNameTF.text NullToBlankString]length]==0) {
        [[EPToast makeText:@"请输入账户名" WithError:YES]showWithType:ShortTime];
        //响警告声音
        [EPSound playWithSoundName:@"wram_sound"];
        return;
    }
    if ([[self.passwordTF.text NullToBlankString]length]==0) {
        [[EPToast makeText:@"请输入密码" WithError:YES]showWithType:ShortTime];
        //响警告声音
        [EPSound playWithSoundName:@"wram_sound"];
        return;
    }
    if (_sureActionBlock) {
        _sureActionBlock(self.accountNameTF.text,self.passwordTF.text);
    }
    [self removeFromSuperview];
    [self clearAccountInfo];
}
- (void)clearAccountInfo{
    self.accountNameTF.text = @"";
    self.passwordTF.text = @"";
}
- (IBAction)closeAction:(id)sender {
    [EPSound playWithSoundName:@"click_sound"];
    [self removeFromSuperview];
    [self clearAccountInfo];
}

@end
