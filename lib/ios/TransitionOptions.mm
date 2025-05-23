#import "TransitionOptions.h"
#import "RNNUtils.h"

@implementation TransitionOptions

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];

    self.alpha = [[TransitionDetailsOptions alloc] initWithDict:dict[@"alpha"]];
    self.x = [[TransitionDetailsOptions alloc] initWithDict:dict[@"x"]];
    self.y = [[TransitionDetailsOptions alloc] initWithDict:dict[@"y"]];
    self.scaleX = [[TransitionDetailsOptions alloc] initWithDict:dict[@"scaleX"]];
    self.scaleY = [[TransitionDetailsOptions alloc] initWithDict:dict[@"scaleY"]];
    self.translationX = [[TransitionDetailsOptions alloc] initWithDict:dict[@"translationX"]];
    self.translationY = [[TransitionDetailsOptions alloc] initWithDict:dict[@"translationY"]];
    self.rotationX = [[TransitionDetailsOptions alloc] initWithDict:dict[@"rotationX"]];
    self.rotationY = [[TransitionDetailsOptions alloc] initWithDict:dict[@"rotationY"]];

	self.waitForRender = [Bool withValue:[[BoolParser parse:dict key:@"waitForRender"] withDefault:[RNNUtils getDefaultWaitForRender]]];
    self.enable = [BoolParser parse:dict key:@"enabled"];

    return self;
}

- (void)mergeOptions:(TransitionOptions *)options {
    [self.alpha mergeOptions:options.alpha];
    [self.x mergeOptions:options.x];
    [self.y mergeOptions:options.y];
    [self.scaleX mergeOptions:options.scaleX];
    [self.scaleY mergeOptions:options.scaleY];
    [self.translationX mergeOptions:options.translationX];
    [self.translationY mergeOptions:options.translationY];
    [self.rotationX mergeOptions:options.rotationX];
    [self.rotationY mergeOptions:options.rotationY];

    if (options.enable.hasValue)
        self.enable = options.enable;
    if (options.waitForRender.hasValue)
        self.waitForRender = options.waitForRender;
}

- (BOOL)hasAnimation {
    return self.x.hasAnimation || self.y.hasAnimation || self.alpha.hasAnimation ||
           self.scaleX.hasAnimation || self.scaleY.hasAnimation ||
           self.translationX.hasAnimation || self.translationY.hasAnimation ||
           self.rotationX.hasAnimation || self.rotationY.hasAnimation;
}

- (BOOL)hasValue {
    return self.x.hasAnimation || self.y.hasAnimation || self.alpha.hasAnimation ||
           self.scaleX.hasAnimation || self.scaleY.hasAnimation ||
           self.translationX.hasAnimation || self.translationY.hasAnimation ||
           self.rotationX.hasAnimation || self.rotationY.hasAnimation ||
           self.waitForRender.hasValue || self.enable.hasValue;
}

- (BOOL)shouldWaitForRender {
	return [self.waitForRender withDefault:[RNNUtils getDefaultWaitForRender]] || self.hasAnimation;
}

- (NSTimeInterval)maxDuration {
    double maxDuration = 0;
    if ([_x.duration withDefault:0] > maxDuration) {
        maxDuration = [_x.duration withDefault:0];
    }

    if ([_y.duration withDefault:0] > maxDuration) {
        maxDuration = [_y.duration withDefault:0];
    }

    if ([_scaleX.duration withDefault:0] > maxDuration) {
        maxDuration = [_scaleX.duration withDefault:0];
    }

    if ([_scaleY.duration withDefault:0] > maxDuration) {
        maxDuration = [_scaleY.duration withDefault:0];
    }

    if ([_translationX.duration withDefault:0] > maxDuration) {
        maxDuration = [_translationX.duration withDefault:0];
    }

    if ([_translationY.duration withDefault:0] > maxDuration) {
        maxDuration = [_translationY.duration withDefault:0];
    }

    if ([_rotationX.duration withDefault:0] > maxDuration) {
        maxDuration = [_rotationX.duration withDefault:0];
    }

    if ([_rotationY.duration withDefault:0] > maxDuration) {
        maxDuration = [_rotationY.duration withDefault:0];
    }

    if ([_alpha.duration withDefault:0] > maxDuration) {
        maxDuration = [_alpha.duration withDefault:0];
    }

    return maxDuration;
}

@end
