//
//  NRCowViewController.h
//  NFCReader
//
//  Created by 李黎明 on 2019/5/8.
//  Copyright © 2019 李黎明. All rights reserved.
//

#import "NRBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class NRCowViewModel;
@interface NRCowViewController : NRBaseViewController
@property (nonatomic, strong) NRCowViewModel *viewModel;
@property (nonatomic, strong) NSArray *chipFmeList;

@end

NS_ASSUME_NONNULL_END
