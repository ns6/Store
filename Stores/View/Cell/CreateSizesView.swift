//
//  CreateSizesView.swift
//  Stores
//
//  Created by ssion on 3/4/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

class CreateSizesView {
    
    static var instockColor = UIColor(red: 0.200, green: 0.318, blue: 0.525, alpha: 1.0)
    static var soldColor = UIColor.green//UIColor.init(red: 1, green: 224, blue: 1, alpha: 1)
    
    static func createLabel(text: String, color: UIColor) -> UILabel {
        let textLabel = UILabel()
        textLabel.minimumScaleFactor = 0.7
        textLabel.textColor = color
        textLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        textLabel.text  = text
        textLabel.textAlignment = .center
        return textLabel
    }
    
    static func createStackView() -> UIStackView {
        let stackView   = UIStackView()
        stackView.axis  = UILayoutConstraintAxis.vertical
        stackView.distribution  = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing   = 2.0
        return stackView
    }
    
    static func configureSizes(sizes: [Size], soldSizes: [Size], stackView verticalStackView: UIStackView) {
        for size in sizes {
            let stackView = createStackView()
            let soldSize = soldSizes.filter{ $0.size == size.size }.first
            var sizesCountTotal = size.count + (soldSize?.count ?? 0)
            if sizesCountTotal > 5 { sizesCountTotal = 5 }
            for index in 0..<sizesCountTotal {
                if( index < size.count ) {
                    //instock
                    stackView.addArrangedSubview(createLabel(text: size.size, color: instockColor))
                } else {
                    //sold
                    stackView.addArrangedSubview(createLabel(text: size.size, color: soldColor))
                }
            }
            verticalStackView.addArrangedSubview(stackView)
        }
    }
    
    static func clearStackView(stackView: UIStackView) {
        let countArrangedSubviews = stackView.arrangedSubviews.count
        for _ in 0..<countArrangedSubviews {
            if let subView = stackView.arrangedSubviews.first as? UIStackView {
                subView.isHidden = true
            }
            stackView.removeArrangedSubview(stackView.arrangedSubviews.first!)
        }
    }
    
}
