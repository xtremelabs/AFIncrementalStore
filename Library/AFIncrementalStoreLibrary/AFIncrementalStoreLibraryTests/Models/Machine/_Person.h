// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Person.h instead.

#import <CoreData/CoreData.h>


extern const struct PersonAttributes {
	__unsafe_unretained NSString *age;
	__unsafe_unretained NSString *height;
	__unsafe_unretained NSString *name;
} PersonAttributes;

extern const struct PersonRelationships {
	__unsafe_unretained NSString *employer;
} PersonRelationships;

extern const struct PersonFetchedProperties {
} PersonFetchedProperties;

@class Comapny;





@interface PersonID : NSManagedObjectID {}
@end

@interface _Person : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PersonID*)objectID;





@property (nonatomic, strong) NSNumber* age;



@property int32_t ageValue;
- (int32_t)ageValue;
- (void)setAgeValue:(int32_t)value_;

//- (BOOL)validateAge:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* height;



@property int32_t heightValue;
- (int32_t)heightValue;
- (void)setHeightValue:(int32_t)value_;

//- (BOOL)validateHeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Comapny *employer;

//- (BOOL)validateEmployer:(id*)value_ error:(NSError**)error_;





@end

@interface _Person (CoreDataGeneratedAccessors)

@end

@interface _Person (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAge;
- (void)setPrimitiveAge:(NSNumber*)value;

- (int32_t)primitiveAgeValue;
- (void)setPrimitiveAgeValue:(int32_t)value_;




- (NSNumber*)primitiveHeight;
- (void)setPrimitiveHeight:(NSNumber*)value;

- (int32_t)primitiveHeightValue;
- (void)setPrimitiveHeightValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (Comapny*)primitiveEmployer;
- (void)setPrimitiveEmployer:(Comapny*)value;


@end
