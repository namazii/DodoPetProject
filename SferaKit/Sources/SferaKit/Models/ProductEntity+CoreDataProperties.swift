//
//  ProductEntity+CoreDataProperties.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 08.12.2022.
//
//

import CoreData

extension ProductEntity {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }
    
    @NSManaged var category: String?
    @NSManaged var count: Int16
    @NSManaged var id: Int32
    @NSManaged var image: String?
    @NSManaged var itemDescription: String?
    @NSManaged var name: String?
    @NSManaged var price: Int16
    
}

extension ProductEntity : Identifiable {
}
