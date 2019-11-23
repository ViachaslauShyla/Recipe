//
//  View.swift
//  VeganRecipe
//
//  Created by Slava on 10/26/19.
//  Copyright © 2019 Slava. All rights reserved.
//

import Foundation

class View {

    static func makeLoadingViewFor(_ scrollView: UIScrollView, With indicatorView: UIActivityIndicatorView) -> UIView {
        let view = UIView(frame: CGRect(x: 0,
                                        y: scrollView.contentSize.height,
                                        width: scrollView.contentSize.width,
                                        height: 100))


        view.addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }

    
}


