//
//  NRCashExchangeTableViewCell.m
//  NFCReader
//
//  Created by 李黎明 on 2019/4/20.
//  Copyright © 2019 李黎明. All rights reserved.
//

#import "NRCashExchangeTableViewCell.h"
#import "NRChipInfo.h"

@interface NRCashExchangeTableViewCell ()

@property (nonatomic, strong) UILabel *batchLab;
@property (nonatomic, strong) UILabel *serialNumberLab;
@property (nonatomic, strong) UILabel *chipTypeLab;
@property (nonatomic, strong) UILabel *denominationLab;
@property (nonatomic, strong) UILabel *washNumberLab;
@property (nonatomic, strong) UILabel *statusLab;
@property (nonatomic, strong) UIView *lineV;

@end

@implementation NRCashExchangeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat cell_size = 16;
    CGFloat cell_width = (kScreenWidth - 200)/6;
    self.batchLab = [UILabel new];
    self.batchLab.font = [UIFont fontWithName:@"PingFang SC" size:cell_size];
    self.batchLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.batchLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.batchLab];
    [self.batchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(cell_width);
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.serialNumberLab = [UILabel new];
    self.serialNumberLab.font = [UIFont fontWithName:@"PingFang SC" size:cell_size];
    self.serialNumberLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.serialNumberLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.serialNumberLab];
    [self.serialNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(cell_width);
        make.left.equalTo(self.batchLab.mas_right);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.chipTypeLab = [UILabel new];
    self.chipTypeLab.font = [UIFont fontWithName:@"PingFang SC" size:cell_size];
    self.chipTypeLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.chipTypeLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.chipTypeLab];
    [self.chipTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(cell_width);
        make.left.equalTo(self.serialNumberLab.mas_right);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.denominationLab = [UILabel new];
    self.denominationLab.font = [UIFont fontWithName:@"PingFang SC" size:cell_size];
    self.denominationLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.denominationLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.denominationLab];
    [self.denominationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(cell_width);
        make.left.equalTo(self.chipTypeLab.mas_right);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.washNumberLab = [UILabel new];
    self.washNumberLab.font = [UIFont fontWithName:@"PingFang SC" size:cell_size];
    self.washNumberLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.washNumberLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.washNumberLab];
    [self.washNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(cell_width);
        make.left.equalTo(self.denominationLab.mas_right);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.statusLab = [UILabel new];
    self.statusLab.font = [UIFont fontWithName:@"PingFang SC" size:cell_size];
    self.statusLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.statusLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.statusLab];
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(cell_width);
        make.left.equalTo(self.washNumberLab.mas_right);
        make.centerY.equalTo(self.contentView);
    }];

    self.lineV = [UIView new];
    self.lineV.backgroundColor = [UIColor colorWithHexString:@"#959595"];
    [self.contentView addSubview:self.lineV];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView);
        make.height.mas_offset(1);
        make.centerX.equalTo(self.contentView);
    }];
    
    return self;
}

+ (CGFloat)height{
    return 51;
}

- (void)configureWithBatchText:(NSString *)batchText
              SerialNumberText:(NSString *)serialNumberText
              ChipTypeText:(NSString *)chipTypeText
              DenominationText:(NSString *)denominationText
                         WashNumberText:(NSString *)washNumberText
                           StatusText:(NSString *)statusText
                        chipTypeList:(NSArray *)chiTypeList{
    if ([chipTypeText isEqualToString:@"99"]||[chipTypeText isEqualToString:@"#"]) {
        self.batchLab.textColor =self.serialNumberLab.textColor =self.chipTypeLab.textColor =self.denominationLab.textColor=self.washNumberLab.textColor = self.statusLab.textColor =[UIColor colorWithHexString:@"#b0251d"];
        NSString *destruct = @"#";
        self.batchLab.text = destruct;
        self.serialNumberLab.text = destruct;
        self.chipTypeLab.text = destruct;
        self.denominationLab.text = destruct;
        self.washNumberLab.text = destruct;
    }else{
        self.batchLab.textColor =self.serialNumberLab.textColor =self.chipTypeLab.textColor =self.denominationLab.textColor=self.washNumberLab.textColor = self.statusLab.textColor =[UIColor colorWithHexString:@"#ffffff"];
        self.batchLab.text = batchText;
        self.serialNumberLab.text = serialNumberText;
        self.denominationLab.text = denominationText;
        NSString *washaString = [washNumberText NullToBlankString];
        if ([washaString length]==0) {
            washaString = @"0";
        }
        self.washNumberLab.text = washaString;
        self.chipTypeLab.text = chipTypeText;
        [chiTypeList enumerateObjectsUsingBlock:^(NRChipInfo *curChipInfo, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([chipTypeText intValue]==[curChipInfo.fcmtype intValue]) {
                self.chipTypeLab.text = curChipInfo.fcmtype_name;
            }
        }];
    }
    self.statusLab.text = statusText;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
