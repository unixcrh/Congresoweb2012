//
//  StringHelper.h
//

#import <Foundation/Foundation.h>

@interface NSString (helper)

- (NSString*)trim;

- (NSString*)urlEncode;

- (NSString*)urlDecode;

@end

