//
//  ViewController.swift
//  VeganRecipe
//
//  Created by Slava on 9/2/19.
//  Copyright © 2019 Slava. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var api = ApiRequestWrapper(api: OAIDefaultApi())
   
    var dataSource = [RecipeModel]() {
        didSet {
           print("count - \(self.dataSource.count)")
            if !self.dataSource.isEmpty {
            print("id - \(self.dataSource[self.dataSource.count - 1].idRecipe)")
            }
        }
    }
    
    @IBAction func nutritionGotten(_ sender: UIButton) {
           print("nutrition9 - \(self.dataSource[9].nutrition.calories)")
         print("nutrition8 - \(self.dataSource[8].nutrition.calories)")
         print("nutrition7 - \(self.dataSource[7].nutrition.calories)")
    }
    @IBAction func button1(_ sender: UIButton) {
        for recipe in self.dataSource {
            api.getRecipeInformation(id: recipe.idRecipe) { [weak self] (data) in
                
                if let data = data as? [String: Any] {
                    recipe.fillFullData(data)
                    print("dishType - \(recipe.dishTypes)")
                    print("ingredient - \(recipe.ingredients.count)")
                    print("nutrition7 - \(recipe.nutrition.calories)")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Request for popular, and search (what want put in requests-dictionary)
        let requests: [String : Any] = [ConstantName.sort: "popularity",
                                        ConstantName.diet: "Vegan",
                                        ConstantName.offset: 0 ]
        api.searchRecipesComplexWith(dictionary: requests) { [weak self] object in
            
            guard let recipe = object as? RecipeModel else {
                return
            }
            self?.dataSource.append(recipe)
        }
        
        
        
    }


}

