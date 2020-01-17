

import Foundation
import CoreData
import CoreLocation

extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    // attributes of location entity
    @NSManaged public var mapTitle: String?
    @NSManaged public var mapSubTitle: String?
    @NSManaged public var mapLatutude: Double
    @NSManaged public var mapLongitude: Double

}
