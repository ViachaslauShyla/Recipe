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

    static func makeDetailView(showView: UIView, hideView: UIView) -> UIView {
        let detailView = UIView(frame: CGRect.zero)

        let label = UILabel(frame: CGRect.zero)
        label.text = "Detail"
        label.translatesAutoresizingMaskIntoConstraints = false

        detailView.addSubview(label)
        detailView.addSubview(showView)
        detailView.addSubview(hideView)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: detailView.topAnchor),
            label.leadingAnchor.constraint(equalTo: detailView.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: detailView.bottomAnchor),
            showView.leadingAnchor.constraint(equalTo: label.trailingAnchor),
            showView.topAnchor.constraint(equalTo: detailView.topAnchor),
            showView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
            showView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor),
            hideView.leadingAnchor.constraint(equalTo: label.trailingAnchor),
            hideView.topAnchor.constraint(equalTo: detailView.topAnchor),
            hideView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
            hideView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor),
            label.widthAnchor.constraint(equalTo: showView.widthAnchor, multiplier: 5),
            label.widthAnchor.constraint(equalTo: hideView.widthAnchor, multiplier: 5)
        ])

        return detailView
    }
}


