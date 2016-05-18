//
//  PBFORMToolsTests.m
//  PBFBaseToolsDemo
//
//  Created by BY-MAC01 on 16/5/12.
//  Copyright © 2016年 BY-MAC01. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PBFORMTools.h"

//跟随者类
@interface PBFORMToolsTestModelFollower : NSObject
@property (nonatomic,strong)NSString                *name;
@property (nonatomic,strong)NSNumber                *code;
@end
@implementation PBFORMToolsTestModelFollower
@end

//主类
@interface PBFORMToolsTestModelUser : NSObject
@property (nonatomic,strong)NSMutableDictionary                     *KPBFORMToolsDicArrayName;
@property (nonatomic,strong)NSString                                *name;
@property (nonatomic,strong)NSNumber                                *code;
@property (nonatomic,strong)NSMutableArray                          *followers;
@property (nonatomic,strong)NSArray                                 *date;
@property (nonatomic,strong)PBFORMToolsTestModelFollower            *mainFollower;

@property (nonatomic,strong)NSString                                *strNullTest;
@property (nonatomic,strong)NSNumber                                *nNullTest;
@end
@implementation PBFORMToolsTestModelUser
- (instancetype)init{
    self = [super init];
    self.KPBFORMToolsDicArrayName = [[NSMutableDictionary alloc] init];
    [self.KPBFORMToolsDicArrayName setValue:[PBFORMToolsTestModelFollower class] forKey:@"followers"];
    [self.KPBFORMToolsDicArrayName setValue:[NSString class] forKey:@"date"];
    return self;
}
@end

@interface PBFORMToolsTests : XCTestCase

@end

@implementation PBFORMToolsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAssembleByDictionary{
    //构造
    NSMutableDictionary *dicAttUser = [[NSMutableDictionary alloc] init];
    [dicAttUser setValue:@"朱林" forKey:@"name"];
    [dicAttUser setValue:[NSNumber numberWithInt:123456] forKey:@"code"];
    //followers
    NSMutableDictionary *dicAttFollower1 = [[NSMutableDictionary alloc] init];
    [dicAttFollower1 setValue:@"张三" forKey:@"name"];
    [dicAttFollower1 setValue:[NSNumber numberWithInt:456] forKey:@"code"];
    NSMutableDictionary *dicAttFollower2 = [[NSMutableDictionary alloc] init];
    [dicAttFollower2 setValue:@"李四" forKey:@"name"];
    [dicAttFollower2 setValue:[NSNumber numberWithInt:789] forKey:@"code"];
    NSArray *arrFollowers = [NSArray arrayWithObjects:dicAttFollower1,dicAttFollower2, nil];
    [dicAttUser setValue:arrFollowers forKey:@"followers"];
    //date
    NSArray *arrDates = [NSArray arrayWithObjects:@"hello",@"world", nil];
    [dicAttUser setValue:arrDates forKey:@"date"];
    //mainFollower
    NSMutableDictionary *dicAttFollowerMain = [[NSMutableDictionary alloc] init];
    [dicAttFollowerMain setValue:@"王五" forKey:@"name"];
    [dicAttFollowerMain setValue:[NSNumber numberWithDouble:789.23] forKey:@"code"];
    [dicAttUser setValue:dicAttFollowerMain forKey:@"mainFollower"];
    
#pragma mark - 默认方式
    PBFORMToolsTestModelUser *userInfoDefault = [[PBFORMToolsTestModelUser alloc] init];
    [PBFORMTools assembleDictionaryData:userInfoDefault objRes:dicAttUser];
    //断言
    XCTAssertEqual(userInfoDefault.name, @"朱林",@"name error");
    XCTAssertEqual([userInfoDefault.code integerValue], 123456,@"code error");
    XCTAssertEqual([userInfoDefault.followers count],2 ,@"followers error");
    XCTAssertEqual([userInfoDefault.date count],2 ,@"date error");
    XCTAssertEqual(userInfoDefault.mainFollower.name, @"王五",@"mainFollower.name error");
    XCTAssertEqual([userInfoDefault.mainFollower.code doubleValue], 789.23,@"mainFollower.code error");
    XCTAssertNil(userInfoDefault.strNullTest);
    XCTAssertNil(userInfoDefault.nNullTest);
    
#pragma mark - 初始化方式
    PBFORMToolsTestModelUser *userInfo = [[PBFORMToolsTestModelUser alloc] init];
    [PBFORMTools assembleDictionaryData:userInfo objRes:dicAttUser mode:PBFORMToolsAssembleModelInitNull];
    //断言
    XCTAssertEqual(userInfo.name, @"朱林",@"name error");
    XCTAssertEqual([userInfo.code integerValue], 123456,@"code error");
    XCTAssertEqual([userInfo.followers count],2 ,@"followers error");
    XCTAssertEqual([userInfo.date count],2 ,@"date error");
    XCTAssertEqual(userInfo.mainFollower.name, @"王五",@"mainFollower.name error");
    XCTAssertEqual([userInfo.mainFollower.code doubleValue], 789.23,@"mainFollower.code error");
    XCTAssertNotNil(userInfo.strNullTest);
    XCTAssertNotNil(userInfo.nNullTest);
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
