//
//  JWTAlgorithmHS384Spec.m
//  JWT
//
//  Created by Lobanov Dmitry on 06-02-16.
//  Copyright (c) 2016 lolgear. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <Base64/MF_Base64Additions.h>

#import "JWTAlgorithmHS384.h"


SPEC_BEGIN(JWTAlgorithmHS384Spec)

__block JWTAlgorithmHS384 *algorithm;

beforeEach(^{
    algorithm = [[JWTAlgorithmHS384 alloc] init];
});

it(@"name is HS384", ^{
    [[algorithm.name should] equal:@"HS384"];
});

it(@"HMAC encodes the payload using SHA384", ^{
    NSData *encodedPayload = [algorithm encodePayload:@"payload" withSecret:@"secret"];
    [[[encodedPayload base64String] should] equal:@"s62aZf5ZLMSvjtBQpY4kiJbYxSu8wLAUop2D9nod5Eqgd+nyUCEj+iaDuVuI4gaJ"];
});

it(@"should verify JWT with valid signature and secret", ^{
    NSString *secret = @"secret";
    NSString *signingInput = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9";
    NSString *signature = @"hnzqaUFa2kfSFnynQ_WBJ7-wpLCgsyEdilCkRKliadjVuG-hGnc1qhvIjlvxSie5";
    
    [[theValue([algorithm verifySignedInput:signingInput withSignature:signature verificationKey:secret]) should] beTrue];
});

it(@"should fail to verify JWT with invalid secret", ^{
    NSString *secret = @"notTheSecret";
    NSString *signingInput = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9";
    NSString *signature = @"hnzqaUFa2kfSFnynQ_WBJ7-wpLCgsyEdilCkRKliadjVuG-hGnc1qhvIjlvxSie5";
    
    [[theValue([algorithm verifySignedInput:signingInput withSignature:signature verificationKey:secret]) should] beFalse];
});

it(@"should fail to verify JWT with invalid signature", ^{
    NSString *secret = @"secret";
    NSString *signingInput = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9";
    NSString *signature = nil;
    
    [[theValue([algorithm verifySignedInput:signingInput withSignature:signature verificationKey:secret]) should] beFalse];
});

SPEC_END