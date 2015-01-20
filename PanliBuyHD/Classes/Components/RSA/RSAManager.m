//
//  RSAManager.m
//  PanliApp
//
//  Created by Liubin on 13-8-7.
//  Copyright (c) 2013年 Panli. All rights reserved.
//

#import "RSAManager.h"
#import "NSData+Base64.h"

@implementation RSAManager

+ (SecKeyRef)getPublicKey
{
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"PanliMobile" ofType:@"cer"];
    SecCertificateRef myCertificate = nil;
    NSData *certificateData = [[[NSData alloc] initWithContentsOfFile:certPath] autorelease];
    myCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (CFDataRef)certificateData);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
    SecTrustResultType trustResult;
    if (status == noErr) {
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    return SecTrustCopyPublicKey(myTrust);
}

+ (NSData *)encryptToData:(NSString *)plainText error:(NSError **)err
{
    SecKeyRef key = [self getPublicKey];
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = NULL;
    cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    memset((void *)cipherBuffer, 0x0, cipherBufferSize);
    NSData *plainTextBytes = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    int blockSize = (int)cipherBufferSize - 11;
    int numBlock = (int)ceil([plainTextBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [[[NSMutableData alloc] init] autorelease];
    for (int i=0; i<numBlock; i++) {
        int bufferSize = (int)MIN(blockSize,[plainTextBytes length] - i * blockSize);
        NSData *buffer = [plainTextBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(key, kSecPaddingPKCS1,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length], cipherBuffer,
                                        &cipherBufferSize);
        if (status == noErr)
        {
            NSData *encryptedBytes = [[[NSData alloc]
                                       initWithBytes:(const void *)cipherBuffer
                                       length:cipherBufferSize] autorelease];
            [encryptedData appendData:encryptedBytes];
        }
        else
        {
            *err = [NSError errorWithDomain:@"errorDomain" code:status userInfo:nil];
            DLOG(@"encrypt: Error: %d",(int)status);
            return nil;
        }
    }
    if (cipherBuffer)
    {
        free(cipherBuffer);
    }
    return encryptedData;
}

+ (NSString *)encryptToString:(NSString *)plainText error:(NSError **)err
{
    NSData *data = [self encryptToData:plainText error:err];
    return [data base64EncodedStringWithSeparateLines:false];
}

@end
