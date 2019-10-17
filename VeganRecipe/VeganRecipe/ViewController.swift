//
//  ViewController.swift
//  VeganRecipe
//
//  Created by Slava on 9/2/19.
//  Copyright © 2019 Slava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dataSource = [RecipeModel]() {
        didSet {
            print("ADD")
            print("Count - \(self.dataSource.count)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = ApiRequestWrapper(api: OAIDefaultApi())

        // Request for popular, and search (what want put in requests-dictionary)
        let requests: [String : Any] = [ConstantName.sort: "popularity",
                                        ConstantName.diet: "Vegan",
                                        ConstantName.offset: 10 ]
        api.searchRecipesComplexWith(dictionary: requests) { [weak self] object in
            
            guard let recipe = object as? RecipeModel else {
                return
            }
            self?.dataSource.append(recipe)
            

        }
        
    }


}

