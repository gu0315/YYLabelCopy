//
//  AppDelegate.h
//  YYLabelCopy
//
//  Created by 顾钱想 on 2021/1/8.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

