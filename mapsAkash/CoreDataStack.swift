

import Foundation
import CoreData

final class CoreDataStack
{
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // entry point required to access the rest of the stack is managedContext
    lazy var managedContext: NSManagedObjectContext = {  // in-memory scratchpad for working with your managed objects
        return self.storeContainer.viewContext
      }()

      private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
          if let error = error as NSError? {
            print("Unresolved error \(error), \(error.userInfo)")
          }
        }
        return container
      }()

      func saveContext () {
        guard managedContext.hasChanges else { return }
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Unresolved error \(error), \(error.userInfo)")
        }
      }
    }

    

