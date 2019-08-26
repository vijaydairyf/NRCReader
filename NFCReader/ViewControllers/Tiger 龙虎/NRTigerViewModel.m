//
//  NRTigerViewModel.m
//  NFCReader
//
//  Created by 李黎明 on 2019/5/6.
//  Copyright © 2019 李黎明. All rights reserved.
//

#import "NRTigerViewModel.h"
#import "NRLoginInfo.h"
#import "NRTableInfo.h"
#import "NRGameInfo.h"
#import "NRUpdateInfo.h"
#import "JhPageItemModel.h"

@implementation NRTigerViewModel

- (instancetype)initWithLoginInfo:(NRLoginInfo *)loginInfo WithTableInfo:(NRTableInfo*)tableInfo WithNRGameInfo:(NRGameInfo *)gameInfo{
    self = [super init];
    self.loginInfo = loginInfo;
    self.curTableInfo = tableInfo;
    self.gameInfo = gameInfo;
    self.curupdateInfo = [NRUpdateInfo new];
    self.cp_fidString = @"";
    self.cp_tableIDString = @"";
    return self;
}

#pragma mark - 换桌
- (void)otherTableWithBlock:(EPFeedbackWithErrorCodeBlock)block{
    NSDictionary * param = @{
                             @"access_token":self.loginInfo.access_token,
                             @"fid":self.curTableInfo.fid//桌子ID
                             };
    NSArray *paramList = @[param];
    NSDictionary * Realparam = @{
                                 @"f":@"Table_hbhz",
                                 @"p":[paramList JSONString]
                                 };
    [EPService nr_PublicWithParamter:Realparam block:^(NSDictionary *responseDict, NSString *msg, EPSreviceError error, BOOL suc) {
        block(suc, msg,error);
        
    }];
}

#pragma mark - 提交客人输赢记录和台桌流水记录
- (void)commitCustomerRecordWithBlock:(EPFeedbackWithErrorCodeBlock)block{
    NSArray *dashuiList = [NSArray array];
    NSArray *chipList = [NSArray array];
    NSArray *zhaohuiList = [NSArray array];
    if (self.curupdateInfo.cp_ChipUidList.count!=0) {
        chipList = self.curupdateInfo.cp_ChipUidList;
    }
    if (self.curupdateInfo.cp_zhaohuiList.count!=0) {
        zhaohuiList = self.curupdateInfo.cp_zhaohuiList;
    }
    NSDictionary * param = @{
                             @"access_token":self.loginInfo.access_token,
                             @"ftbrec_id":self.cp_tableIDString,//桌子ID
                             @"fpcls":self.curupdateInfo.cp_Serialnumber,//铺次流水号，长度不超过20位，要求全局唯一
                             @"fxmh":self.curupdateInfo.cp_washNumber,//客人洗码号
                             @"fxz_cmtype":self.curupdateInfo.cp_chipType,//客人下注的筹码类型
                             @"fxz_money":self.curupdateInfo.cp_benjin,//客人下注的本金
                             @"fxz_name":self.curupdateInfo.cp_name,//下注名称，如庄、闲、庄对子…
                             @"fbeishu":self.curupdateInfo.cp_beishu,//倍数，如果杀注50%填0.5
                             @"fdianshu":self.curupdateInfo.cp_dianshu,//牛牛点数，非牛牛游戏传0
                             @"fsy":self.curupdateInfo.cp_result,//判断客人的输赢：1为赢，-1为输，0为不杀不赔
                             @"fresult":self.curupdateInfo.cp_money,//应付额
                             @"fzhaohui":zhaohuiList,//找回z筹码
                             @"fyj":self.curupdateInfo.cp_commission,//佣金
                             @"fhardlist":chipList,//实付筹码，硬件ID值数组
                             @"fdashui":dashuiList//打水筹码，硬件ID值数组
                             };
    NSArray *paramList = @[param];
    NSDictionary * Realparam = @{
                                 @"f":@"Tablerec_szpf",
                                 @"p":[paramList JSONString]
                                 };
    [EPService nr_String_PublicWithParamter:Realparam block:^(NSString *responseString, NSString *msg, EPSreviceError error, BOOL suc) {
        if (suc) {
            self.cp_fidString = responseString;
        }
        block(suc, msg,error);
        
    }];
}

#pragma mark - 提交开牌结果
- (void)commitkpResultWithBlock:(EPFeedbackWithErrorCodeBlock)block{
    NSDictionary * param = @{
                             @"access_token":self.loginInfo.access_token,
                             @"ftable_id":self.curTableInfo.fid,//桌子ID
                             @"fxueci":self.curupdateInfo.cp_xueci,//靴次
                             @"fpuci":self.curupdateInfo.cp_puci,//铺次
                             @"fpcls":[self.curupdateInfo.cp_Serialnumber NullToBlankString],//铺次流水号，长度不超过20位，要求全局唯一
                             @"fkpresult":[self.curupdateInfo.cp_name NullToBlankString],//结果
                             @"frjdate":[NRCommand getCurrentDate]//铺次
                             };
    NSArray *paramList = @[param];
    NSDictionary * Realparam = @{
                                 @"f":@"Tablerec_kpResult",
                                 @"p":[paramList JSONString]
                                 };
    [EPService nr_String_PublicWithParamter:Realparam block:^(NSString *responseString, NSString *msg, EPSreviceError error, BOOL suc) {
        if (suc) {
            self.cp_tableIDString = responseString;
        }
        block(suc, msg,error);
    }];
}

#pragma mark - 检测筹码是否正确
- (void)checkChipIsTrueWithChipList:(NSArray *)chipList Block:(EPFeedbackWithErrorCodeBlock)block{
    NSDictionary * param = @{
                             @"access_token":self.loginInfo.access_token,
                             @"fhardlist":chipList
                             };
    NSArray *paramList = @[param];
    NSDictionary * Realparam = @{
                                 @"f":@"Table_cmReadAmount",
                                 @"p":[paramList JSONString]
                                 };
    [EPService nr_PublicWithParamter:Realparam block:^(NSDictionary *responseDict, NSString *msg, EPSreviceError error, BOOL suc) {
        block(suc, msg,error);
        
    }];
}

#pragma mark - 提交小费
- (void)commitTipResultWithBlock:(EPFeedbackWithErrorCodeBlock)block{
    NSArray *chipList = [NSArray array];
    if (self.curupdateInfo.cp_xiaofeiList.count!=0) {
        chipList = self.curupdateInfo.cp_xiaofeiList;
    }
    NSDictionary * param = @{
                             @"access_token":self.loginInfo.access_token,
                             @"fhardlist":chipList,//实付筹码，硬件ID值数组
                             @"fid":[self.cp_fidString NullToBlankString]//结果
                             };
    NSArray *paramList = @[param];
    NSDictionary * Realparam = @{
                                 @"f":@"Tablerec_xf",
                                 @"p":[paramList JSONString]
                                 };
    [EPService nr_PublicWithParamter:Realparam block:^(NSDictionary *responseDict, NSString *msg, EPSreviceError error, BOOL suc) {
        block(suc, msg,error);
        if (suc) {
            self.cp_fidString = @"";
        }
    }];
}

#pragma mark - 获取露珠
- (void)getLuzhuWithBlock:(EPFeedbackWithErrorCodeBlock)block{
    NSArray *chipList = [NSArray array];
    if (self.curupdateInfo.cp_xiaofeiList.count!=0) {
        chipList = self.curupdateInfo.cp_xiaofeiList;
    }
    NSDictionary * param = @{
                             @"access_token":self.loginInfo.access_token,
                             @"ftable_id":self.curTableInfo.fid,//桌子ID
                             @"rjdate":[NRCommand getCurrentDate],//日期
                             @"fxueci":self.curupdateInfo.cp_xueci//靴次
                             };
    NSArray *paramList = @[param];
    NSDictionary * Realparam = @{
                                 @"f":@"tablerec_luzhu",
                                 @"p":[paramList JSONString]
                                 };
    [EPService nr_Public_ListWithParamter:Realparam block:^(NSArray *list, NSString *msg, EPSreviceError error, BOOL suc) {
        if (suc) {
            NSMutableArray *luzhuList = [NSMutableArray array];
            NSMutableArray *luzhuDownList = [NSMutableArray array];
            [list enumerateObjectsUsingBlock:^(NSDictionary *luzhiDict, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *resultS =  luzhiDict[@"fkpresult"];
                NSString *text = @"";
                NSString *img = @"";
                if ([resultS isEqualToString:@"龙赢"]) {
                    img = @"1";
                    text = @"龙";
                    JhPageItemModel *model = [[JhPageItemModel alloc]init];
                    model.img = img;
                    model.text = text;
                    model.colorString = @"#ffffff";
                    model.luzhuType = 1;
                    [luzhuList addObject:model];
                    [luzhuDownList addObject:model];
                }else if ([resultS isEqualToString:@"虎赢"]){
                    img = @"7";
                    text = @"虎";
                    JhPageItemModel *model = [[JhPageItemModel alloc]init];
                    model.img = img;
                    model.text = text;
                    model.colorString = @"#ffffff";
                    model.luzhuType = 1;
                    [luzhuList addObject:model];
                    [luzhuDownList addObject:model];
                }else if ([resultS isEqualToString:@"和局"]){
                    img = @"0";
                    text = @"和";
                    JhPageItemModel *model = [[JhPageItemModel alloc]init];
                    model.img = img;
                    model.text = text;
                    model.luzhuType = 1;
                    model.colorString = @"#ffffff";
                    [luzhuList addObject:model];
                    [luzhuDownList addObject:model];
                }
            }];
            for (int i=(int)list.count; i<100; i++) {
                NSString *text = @"";
                NSString *img = @"";
                JhPageItemModel *model = [[JhPageItemModel alloc]init];
                model.img = img;
                model.text = text;
                model.luzhuType = 0;
                model.colorString = @"#ffffff";
                [luzhuList addObject:model];
            }
            self.luzhuUpList = luzhuList;
            
            NSMutableArray *realListArray = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *realDownListArray = [NSMutableArray arrayWithCapacity:0];
            if (luzhuDownList.count==1) {
                JhPageItemModel *model = luzhuDownList[0];
                JhPageItemModel *realmodel = [[JhPageItemModel alloc]init];
                realmodel.text = model.text;
                if ([model.text isEqualToString:@"龙"]) {
                    realmodel.img = @"9";
                    realmodel.colorString = @"#ec3223";
                }else if ([model.text isEqualToString:@"虎"]){
                    realmodel.img = @"13";
                    realmodel.colorString = @"#362bf5";
                }else if ([model.text isEqualToString:@"和"]){
                    realmodel.img = @"18";
                    realmodel.colorString = @"#ffffff";
                }
                [realListArray addObject:realmodel];
            }else{
                NSMutableArray *zhuangListArray = [NSMutableArray arrayWithCapacity:0];
                NSMutableArray *xianListArray = [NSMutableArray arrayWithCapacity:0];
//                NSMutableArray *heListArray = [NSMutableArray arrayWithCapacity:0];
                for (int i=0; i<luzhuDownList.count; i++) {
                    if (i+1<luzhuDownList.count) {
                        JhPageItemModel *model1 = luzhuDownList[i];
                        JhPageItemModel *model2 = luzhuDownList[i+1];
                        JhPageItemModel *model = [[JhPageItemModel alloc]init];
                        if ([model1.text isEqualToString:@"龙"]) {
                            model.img = @"9";
                            model.text = model1.text;
                            model.colorString = @"#ec3223";
                            [zhuangListArray addObject:model];
                            if (![model2.text isEqualToString:@"龙"]) {
                                if ([model2.text isEqualToString:@"和"]) {
                                    JhPageItemModel *hemodel = [[JhPageItemModel alloc]init];
                                    hemodel.img = @"18";
                                    hemodel.colorString = @"";
                                    hemodel.text = @"";
                                    [zhuangListArray addObject:hemodel];
                                }
                                for (int j=(int)zhuangListArray.count; j<5; j++) {
                                    NSString *text = @"";
                                    NSString *img = @"";
                                    JhPageItemModel *model = [[JhPageItemModel alloc]init];
                                    model.img = img;
                                    model.text = text;
                                    model.colorString = @"#ffffff";
                                    [zhuangListArray addObject:model];
                                }
                                [realListArray addObjectsFromArray:zhuangListArray];
                                [zhuangListArray removeAllObjects];
                            }
                        }else if ([model1.text isEqualToString:@"虎"]){
                            model.img = @"13";
                            model.colorString = @"#362bf5";
                            model.text = model1.text;
                            [xianListArray addObject:model];
                            if (![model2.text isEqualToString:@"虎"]) {
                                if ([model2.text isEqualToString:@"和"]) {
                                    JhPageItemModel *hemodel = [[JhPageItemModel alloc]init];
                                    hemodel.img = @"18";
                                    hemodel.colorString = @"";
                                    hemodel.text = @"";
                                    [xianListArray addObject:hemodel];
                                }
                                for (int j=(int)xianListArray.count; j<5; j++) {
                                    NSString *text = @"";
                                    NSString *img = @"";
                                    JhPageItemModel *model = [[JhPageItemModel alloc]init];
                                    model.img = img;
                                    model.text = text;
                                    model.colorString = @"#ffffff";
                                    [xianListArray addObject:model];
                                }
                                [realListArray addObjectsFromArray:xianListArray];
                                [xianListArray removeAllObjects];
                            }
                        }
                    }else if (i+1==luzhuDownList.count){
                        JhPageItemModel *model1 = luzhuDownList[i];
                        JhPageItemModel *model2 = luzhuDownList[i-1];
                        JhPageItemModel *model = [[JhPageItemModel alloc]init];
                        if ([model1.text isEqualToString:@"龙"]) {
                            model.img = @"9";
                            model.text = model1.text;
                            model.colorString = @"#ec3223";
                            [zhuangListArray addObject:model];
                            if (![model2.text isEqualToString:@"龙"]) {
                                if ([model2.text isEqualToString:@"和"]) {
                                    JhPageItemModel *hemodel = [[JhPageItemModel alloc]init];
                                    hemodel.img = @"18";
                                    hemodel.colorString = @"";
                                    hemodel.text = @"";
                                    [zhuangListArray addObject:hemodel];
                                }
                                for (int j=(int)zhuangListArray.count; j<5; j++) {
                                    NSString *text = @"";
                                    NSString *img = @"";
                                    JhPageItemModel *model = [[JhPageItemModel alloc]init];
                                    model.img = img;
                                    model.text = text;
                                    model.colorString = @"#ffffff";
                                    [zhuangListArray addObject:model];
                                }
                                [realListArray addObjectsFromArray:zhuangListArray];
                                [zhuangListArray removeAllObjects];
                            }else{
                                [realListArray addObjectsFromArray:zhuangListArray];
                            }
                        }else if ([model1.text isEqualToString:@"虎"]){
                            model.img = @"13";
                            model.colorString = @"#362bf5";
                            model.text = model1.text;
                            [xianListArray addObject:model];
                            if (![model2.text isEqualToString:@"虎"]) {
                                if ([model2.text isEqualToString:@"和"]) {
                                    JhPageItemModel *xianmodel = [[JhPageItemModel alloc]init];
                                    xianmodel.img = @"18";
                                    xianmodel.colorString = @"";
                                    xianmodel.text = @"";
                                    [xianListArray addObject:xianmodel];
                                }
                                for (int j=(int)xianListArray.count; j<5; j++) {
                                    NSString *text = @"";
                                    NSString *img = @"";
                                    JhPageItemModel *model = [[JhPageItemModel alloc]init];
                                    model.img = img;
                                    model.text = text;
                                    model.colorString = @"#ffffff";
                                    [xianListArray addObject:model];
                                }
                                [realListArray addObjectsFromArray:xianListArray];
                                [xianListArray removeAllObjects];
                            }else{
                                [realListArray addObjectsFromArray:xianListArray];
                            }
                        }
                    }
                }
            }
            [realDownListArray addObjectsFromArray:realListArray];
            for (int i=(int)realListArray.count; i<100; i++) {
                NSString *text = @"";
                NSString *img = @"";
                JhPageItemModel *model = [[JhPageItemModel alloc]init];
                model.img = img;
                model.text = text;
                model.colorString = @"#ffffff";
                [realDownListArray addObject:model];
            }
            self.luzhuDownList = realDownListArray;
        }
        block(suc, msg,error);
        
    }];
}

#pragma mark - 提交日结
- (void)commitDailyWithBlock:(EPFeedbackWithErrorCodeBlock)block{
    NSArray *chipList = [NSArray array];
    if (self.curupdateInfo.cp_xiaofeiList.count!=0) {
        chipList = self.curupdateInfo.cp_xiaofeiList;
    }
    NSDictionary * param = @{
                             @"access_token":self.loginInfo.access_token,
                             @"ftable_id":self.curTableInfo.fid,//桌子ID
                             @"frjdate":[NRCommand getCurrentDate],//日期
                             @"femp_num":self.curupdateInfo.femp_num,//管理员登录账号
                             @"femp_pwd":self.curupdateInfo.femp_pwd,//登录密码
                             @"fhg_id":self.curupdateInfo.fhg_id//荷官ID
                             };
    NSArray *paramList = @[param];
    NSDictionary * Realparam = @{
                                 @"f":@"Cmpublish_checkState",
                                 @"p":[paramList JSONString]
                                 };
    [EPService nr_PublicWithParamter:Realparam block:^(NSDictionary *responseDict, NSString *msg, EPSreviceError error, BOOL suc) {
        if (suc) {
            self.cp_fidString = @"";
        }
        block(suc, msg,error);
        
    }];
}

@end
