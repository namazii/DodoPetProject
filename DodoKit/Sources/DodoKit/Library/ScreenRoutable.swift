//
//  ScreenRoutable.swift
//  DodoPetProject
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit

protocol ScreenRoutable: AnyObject {
    func dismissView(animated: Bool, completion: (() -> Void)?)
    func presentScreen(_ screen: UIViewController, animated: Bool, completion: (() -> Void)?)
    func push(_ screen: UIViewController, animated: Bool, completion: (() -> Void)?)
}

extension ScreenRoutable where Self: UIViewController {
    func dismissView(animated: Bool, completion: (() -> Void)?) {
        presentingViewController?.dismiss(animated: animated, completion: completion)
    }
    
    func presentScreen(_ screen: UIViewController, animated: Bool, completion: (() -> Void)?) {
        present(screen, animated: animated, completion: completion)
    }
    
    func push(_ screen: UIViewController, animated: Bool, completion: (() -> Void)?) {
        screen.modalPresentationStyle = .fullScreen
        present(screen, animated: animated, completion: completion)
    }
}
