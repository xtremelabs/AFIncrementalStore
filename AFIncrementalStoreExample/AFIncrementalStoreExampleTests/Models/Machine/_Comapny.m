// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Comapny.m instead.

#import "_Comapny.h"

const struct ComapnyAttributes ComapnyAttributes = {
	.name = @"name",
};

const struct ComapnyRelationships ComapnyRelationships = {
	.employees = @"employees",
};

const struct ComapnyFetchedProperties ComapnyFetchedProperties = {
};

@implementation ComapnyID
@end

@implementation _Comapny

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Company";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Company" inManagedObjectContext:moc_];
}

- (ComapnyID*)objectID {
	return (ComapnyID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic employees;

	
- (NSMutableSet*)employeesSet {
	[self willAccessValueForKey:@"employees"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"employees"];
  
	[self didAccessValueForKey:@"employees"];
	return result;
}
	






@end
