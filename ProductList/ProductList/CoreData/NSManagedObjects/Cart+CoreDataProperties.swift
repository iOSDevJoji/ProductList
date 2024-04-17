//
//  Cart+CoreDataProperties.swift
//  ProductList
//
//  Created by u2233825 on 07/04/24.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var price: Double
    @NSManaged public var discountPercentage: Double
    @NSManaged public var rating: Double
    @NSManaged public var stock: Int32
    @NSManaged public var brand: String?
    @NSManaged public var category: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var selectedImage: String?

}

extension Cart : Identifiable {

}
