import Foundation
import UIKit

protocol Storyboardable: class {
    static var defaultStoryboardName: String { get }
    static var defaultStoryboardId: String { get }
}

extension Storyboardable where Self: UIViewController {
    static var defaultStoryboardName: String {
        return "Main"
    }

    static var defaultStoryboardId: String {
        return String(describing: self)
    }
    
    static func storyboardViewController() -> Self {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)
    
        guard let vc = storyboard.instantiateViewController(withIdentifier: defaultStoryboardId) as? Self else {
            fatalError("Could not instantiate initial storyboard with name: \(defaultStoryboardName)")
        }
        
        return vc
    }
}
