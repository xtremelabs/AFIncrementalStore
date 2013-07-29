// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Artist.h instead.

#import <CoreData/CoreData.h>
#import "Person.h"

extern const struct ArtistAttributes {
	__unsafe_unretained NSString *artistDescription;
} ArtistAttributes;

extern const struct ArtistRelationships {
	__unsafe_unretained NSString *songs;
} ArtistRelationships;

extern const struct ArtistFetchedProperties {
} ArtistFetchedProperties;

@class Song;



@interface ArtistID : NSManagedObjectID {}
@end

@interface _Artist : Person {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ArtistID*)objectID;





@property (nonatomic, strong) NSString* artistDescription;



//- (BOOL)validateArtistDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *songs;

- (NSMutableSet*)songsSet;





@end

@interface _Artist (CoreDataGeneratedAccessors)

- (void)addSongs:(NSSet*)value_;
- (void)removeSongs:(NSSet*)value_;
- (void)addSongsObject:(Song*)value_;
- (void)removeSongsObject:(Song*)value_;

@end

@interface _Artist (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveArtistDescription;
- (void)setPrimitiveArtistDescription:(NSString*)value;





- (NSMutableSet*)primitiveSongs;
- (void)setPrimitiveSongs:(NSMutableSet*)value;


@end
