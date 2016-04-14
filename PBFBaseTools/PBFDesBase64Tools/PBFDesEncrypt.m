//
//  PBFDesEncrypt.m
//  BoyingCaptial
//
//  Created by BY-MAC01 on 15/10/12.
//  Copyright © 2015年 BY-MAC01. All rights reserved.
//

#import "PBFDesEncrypt.h"
#import "GTMBase64.h"

@interface PBFDesEncrypt()

@end

@implementation PBFDesEncrypt

+ (NSString *)encrypt:(NSString *)sText key:(NSString *)key iv:(NSString*)iv
{
    NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
    const void *dataIn = (const void *)[encryptData bytes];
    size_t dataInLength = [encryptData length];
    
    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码
     */
    
    size_t dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    uint8_t *dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    
    size_t dataOutMoved = 0;
    
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    const void *vkey = (const void *) [key UTF8String];
    const void *ivPtr = (const void *) [iv UTF8String];
    
    //CCCrypt函数 加密
    CCCrypt(kCCEncrypt,//  加密
            kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
            kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
            vkey,  //密钥
            kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
            ivPtr, //  可选的初始矢量
            dataIn, // 数据的存储单元
            dataInLength,// 数据的大小
            (void *)dataOut,// 用于返回数据
            dataOutAvailable,
            &dataOutMoved);
    
    //编码 base64
    NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
    NSString *result = [GTMBase64 stringByEncodingData:data];
    
    return result;
}



@end