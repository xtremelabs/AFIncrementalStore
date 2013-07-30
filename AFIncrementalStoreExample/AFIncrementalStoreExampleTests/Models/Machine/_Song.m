// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Song.m instead.

#import "_Song.h"

const struct SongAttributes SongAttributes = {
	.title = @"title",
};

const struct SongRelationships SongRelationships = {
	.artist = @"artist",
};

const struct SongFetchedProperties SongFetchedProperties = {
};

@implementation SongID
@end

@implementation _Song

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Song" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Song";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Song" inManagedObjectContext:moc_];
}

- (SongID*)objectID {
	return (SongID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic title;






@dynamic artist;

	






@end
