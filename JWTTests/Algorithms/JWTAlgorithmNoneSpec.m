//
//  JWTAlgorithmNoneSpec.m
//  JWT
//
//  Created by Lobanov Dmitry on 16.10.15.
//  Copyright © 2015 Karma. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <Base64/MF_Base64Additions.h>
#import "NSData+JWT.h"

#import "JWTAlgorithmNone.h"

SPEC_BEGIN(JWTAlgorithmNoneSpec)

__block JWTAlgorithmNone *algorithm;

beforeEach(^{
    algorithm = [[JWTAlgorithmNone alloc] init];
});

it(@"name is none", ^{
    [[algorithm.name should] equal:@"none"];
});

it(@"should not encode payload and return emptry signature instead", ^{
    NSData *encodedPayload = [algorithm encodePayload:@"payload" withSecret:@"secret"];
    [[[encodedPayload base64Encoding] should] equal:@""];
});

it(@"should not verify JWT with a secret provided", ^{
    NSString *secret = @"secret";
    NSString *signingInput = @"eyJhbGciOiJub25lIn0.eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ";
    NSString *signature = nil;
    
    [[theValue([algorithm verifySignedInput:signingInput withSignature:signature verificationKey:secret]) should] beFalse];
});

it(@"should not verify JWT with a signature provided", ^{
    NSString *secret = nil;
    NSString *signingInput = @"eyJhbGciOiJub25lIn0.eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ";
    NSString *signature = @"signed";
    
    [[theValue([algorithm verifySignedInput:signingInput withSignature:signature verificationKey:secret]) should] beFalse];
});

it(@"should verify JWT with no signature and no secret provided", ^{
    NSString *secret = nil;
    NSString *signingInput = @"eyJhbGciOiJub25lIn0.eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFtcGxlLmNvbS9pc19yb290Ijp0cnVlfQ";
    NSString *signature = nil;
    
    [[theValue([algorithm verifySignedInput:signingInput withSignature:signature verificationKey:secret]) should] beTrue];
});

SPEC_END