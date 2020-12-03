//
//  NotificationCenter.m
//  TicketsApp
//
//  Created by Vit K on 03.12.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "NotificationCenter.h"
#import <UserNotifications/UserNotifications.h>
#import "TicketsViewController.h"
#import "CoreDataHelper.h"

@interface NotificationCenter () <UNUserNotificationCenterDelegate>
@end


@implementation NotificationCenter

+ (instancetype)sharedInstance
{
    static NotificationCenter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NotificationCenter alloc] init];

    });
    return instance;
}

- (void)registerService {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!error) {
                                      NSLog(@"request authorization succeeded!");
                                  }
                              }];

}

- (void)sendNotification:(Notification)notification {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = notification.title;
        content.body = notification.body;
        content.sound = [UNNotificationSound defaultSound];
        
        if (notification.imageURL) {
            UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"image" URL:notification.imageURL options:nil error:nil];
            if (attachment) {
                content.attachments = @[attachment];
            }
        }
        
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:notification.date];
        NSDateComponents *newComponents = [[NSDateComponents alloc] init];
        newComponents.calendar = calendar;
        newComponents.timeZone = [NSTimeZone defaultTimeZone];
        newComponents.month = components.month;
        newComponents.day = components.day;
        newComponents.hour = components.hour;
        newComponents.minute = components.minute;
        
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:newComponents repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Notification"
                                                                              content:content trigger:trigger];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:nil];
}

Notification NotificationMake(NSString* _Nullable title, NSString* _Nonnull body, NSDate* _Nonnull date, NSURL * _Nullable  imageURL, NSNumber * _Nonnull flightNumber) {
    Notification notification;
    notification.title = title;
    notification.body = body;
    notification.date = date;
    notification.imageURL = imageURL;
    notification.flightNumber = flightNumber;
    return notification;
}

//Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

//Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    
    UIWindowScene *scene = (UIWindowScene *) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject;
    UINavigationController *nav = (UINavigationController *) scene.windows.firstObject.rootViewController;
    
    NSArray *components = [response.notification.request.content.body componentsSeparatedByString:@" "];

    NSArray *arr = [[NSArray alloc] initWithObjects:[[CoreDataHelper sharedInstance] favoriteFromPrice: components[4] andFrom:components[0] andTo:components[2]], nil];
    
    TicketsViewController *favoriteViewController = [[TicketsViewController alloc] initWithNotificationTickets:arr];
    
    [nav showViewController:favoriteViewController sender:self];
    completionHandler();
}

@end

