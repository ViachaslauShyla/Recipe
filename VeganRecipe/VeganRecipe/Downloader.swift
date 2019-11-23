//
//  Downloader.swift
//  VeganRecipe
//
//  Created by Slava on 10/24/19.
//  Copyright © 2019 Slava. All rights reserved.
//

import UIKit

class Downloader: NSObject {

    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        return session
    }()

    func downloadWith(_ url: URL, complition: @escaping (URL)->()) {
        session.downloadTask(with: url) { (url, _, _) in
            guard let url = url else { return }
            complition(url)
        }.resume()

    }

}
