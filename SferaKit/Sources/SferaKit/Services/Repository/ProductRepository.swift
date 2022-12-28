//
//  ProductRepository.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import CoreData

protocol ProductRepositoryInputProtocol {
    func save(_ products: [Product])
    func retrieve() -> [Product]    
}

final class ProductRepository: ProductRepositoryInputProtocol {
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        guard let modelURL = Bundle.module.url(forResource: "ProductsData", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else { return NSPersistentContainer() }
        
        let container = NSPersistentCloudKitContainer(name: "ProductsData", managedObjectModel: model)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    //MARK: - Public methods
    func save(_ products: [Product]) {
        
        deleteEntity()
        
        for i in products {
            let product = NSEntityDescription.insertNewObject(forEntityName: "ProductEntity", into: viewContext)
            product.setValue(i.id, forKey: "id")
            product.setValue(i.name, forKey: "name")
            product.setValue(i.category, forKey: "category")
            product.setValue(i.itemDescription, forKey: "itemDescription")
            product.setValue(i.image, forKey: "image")
            product.setValue(i.price, forKey: "price")
            product.setValue(i.count, forKey: "count")
        }
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error")
            }
        }
    }
    
    func retrieve() -> [Product] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
        var products: [Product] = []
        do {
            if let data = try viewContext.fetch(fetchRequest) as? [ProductEntity] {
                for i in data {
                    let product = Product(
                        id: Int(i.id),
                        name: i.name ?? "",
                        category: i.category ?? "",
                        itemDescription: i.itemDescription ?? "",
                        image: i.image ?? "",
                        price: Int(i.price),
                        count: Int(i.count)
                    )
                    products.append(product)
                }
            }
        } catch {
            print("Error")
        }
        return products
    }
    
    private func deleteEntity() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ProductEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try viewContext.execute(deleteRequest)
        } catch {
            print("Error")
        }
    }
}
