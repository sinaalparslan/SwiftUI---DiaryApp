//
//  PersistanceController.swift
//  Diary
//
//  Created by sina on 18.02.2024.
//

import SwiftUI
import CoreData

struct PersistanceController: View {
    static let shared = PersistanceController()
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext{
        return container.viewContext
    }
    init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "Diary")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved\(error),\(error.userInfo)")
            }}
        )
    }
    func getByItems(query:String, handler: @escaping([Item])-> Void){
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)]
        if !query.isEmpty{

            let predicateFirst = NSPredicate(format: "%K BEGINSWITH[cd] %@",#keyPath(Item.title),query)
            let predicateSecond = NSPredicate(format: "%K BEGINSWITH[cd] %@",#keyPath(Item.explanation),query)
            let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicateFirst,predicateSecond])
            request.predicate = predicate      }
        do {
            let result = try viewContext.fetch(request)
            handler(result)
        }catch let error{
            print(error.localizedDescription)
            handler([])
        }
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PersistanceController()
}
