/********* pubNubios.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "PubNub.h"




@interface pubNubios : CDVPlugin <PNEventsListener> {
//    void (^_completionHandler)(NSString* someParameter);
}
//- (void) pubNubGetState:(void(^)(NSString*))handler;
- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)publishMessage:(CDVInvokedUrlCommand*)command;
- (void)addMessageAction:(CDVInvokedUrlCommand*)command;
- (void)pubNubGlobalHereNow:(CDVInvokedUrlCommand*)command;
- (void)pubNubHereNowForChannel:(CDVInvokedUrlCommand*)command;
- (void)sendMessageWithCompression:(CDVInvokedUrlCommand*)command;
- (void)signal:(CDVInvokedUrlCommand*)command;
- (void)listOfUdidFromChannel:(CDVInvokedUrlCommand*)command;
- (void)listOfSubcribedUdid:(CDVInvokedUrlCommand*)command;
- (void)historyOfChannel:(CDVInvokedUrlCommand*)command;
- (void)pushNotificationOnChammel:(CDVInvokedUrlCommand*)command;
- (void)messgaeCount:(CDVInvokedUrlCommand*)command;
- (void)deleteMessageFromChannel:(CDVInvokedUrlCommand*)command;
- (void)historyOfLastThreeMessage:(CDVInvokedUrlCommand*)command;
- (void)enablePushNotification:(CDVInvokedUrlCommand*)command;
- (void)removeAllPushNotification:(CDVInvokedUrlCommand*)command;
- (void)getAllChannelsMetaData:(CDVInvokedUrlCommand*)command;
- (void)removeChannelsMetaData:(CDVInvokedUrlCommand*)command;
- (void)pubNubWhereNow:(CDVInvokedUrlCommand*)command;
- (void)pubNubUnsubFromPresence:(CDVInvokedUrlCommand*)command;
- (void)pubNubSubscribeToPresence:(CDVInvokedUrlCommand*)command;




        @property(nonatomic, strong) PubNub *client;
        @property(nonatomic, strong) NSString *subKey;
        @property(nonatomic, strong) NSString *pubKey;
        @property(nonatomic, strong) NSString *channel1;
        @property(nonatomic, strong) NSString *channel2;
        @property(nonatomic, strong) NSString *channelGroup1;
        @property(nonatomic, strong) NSString *authKey;
        @property(nonatomic, strong) NSTimer *timer;
        @property (nonatomic, strong) NSString* callerId;
        @property (nonatomic, strong) NSData* devicePushToken;

        @property(nonatomic, strong) PNConfiguration *myConfig;

- (void)updateClientConfiguration;
- (void)printClientConfiguration;

//_client.subscribe(_channel1)

//- (void)updateClientConfiguration;
//- (void)printClientConfiguration;
@end

@implementation pubNubios

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* publishKey = [command.arguments objectAtIndex:0];
    NSString* subcriptionKey = [command.arguments objectAtIndex:1];
    NSString* channelName = [command.arguments objectAtIndex:2];
    NSString* authKey = [command.arguments objectAtIndex:3];
    

    if (publishKey != nil && subcriptionKey != nil && channelName != nil && authKey != nil){
        
    self.pubKey = publishKey;
    self.subKey = subcriptionKey;
    self.channel1 = channelName;
    self.authKey = authKey;
        
        [self tireKicker];

        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"connected"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
   
    self.callerId = command.callbackId;
    
    [pluginResult setKeepCallbackAsBool:YES];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}


- (void)pubNubInit {
    
    // Initialize PubNub client.
    self.myConfig = [PNConfiguration configurationWithPublishKey:_pubKey subscribeKey:_subKey];
    
    [self updateClientConfiguration];
    [self printClientConfiguration];
    
    // Bind config
    self.client = [PubNub clientWithConfiguration:self.myConfig];
    [self.client subscribeToChannels:@[_channel1] withPresence:YES];
    // Configure logger
    self.client.logger.enabled = YES;
    self.client.logger.writeToFile = YES;
    self.client.logger.maximumLogFileSize = (10 * 1024 * 1024);
    self.client.logger.maximumNumberOfLogFiles = 10;
    [self.client.logger setLogLevel:PNVerboseLogLevel];
    
    // Bind didReceiveMessage, didReceiveStatus, and didReceivePresenceEvent 'listeners' to this delegate
    // just be sure the target has implemented the PNObjectEventListener extension
    [self.client addListener:self];
    [self pubNubSetState];
}



- (void)tireKicker {
    [self pubNubInit];
    
#pragma mark - Time
    
//    [self pubNubTime];
    
#pragma mark - Publish
//    [self pubNubPublish];
    
#pragma mark - History
    
//    [self pubNubHistory];
//
//#pragma mark - Channel Groups Subscribe / Unsubscribe
//
//    [self pubNubSubscribeToChannelGroup];
//    [self pubNubUnsubFromChannelGroups];
//
//#pragma mark - Channel Subscribe / Unsubscribe
//
//    [self pubNubSubscribeToChannels];
//    [self pubNubUnsubscribeFromChannels];
//
//#pragma mark - Presence Subscribe / Unsubscribe
//
//    [self pubNubSubscribeToPresence];
//    [self pubNubUnsubFromPresence];
//
//#pragma mark - Here Nows
//
//    [self pubNubHereNowForChannel];
//    [self pubNubGlobalHereNow];
//    [self pubNubHereNowForChannelGroups];
//    [self pubNubWhereNow];
//
//#pragma mark - CG Admin
//
//    [self pubNubCGAdd];
//    [self pubNubChannelsForGroup];
//    [self pubNubCGRemoveAllChannels];
//    [self pubNubCGRemoveSomeChannels];
    
#pragma mark - State Admin
    [self pubNubSetState];
    [self pubNubGetState];
//    pubNubios *foo = [[pubNubios alloc] init];
//    [foo pubNubGetState:^(NSString* result){
//        // Prints 10
//        NSLog(@"%@", result);
//    }];
    
    
#pragma mark - 3rd Party Push Notifications Admin
    
//    [self pubNubAddPushNotifications];
//    [self pubNubRemovePushNotification];
//    [self pubNubRemoveAllPushNotifications];
//    [self pubNubGetAllPushNotifications];
//
//#pragma mark - Public Encryption/Decryption Methods
//
//    [self pubNubAESDecrypt];
//    [self pubNubAESEncrypt];
//
//#pragma mark - Message Size Check Methods
//
    [self pubNubSizeOfMessage];
    
}


#pragma mark - Configuration

- (void)updateClientConfiguration {
    
    // Set PubNub Configuration
    self.myConfig.TLSEnabled = NO;
    self.myConfig.uuid = [self randomString];
    self.myConfig.origin = @"pubsub.pubnub.com";
    self.myConfig.authKey = _authKey;
    
    // Presence Settings
    self.myConfig.presenceHeartbeatValue = 120;
    self.myConfig.presenceHeartbeatInterval = 5;
    
    // Cipher Key Settings
    //    self.myConfig.cipherKey = @"enigma";
    
    // Time Token Handling Settings
    self.myConfig.keepTimeTokenOnListChange = YES;
    self.myConfig.catchUpOnSubscriptionRestore = YES;
    
    // Messages threshold
    self.myConfig.requestMessageCountThreshold = 100;
}

- (NSString *)randomString {
    return [NSString stringWithFormat:@"%d", arc4random_uniform(74)];
}


- (void)printClientConfiguration {
    
    // Get PubNub Options
    NSLog(@"TLSEnabled: %@", (self.myConfig.isTLSEnabled ? @"YES" : @"NO"));
    NSLog(@"Origin: %@", self.myConfig.origin);
    NSLog(@"authKey: %@", self.myConfig.authKey);
    NSLog(@"UUID: %@", self.myConfig.uuid);
    
    // Time Token Handling Settings
    NSLog(@"keepTimeTokenOnChannelChange: %@",
          (self.myConfig.shouldKeepTimeTokenOnListChange ? @"YES" : @"NO"));
    NSLog(@"catchUpOnSubscriptionRestore: %@",
          (self.myConfig.shouldTryCatchUpOnSubscriptionRestore ? @"YES" : @"NO"));
    
    // Get Presence Options
    NSLog(@"Heartbeat value: %@", @(self.myConfig.presenceHeartbeatValue));
    NSLog(@"Heartbeat interval: %@", @(self.myConfig.presenceHeartbeatInterval));
    
    // Get CipherKey
    NSLog(@"Cipher key: %@", self.myConfig.cipherKey);
}


- (void)pubNubSetState {
    
    __weak __typeof(self) weakSelf = self;
    [self.client setState:@{[self randomString] : @{[self randomString] : [self randomString]}} forUUID:_myConfig.uuid onChannel:_channel1 withCompletion:^(PNClientStateUpdateStatus *status) {
        
        __strong __typeof(self) strongSelf = weakSelf;
        
        [strongSelf handleStatus:status];
    }];
}



#pragma mark - example status handling

- (void)handleStatus:(PNStatus *)status {
    //    Retry attempts can be cancelled via [status cancelAutomaticRetry]
    
    if (status.isError) {
        [self handleErrorStatus:(PNErrorStatus *)status];
    } else {
        [self handleNonErrorStatus:status];
    }
    
}

- (void)handleErrorStatus:(PNErrorStatus *)status {
    
    CDVPluginResult* pluginResult = nil;
    
    NSLog(@"^^^^ Debug: %@", status.debugDescription);
    
    if (status.category == PNAccessDeniedCategory) {
        
        NSLog(@"^^^^ handleErrorStatus: PAM Error: for resource Will Auto Retry?: %@", status.willAutomaticallyRetry ? @"YES" : @"NO");
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNAccessDeniedCategory"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
        
        [self handlePAMError:status];
    }
    else if (status.category == PNDecryptionErrorCategory) {
        
        NSLog(@"Decryption error. Be sure the data is encrypted and/or encrypted with the correct cipher key.");
        NSLog(@"You can find the raw data returned from the server in the status.data attribute: %@", status.associatedObject);
        if (status.operation == PNSubscribeOperation) {
            
            NSLog(@"Decryption failed for message from channel: %@",
                  ((PNMessageData *)status.associatedObject).channel);
        }
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNDecryptionErrorCategory"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
        
    }
    
    
    else if (status.category == PNMalformedFilterExpressionCategory) {
        
        NSLog(@"Value which has been passed to -setFilterExpression: malformed.");
        NSLog(@"Please verify specified value with declared filtering expression syntax.");
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNMalformedFilterExpressionCategory"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
        
    }
    else if (status.category == PNMalformedResponseCategory) {
        
        NSLog(@"We were expecting JSON from the server, but we got HTML, or otherwise not legal JSON.");
        NSLog(@"This may happen when you connect to a public WiFi Hotspot that requires you to auth via your web browser first,");
        NSLog(@"or if there is a proxy somewhere returning an HTML access denied error, or if there was an intermittent server issue.");
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNMalformedResponseCategory"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    }
    else if (status.category == PNRequestURITooLongCategory) {
        if (status.operation == PNSubscribeOperation) {
            
            NSLog(@"Too many channels has been passed to subscribe API.");
        }
        else {
            
            NSLog(@"Depending from used API this error may mean what to big message has been publish for publish API,");
            NSLog(@" or too many channels has been passed to stream controller at once.");
        }
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNRequestURITooLongCategory"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    }
    else if (status.category == PNTimeoutCategory) {
        
        NSLog(@"For whatever reason, the request timed out. Temporary connectivity issues, etc.");
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNTimeoutCategory"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    }
    else if (status.category == PNNetworkIssuesCategory) {
        
        NSLog(@"Request can't be processed because of network issues.");
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNNetworkIssuesCategory"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    }
    else {
        // Aside from checking for PAM, this is a generic catch-all if you just want to handle any error, regardless of reason
        // status.debugDescription will shed light on exactly whats going on
        
        NSLog(@"Request failed... if this is an issue that is consistently interrupting the performance of your app,");
        NSLog(@"email the output of debugDescription to support along with all available log info: %@", [status debugDescription]);
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNAccessDeniedCategory"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    }
    if (status.operation == PNHeartbeatOperation) {
        
        NSLog(@"Heartbeat operation failed.");
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNHeartbeatOperation"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    }
}



- (void)handleNonErrorStatus:(PNStatus *)status {
    
    CDVPluginResult* pluginResult = nil;
    
    // This method demonstrates how to handle status events that are not errors -- that is,
    // status events that can safely be ignored, but if you do choose to handle them, you
    // can get increased functionality from the client
    
    if (status.category == PNAcknowledgmentCategory) {
        NSLog(@"^^^^ Non-error status: ACK");
        
        // For methods like Publish, Channel Group Add|Remove|List, APNS Add|Remove|List
        // when the method is executed, and completes, you can receive the 'ack' for it here.
        // status.data will contain more server-provided information about the ack as well.
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNAcknowledgmentCategory"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    }
    
    if (status.operation == PNSubscribeOperation) {
        
        PNSubscribeStatus *subscriberStatus = (PNSubscribeStatus *)status;
        // Specific to the subscribe loop operation, you can handle connection events
        // These status checks are only available via the subscribe status completion block or
        // on the long-running subscribe loop listener didReceiveStatus
        
        // Connection events are never defined as errors via status.isError
        if (status.category == PNUnexpectedDisconnectCategory) {
            // PNUnexpectedDisconnect happens as part of our regular operation
            // This event happens when radio / connectivity is lost
            
            NSLog(@"^^^^ Non-error status: Unexpected Disconnect, Channel Info: %@",
                  subscriberStatus.subscribedChannels);
        }
        
        else if (status.category == PNConnectedCategory) {
            
            // Connect event. You can do stuff like publish, and know you'll get it.
            // Or just use the connected event to confirm you are subscribed for UI / internal notifications, etc
            
            // NSLog(@"Subscribe Connected to %@", status.data[@"channels"]);
            NSLog(@"^^^^ Non-error status: Connected, Channel Info: %@",
                  subscriberStatus.subscribedChannels);
            
            
            
            
        }
        else if (status.category == PNReconnectedCategory) {
            
            // PNUnexpectedDisconnect happens as part of our regular operation
            // This event happens when radio / connectivity is lost
            
            NSLog(@"^^^^ Non-error status: Reconnected, Channel Info: %@",
                  subscriberStatus.subscribedChannels);
        }
        else if (status.category == PNRequestMessageCountExceededCategory) {
            
            /**
             Looks like client received a lot of messages at once (larget than specified
             'requestMessageCountThreshold') and potentially history request maybe required.
             */
            NSLog(@"^^^^ Non-error status: Message Count Exceeded");
        }
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNSubscribeOperation"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
        
    }
    else if (status.operation == PNUnsubscribeOperation) {
        
        if (status.category == PNDisconnectedCategory) {
            // PNDisconnect happens as part of our regular operation
            // No need to monitor for this unless requested by support
            NSLog(@"^^^^ Non-error status: Expected Disconnect");
        }
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNUnsubscribeOperation"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
        
    }
    else if (status.operation == PNHeartbeatOperation) {
        
        NSLog(@"Heartbeat operation successful.");
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNHeartbeatOperation"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    }
}

- (void)handlePAMError:(PNErrorStatus *)status {
    // Access Denied via PAM. Access status.data to determine the resource in question that was denied.
    // In addition, you can also change auth key dynamically if needed."
    
    CDVPluginResult* pluginResult = nil;
    
    NSString *pamResourceName = (status.errorData.channels ? status.errorData.channels.firstObject :
                                 status.errorData.channelGroups.firstObject);
    NSString *pamResourceType = status.errorData.channels ? @"channel" : @"channel-groups";
    
    NSLog(@"PAM error on %@ %@", pamResourceType, pamResourceName);
    
    // If its a PAM error on subscribe, lets grab the channel name in question, and unsubscribe from it, and re-subscribe to a channel that we're authed to
    
    if (status.operation == PNSubscribeOperation) {
        
        if ([pamResourceType isEqualToString:@"channel"]) {
            NSLog(@"^^^^ Unsubscribing from %@", pamResourceName);
            [self reconfigOnPAMError:status];
        }
        
        else {
            [self.client unsubscribeFromChannelGroups:@[pamResourceName] withPresence:YES];
            // the case where we're dealing with CGs instead of CHs... follows the same pattern as above
        }
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNSubscribeOperation"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
        
    } else if (status.operation == PNPublishOperation) {
        
        NSLog(@"^^^^ Error publishing with authKey: %@ to channel %@.", _authKey, pamResourceName);
        NSLog(@"^^^^ Setting auth to an authKey that will allow for both sub and pub");
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"PNPublishOperation"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
        
        [self reconfigOnPAMError:status];
    }
}

- (void)publishMessage:(CDVInvokedUrlCommand *)command{
    
    CDVPluginResult* pluginResult = nil;
    NSString* message = [command.arguments objectAtIndex:0];
    
    [self.client publish: message toChannel:_channel1
          withCompletion:^(PNPublishStatus *status) {
              if (!status.isError) {
                  NSLog(@"Message sent at TT: %@", status.data.timetoken);
              } else {
                  
                  
                  
                  [self handleStatus:status];
              }
        
          }];
    
    /*
     [self.client publish:<#(id)message#> toChannel:<#(NSString *)channel#> compressed:<#(BOOL)compressed#> withCompletion:<#(PNPublishCompletionBlock)block#>];
     [self.client publish:<#(id)message#> toChannel:<#(NSString *)channel#> withCompletion:<#(PNPublishCompletionBlock)block#>];
     [self.client publish:<#(id)message#> toChannel:<#(NSString *)channel#> storeInHistory:<#(BOOL)shouldStore#> withCompletion:<#(PNPublishCompletionBlock)block#>];
     [self.client publish:<#(id)message#> toChannel:<#(NSString *)channel#> storeInHistory:<#(BOOL)shouldStore#> compressed:<#(BOOL)compressed#> withCompletion:<#(PNPublishCompletionBlock)block#>];
     [self.client publish:<#(id)message#> toChannel:<#(NSString *)channel#> mobilePushPayload:<#(NSDictionary *)payloads#> withCompletion:<#(PNPublishCompletionBlock)block#>];
     [self.client publish:<#(id)message#> toChannel:<#(NSString *)channel#> mobilePushPayload:<#(NSDictionary *)payloads#> compressed:<#(BOOL)compressed#> withCompletion:<#(PNPublishCompletionBlock)block#>];
     [self.client publish:<#(id)message#> toChannel:<#(NSString *)channel#> mobilePushPayload:<#(NSDictionary *)payloads#> storeInHistory:<#(BOOL)shouldStore#> withCompletion:<#(PNPublishCompletionBlock)block#>];
     [self.client publish:<#(id)message#> toChannel:<#(NSString *)channel#> mobilePushPayload:<#(NSDictionary *)payloads#> storeInHistory:<#(BOOL)shouldStore#> compressed:<#(BOOL)compressed#> withCompletion:<#(PNPublishCompletionBlock)block#>];
     */
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"message succesfully published"];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
    
}


- (void)reconfigOnPAMError:(PNErrorStatus *)status {
    
    
    // If this is a subscribe PAM error
    
    if (status.operation == PNSubscribeOperation) {
        
        PNSubscribeStatus *subscriberStatus = (PNSubscribeStatus *)status;
        
        NSArray *currentChannels = subscriberStatus.subscribedChannels;
        NSArray *currentChannelGroups = subscriberStatus.subscribedChannelGroups;
        
        self.myConfig.authKey = @"sec-c-MjNlNzFkNWMtMWU4Ni00N2MyLTliZmEtMGRhZGZhNGMxZmFl";
        
        [self.client copyWithConfiguration:self.myConfig completion:^(PubNub *client){
            
            self.client = client;
            
            [self.client subscribeToChannels:currentChannels withPresence:NO];
            [self.client subscribeToChannelGroups:currentChannelGroups withPresence:NO];
        }];
    }
}


- (void)pubNubSizeOfMessage{
    
    [self.client sizeOfMessage:@"Connected! I'm here!" toChannel:_channel1
                withCompletion:^(NSInteger size) {
                    
                    NSLog(@"^^^^ Message size: %@", @(size));
                }];
}

- (void)pubNubGetState{
    
    [self.client stateForUUID:_myConfig.uuid onChannel:_channel1
               withCompletion:^(PNChannelClientStateResult *result, PNErrorStatus *status) {
        
                   if (status) {
                       [self handleStatus:status];
                   }
                   else if (result) {
//                       self->_completionHandler(result.uuid);
                       NSLog(@"^^^^ Loaded state %@ for channel %@", result.data.state, self->_channel1);
                   }
        
        
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"success"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
                   
               }];
}



#pragma mark - Streaming Data didReceiveMessage Listener



- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    
    CDVPluginResult* pluginResult = nil;
    
    if (![message.data.channel isEqualToString:message.data.subscription]) {
        
        NSLog(@"%@", message);
    }
    else {
        
        // Message has been received on channel stored in message.data.channel.
    }
    
    if (message) {
        
        NSLog(@"Received message from '%@': %@ on channel %@ at %@", message.data.publisher,
              message.data.message, message.data.channel, message.data.timetoken);
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: message.data.message];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    }
}



#pragma mark - Streaming Data didReceivePresenceEvent Listener

- (void)client:(PubNub *)client didReceivePresenceEvent:(PNPresenceEventResult *)event {
    
    CDVPluginResult* pluginResult = nil;
    
    if (![event.data.channel isEqualToString:event.data.subscription]) {

    }
    else {
        
        // Presence event has been received on channel stored in event.data.channel.
    }
    
    if (![event.data.presenceEvent isEqualToString:@"state-change"]) {
        
        NSLog(@"%@ \"%@'ed\"\nat: %@ on %@ (Occupancy: %@)", event.data.presence.uuid,
              event.data.presenceEvent, event.data.presence.timetoken, event.data.channel,
              event.data.presence.occupancy);
    }
    else {
        
        NSLog(@"%@ changed state at: %@ on %@ to: %@", event.data.presence.uuid,
              event.data.presence.timetoken, event.data.channel, event.data.presence.state);
    }
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"presenceEventCalled"];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    
}


#pragma mark - Streaming Data didReceiveStatus Listener

- (void)client:(PubNub *)client didReceiveStatus:(PNStatus *)status {
    
    CDVPluginResult* pluginResult = nil;
    // This is where we'll find ongoing status events from our subscribe loop
    // Results (messages) from our subscribe loop will be found in didReceiveMessage
    // Results (presence events) from our subscribe loop will be found in didReceiveStatus
    
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"didReceveStatus"];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    
    [self handleStatus:status];
}


//- (void)pubNubUnsubFromChannelGroups {
//    [self.client unsubscribeFromChannelGroups:@[@"myChannelGroup"] withPresence:NO];
//
//
//}


- (void)pubNubSubscribeToPresence:(CDVInvokedUrlCommand*)command;{
    NSString* channelsName = [command.arguments objectAtIndex:0];
    [self.client subscribeToPresenceChannels:@[channelsName]];
    
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"sucessfully subcribed"];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
    
    
}

- (void)pubNubUnsubFromPresence:(CDVInvokedUrlCommand*)command;{
    NSString* channelsName = [command.arguments objectAtIndex:0];
    [self.client unsubscribeFromPresenceChannels:@[channelsName]];
    
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"sucessfully Unsubcribed"];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: _callerId];
}

- (void)pubNubHereNowForChannel:(CDVInvokedUrlCommand*)command;
{
    NSString* channelsName = [command.arguments objectAtIndex:0];
    
    [self.client hereNowForChannel:channelsName withCompletion:^(PNPresenceChannelHereNowResult *result,
                                                              PNErrorStatus *status) {
        if (status) {
            
            [self handleStatus:status];
        }
        else if (result) {
            NSLog(@"^^^^ Loaded hereNowForChannel data: occupancy: %@, uuids: %@", result.data.occupancy, result.data.uuids);
        }
        
        NSArray* notifications = [NSArray arrayWithObjects:result.data.uuids, result.data.occupancy, nil];
        
        NSError *writeError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON Output: %@", jsonString);
        
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
        
    }];
    

}


- (void)pubNubGlobalHereNow:(CDVInvokedUrlCommand*)command;{
    [self.client hereNowWithCompletion:^(PNPresenceGlobalHereNowResult *result, PNErrorStatus *status) {
        if (status) {
            [self handleStatus:status];
        }
        else if (result) {
            NSLog(@"^^^^ Loaded Global hereNow data: channels: %@, total channels: %@, total occupancy: %@", result.data.channels, result.data.totalChannels, result.data.totalOccupancy);
        }
        
        
        NSArray* notifications = [NSArray arrayWithObjects:result.data.channels, result.data.totalChannels, nil];
        
        NSError *writeError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON Output: %@", jsonString);
        
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
        
    }];
    
    // If you want to control the 'verbosity' of the server response -- restrict to (values are additive):
    
    // Occupancy                : PNHereNowOccupancy
    // Occupancy + UUID         : PNHereNowUUID
    // Occupancy + UUID + State : PNHereNowState
    
    [self.client hereNowWithVerbosity:PNHereNowOccupancy completion:^(PNPresenceGlobalHereNowResult *result,
                                                                      PNErrorStatus *status) {
        if (status) {
            [self handleStatus:status];
        }
        else if (result) {
            NSLog(@"^^^^ Loaded Global hereNow data: channels: %@, total channels: %@, total occupancy: %@", result.data.channels, result.data.totalChannels, result.data.totalOccupancy);
        }
        
        NSArray* notifications = [NSArray arrayWithObjects:result.data.channels, result.data.totalChannels, nil];
        
        NSError *writeError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON Output: %@", jsonString);
        
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
        
    }];
    
}

- (void)pubNubWhereNow:(CDVInvokedUrlCommand*)command;{
    NSString* uuid = [command.arguments objectAtIndex:0];
    
    [self.client whereNowUUID:uuid withCompletion:^(PNPresenceWhereNowResult *result,
                                                         PNErrorStatus *status) {
        
        if (status) {
            [self handleStatus:status];
        }
        else if (result) {
            NSLog(@"^^^^ Loaded whereNow data: %@", result.data.channels);
        }
        
        NSArray* notifications = [NSArray arrayWithObjects:result.data.channels, nil];
        
        NSError *writeError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON Output: %@", jsonString);
        
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
        
    }];
}

- (void)addMessageAction:(CDVInvokedUrlCommand*)command{
    
    NSString* channelsName = [command.arguments objectAtIndex:0];
    NSNumber* timeToken = [command.arguments objectAtIndex:0];
    NSString* type = [command.arguments objectAtIndex:0];
    NSString* value = [command.arguments objectAtIndex:0];
    
    self.client.addMessageAction()
        .channel(channelsName)
        .messageTimetoken((timeToken))
        .type(type)
        .value(value)
        .performWithCompletion(^(PNAddMessageActionStatus *status) {
            if (!status.isError) {
                /**
                 * Message action successfully added.
                 * Created message action information available here: status.data.action
                 */
            } else {
                if (status.statusCode == 207) {
                    // Message action has been added, but event not published.
                } else {
                    /**
                     * Handle add message action error. Check 'category' property to find out possible
                     * issue because of which request did fail.
                     *
                     * Request can be resent using: [status retry]
                     */
                }
            }
            
            
            NSArray* notifications = [NSArray arrayWithObjects:status.data.action, nil];
            
            NSError *writeError = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"JSON Output: %@", jsonString);
            
            CDVPluginResult* pluginResult = nil;
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
            [pluginResult setKeepCallbackAsBool:YES];
            [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
            
        });
}

- (void)sendMessageWithCompression:(CDVInvokedUrlCommand*)command{
    
    NSString* channelsName = [command.arguments objectAtIndex:0];
    NSString* keys = [command.arguments objectAtIndex:1];
    NSString* message = [command.arguments objectAtIndex:2];

[self.client publish:@{keys: message}
           toChannel:channelsName compressed:YES
      withCompletion:^(PNPublishStatus *status) {
    if (!status.isError) {
        // Message successfully published to specified channel.
    } else {
        // Handle error.
    }
    
    NSArray* notifications = [NSArray arrayWithObjects:status.data, nil];
    
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON Output: %@", jsonString);
    
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
}];

}

- (void)signal:(CDVInvokedUrlCommand*)command{
    
    NSString* channelsName = [command.arguments objectAtIndex:0];
    NSString* keys = [command.arguments objectAtIndex:1];
    NSString* value = [command.arguments objectAtIndex:2];


[self.client signal:@{ keys: value } channel:channelsName
     withCompletion:^(PNSignalStatus *status) {

    if (!status.isError) {
        // Signal successfully sent to specified channel.
    } else {
        /**
         * Handle signal sending error. Check 'category' property to find out possible issue
         * because of which request did fail.
         *
         * Request can be resent using: [status retry];
         */
    }
    
    
    NSArray* notifications = [NSArray arrayWithObjects:status.data, nil];
    
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON Output: %@", jsonString);
    
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
}];
}

- (void)listOfUdidFromChannel:(CDVInvokedUrlCommand*)command{
    
    NSString* channelsName = [command.arguments objectAtIndex:0];

[self.client hereNowForChannel: channelsName withVerbosity:PNHereNowUUID
                    completion:^(PNPresenceChannelHereNowResult *result,
                                 PNErrorStatus *status) {

    // Check whether request successfully completed or not.
    if (!status) {

        /**
         Handle downloaded presence information using:
            result.data.uuids - list of uuids.
            result.data.occupancy - total number of active subscribers.
         */
    }
    else {

        /**
         Handle presence audit error. Check 'category' property to find
         out possible reason because of which request did fail.
         Review 'errorData' property (which has PNErrorData data type) of status
         object to get additional information about issue.

         Request can be resent using: [status retry];
         */
    }
    
    
    NSArray* notifications = [NSArray arrayWithObjects:result.data, nil];
    
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON Output: %@", jsonString);
    
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
}];
}

- (void)listOfSubcribedUdid:(CDVInvokedUrlCommand*)command{

[self.client whereNowUUID:self.client.uuid withCompletion:^(PNPresenceWhereNowResult *result,
                                                            PNErrorStatus *status) {

    if (!status) {

        // Handle downloaded presence 'where now' information using: result.data.channels
    }
    else {

        /**
         Handle presence audit error. Check 'category' property
         to find out possible reason because of which request did fail.
         Review 'errorData' property (which has PNErrorData data type) of status
         object to get additional information about issue.

         Request can be resent using: [status retry];
         */
    }
    
    
    NSArray* notifications = [NSArray arrayWithObjects:result.data, nil];
    
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON Output: %@", jsonString);
    
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
    
 }];
}


- (void)historyOfChannel:(CDVInvokedUrlCommand*)command{

    NSString* channelsName = [command.arguments objectAtIndex:0];
    
[self.client historyForChannel: channelsName start:nil end:nil limit:100
                withCompletion:^(PNHistoryResult *result, PNErrorStatus *status) {

    if (!status) {

        /**
         Handle downloaded history using:
            result.data.start - oldest message time stamp in response
            result.data.end - newest message time stamp in response
            result.data.messages - list of messages
         */
    }
    else {

        /**
         Handle message history download error. Check 'category' property
         to find out possible reason because of which request did fail.
         Review 'errorData' property (which has PNErrorData data type) of status
         object to get additional information about issue.

         Request can be resent using: [status retry];
         */
    }
    
    
    NSArray* notifications = [NSArray arrayWithObjects:result.data, nil];
    
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON Output: %@", jsonString);
    
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
}];
}

- (void)historyOfLastThreeMessage:(CDVInvokedUrlCommand*)command{
    
    NSString* channelsName = [command.arguments objectAtIndex:0];

[self.client historyForChannel:channelsName start:nil end:nil limit:3 reverse:YES
                withCompletion:^(PNHistoryResult *result, PNErrorStatus *status) {

    if (!status) {

        /**
         Handle downloaded history using:
            result.data.start - oldest message time stamp in response
            result.data.end - newest message time stamp in response
            result.data.messages - list of messages
         */
    }
    else {

        /**
         Handle message history download error. Check 'category' property
         to find out possible reason because of which request did fail.
         Review 'errorData' property (which has PNErrorData data type) of status
         object to get additional information about issue.

         Request can be resent using: [status retry];
         */
    }
    
    
    NSArray* notifications = [NSArray arrayWithObjects:result.data, nil];
    
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON Output: %@", jsonString);
    
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
    
}];
    
}

- (void)deleteMessageFromChannel:(CDVInvokedUrlCommand*)command{
    
    NSString* channelsName = [command.arguments objectAtIndex:0];
    NSNumber* timeTokenStart = [command.arguments objectAtIndex:1];
    NSNumber* timeTokenEnd = [command.arguments objectAtIndex:2];

self.client.deleteMessage().channel(channelsName).start(timeTokenStart).end(timeTokenEnd)
    .performWithCompletion(^(PNAcknowledgmentStatus *status) {

    if (!status.isError) {
        // Messages within specified time frame has been removed.
    } else {
       /**
        * Handle message history download error. Check 'category' property to find out possible
        * issue because of which request did fail.
        *
        * Request can be resent using: [status retry];
        */
    }
        

        
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Message remove successfully"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
});
}

- (void)messgaeCount:(CDVInvokedUrlCommand*)command{
    
    NSString* channelsName = [command.arguments objectAtIndex:0];
    NSNumber* timeToken = [command.arguments objectAtIndex:1];

self.client.messageCounts().channels(@[channelsName])
    .timetokens(@[timeToken])
    .performWithCompletion(^(PNMessageCountResult *result, PNErrorStatus *status) {

        if (!status.isError) {
            // Client state retrieved number of messages for channels.
        } else {
            /**
             Handle client state modification error. Check 'category' property
             to find out possible reason because of which request did fail.
             Review 'errorData' property (which has PNErrorData data type) of status
             object to get additional information about issue.

             Request can be resent using: [status retry]
            */
        }
        
        
        
        NSArray* notifications = [NSArray arrayWithObjects:result.data, nil];
        
        NSError *writeError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON Output: %@", jsonString);
        
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
        
    });
}

- (void)pushNotificationOnChammel:(CDVInvokedUrlCommand*)command{
    
    NSString* channelsName = [command.arguments objectAtIndex:0];

[self.client addPushNotificationsOnChannels:@[channelsName]
                        withDevicePushToken:self.devicePushToken
                              andCompletion:^(PNAcknowledgmentStatus *status) {

    if (!status.isError) {

    // Handle successful push notification enabling on passed channels.
    }
    else {

        /**
         Handle modification error. Check 'category' property
         to find out possible reason because of which request did fail.
         Review 'errorData' property (which has PNErrorData data type) of status
         object to get additional information about issue.

         Request can be resent using: [status retry];
         */
    }
    

//
//    CDVPluginResult* pluginResult = nil;
//    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"notification enabled successfully"];
//    [pluginResult setKeepCallbackAsBool:YES];
//    [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
}];
}

- (void)enablePushNotification:(CDVInvokedUrlCommand*)command{
    
    NSString* channelsName = [command.arguments objectAtIndex:0];
    NSString* topicName = [command.arguments objectAtIndex:1];

self.client.push().enable()
    .token(self.devicePushToken)
    .channels(@[channelsName])
    .pushType(PNAPNS2Push)
    .environment(PNAPNSProduction)
    .topic(topicName)
    .performWithCompletion(^(PNAcknowledgmentStatus *status) {
        if (!status.isError) {
            // Push notifications successful enabled on passed channels.
        } else {
            /**
             * Handle modification error. Check 'category' property to find out possible issue because
             * of which request did fail.
             *
             * Request can be resent using: [status retry];
             */
        }

        
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"push notification enable sucessfully"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
        
    });
}

- (void)removeAllPushNotification:(CDVInvokedUrlCommand*)command{

    NSString* topicName = [command.arguments objectAtIndex:0];

[self.client removeAllPushNotificationsFromDeviceWithPushToken:self.devicePushToken
                                                      pushType:PNAPNS2Push
                                                   environment:PNAPNSProduction
                                                         topic:topicName
                                                 andCompletion:^(PNAcknowledgmentStatus *status) {

    if (!status.isError) {
        /**
         * Push notification successfully disabled for all channels associated with specified
         * device push token.
         */
    } else {
        /**
         * Handle modification error. Check 'category' property to find out possible issue because
         * of which request did fail.
         *
         * Request can be resent using: [status retry];
         */
    }
    

    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"push notification succesfully disable for all channles"];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
    
}];
}

- (void)getAllChannelsMetaData:(CDVInvokedUrlCommand*)command{

self.client.objects().allChannelsMetadata()
    .start(@"<next from previous request>")
    .includeFields(PNChannelCustomField)
    .includeCount(YES)
    .limit(40)
    .performWithCompletion(^(PNFetchAllChannelsMetadataResult *result, PNErrorStatus *status) {
        if (!status.isError) {
//             * Channels metadata successfully fetched.
//             * Result object has following information:
//             *   result.data.metadata - list of fetched channels metadata,
//             *   result.data.next - cursor bookmark for fetching the next page,
//             *   result.data.prev - cursor bookmark for fetching the previous page,
//             *   result.data.totalCount - total number of associated channel metadata.
        } else {
//             * Handle channels metadata fetch error. Check 'category' property to find out possible
//             * issue because of which request did fail.
//             *
//             * Request can be resent using: [status retry]
             
        }
        
        
        NSArray* notifications = [NSArray arrayWithObjects:result.data, nil];
        
        NSError *writeError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notifications options:NSJSONWritingPrettyPrinted error:&writeError];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON Output: %@", jsonString);
        
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: jsonString];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
        
    });
}

- (void)removeChannelsMetaData:(CDVInvokedUrlCommand*)command{

    NSString* channelsName = [command.arguments objectAtIndex:0];
    
self.client.objects().removeChannelMetadata(channelsName)
    .performWithCompletion(^(PNAcknowledgmentStatus *status) {
        if (!status.isError) {
            // Channel metadata successfully removed.
        } else {
            /**
             * Handle channel metadata remove error. Check 'category' property to find out possible
             * issue because of which request did fail.
             *
             * Request can be resent using: [status retry]
             */
        }
        
        

        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"metaData removed succesfully"];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_callerId];
    });
}

@end
