// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Comapny.h instead.

#import <CoreData/CoreData.h>


extern const struct ComapnyAttributes {
	__unsafe_unretained NSString *name;
} ComapnyAttributes;

extern const struct ComapnyRelationships {
	__unsafe_unretained NSString *employees;
} ComapnyRelationships;

extern const struct ComapnyFetchedProperties {
} ComapnyFetchedProperties;

@class Person;



@interface ComapnyID : NSManagedObjectID {}
@end

@interface _Comapny : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ComapnyID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *employees;

- (NSMutableSet*)employeesSet;





@end

@interface _Comapny (CoreDataGeneratedAccessors)

- (void)addEmployees:(NSSet*)value_;
- (void)removeEmployees:(NSSet*)value_;
- (void)addEmployeesObject:(Person*)value_;
- (void)removeEmployeesObject:(Person*)value_;

@end

@interface _Comapny (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveEmployees;
- (void)setPrimitiveEmployees:(NSMutableSet*)value;


@end
