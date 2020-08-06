//
//  ShareSDKLinkRestoreManager.h
//  ShareSDKPlus
//
//  Created by maxl on 2020/3/26.
//  Copyright © 2020 Mob. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareSDKLinkRestoreManager : NSObject

+ (ShareSDKLinkRestoreManager *)manager;

- (void)addModule:(id)module;

@end

NS_ASSUME_NONNULL_END
