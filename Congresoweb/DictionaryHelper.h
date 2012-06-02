//
//  DictionaryHelper.h
//

#import <Foundation/Foundation.h>

@interface NSDictionary (helper)

- (NSString*) stringForKey:(id)key;

- (NSNumber*) numberForKey:(id)key;

- (NSMutableDictionary*) dictionaryForKey:(id)key;

- (NSMutableArray*) arrayForKey:(id)key;

@end
