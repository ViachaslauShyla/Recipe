//
//  PopularCollectionViewCell.swift
//  VeganRecipe
//
//  Created by Slava on 10/23/19.
//  Copyright © 2019 Slava. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {

    var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .gray)
        ai.translatesAutoresizingMaskIntoConstraints = false

        return ai
    }()

    var imageView: UIImageView = {
        let im = UIImageView(frame: CGRect.zero)
        im.translatesAutoresizingMaskIntoConstraints = false


        return im
    }()

    var titleLabel: UILabel = {
        let l = UILabel(frame: CGRect.zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Optima-Bold", size: 30)
      //  l.shadowColor = UIColor.black
      //  l.shadowOffset = CGSize(width: -0.5, height: -1.0)
        l.textColor = UIColor.white
        l.numberOfLines = 0

        return l
    }()

    override init(frame: CGRect) {
        super .init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    //MARK - Private Methods
    private func commonInit() {
        self.addSubview(imageView)

        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        let alphaViewTitle = UIView(frame: CGRect.zero)
        alphaViewTitle.translatesAutoresizingMaskIntoConstraints = false
        alphaViewTitle.backgroundColor = UIColor.gray
        alphaViewTitle.alpha = 0.2

        self.addSubview(alphaViewTitle)
        self.addSubview(titleLabel)

        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),

            alphaViewTitle.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10),
            alphaViewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            alphaViewTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            alphaViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }

    //MARK: - Public Methods
    func configureWith(image: UIImage?, title: String) {
        self.titleLabel.text = title
        if image != nil {
            self.imageView.image = image
            activityIndicator.stopAnimating()
            activityIndicator.hidesWhenStopped = true
        } else {
            self.imageView.image = UIImage(named: "images")
        }
    }

}
