// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Song.h instead.

#import <CoreData/CoreData.h>


extern const struct SongAttributes {
	__unsafe_unretained NSString *title;
} SongAttributes;

extern const struct SongRelationships {
	__unsafe_unretained NSString *artist;
} SongRelationships;

extern const struct SongFetchedProperties {
} SongFetchedProperties;

@class Artist;



@interface SongID : NSManagedObjectID {}
@end

@interface _Song : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SongID*)objectID;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Artist *artist;

//- (BOOL)validateArtist:(id*)value_ error:(NSError**)error_;





@end

@interface _Song (CoreDataGeneratedAccessors)

@end

@interface _Song (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (Artist*)primitiveArtist;
- (void)setPrimitiveArtist:(Artist*)value;


@end
