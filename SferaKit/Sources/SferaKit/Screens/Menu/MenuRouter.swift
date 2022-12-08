//
//  MenuRouter.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit

protocol MenuRouterInput {
    
}

protocol MenuRouterOutput {
    
}

class MenuRouter: MenuRouterInput {
    
    weak var view: ScreenRoutable?
    
    func showProductDetail(product: Product) {
        
        let vc = DetailProductAssembly().configure(with: product)
        
        view?.presentScreen(vc, animated: true, completion: nil)
    }
    
//    func showCities(imageView: UIImageView) {
//        //let vc = CityPopOverAssembly().configure()
//        
//        let popOverCityVC = CityPopOverViewController()
//        popOverCityVC.modalPresentationStyle = .popover
//        popOverCityVC.preferredContentSize = CGSize(width: 200, height: 200)
//        
//        guard let presentionVC = popOverCityVC.popoverPresentationController else { return }
//        presentionVC.delegate = view as! any UIPopoverPresentationControllerDelegate
//        presentionVC.sourceView = imageView
//        presentionVC.permittedArrowDirections = .up
//        presentionVC.sourceRect = CGRect(x: imageView.bounds.midX,
//                                         y: imageView.bounds.midY, width: 0, height: 0)
//        //view?.present(popOverCityVC, animated: true)
//        
//        view?.presentScreen(popOverCityVC, animated: true, completion: nil)
//        
//    }
}
