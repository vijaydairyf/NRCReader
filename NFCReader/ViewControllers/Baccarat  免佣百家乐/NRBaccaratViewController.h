//
//  NRBaccaratViewController.h
//  NFCReader
//
//  Created by 李黎明 on 2019/4/15.
//  Copyright © 2019 李黎明. All rights reserved.
//

#import "NRBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class NRBaccaratViewModel;
@interface NRBaccaratViewController : NRBaseViewController

@property (nonatomic, strong) NRBaccaratViewModel *viewModel;
@property (nonatomic, strong) NSArray *chipFmeList;

@end

NS_ASSUME_NONNULL_END
