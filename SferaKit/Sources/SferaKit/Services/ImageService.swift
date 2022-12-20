//
//  ImageService.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import Foundation

final class ImageService {
    
    static let shared = ImageService()
    private init() {}
    
    private var images = [String]()
    
    func fetchImages() -> [String] {
        return images
    }
    
    func putImages(_ data: [String]) {
        images = data
    }
}
