//
//  SearchManager.swift
//  VeganRecipe
//
//  Created by Slava on 11/1/19.
//  Copyright © 2019 Slava. All rights reserved.
//

import Foundation

struct ConstantName {
    static let quary = "quary"
    static let cuisine = "cuisine"
    static let excludeCuisine = "excludeCuisine"
    static let diet = "diet"
    static let intolerances = "intolerances"
    static let equipment = "equipment"
    static let includeIngredients = "includeIngredients"
    static let excludeIngredients = "excludeIngredients"
    static let type = "type"
    static let instructionsRequired = "instructionsRequired"
    static let fillIngredients = "fillIngredients"
    static let addRecipeInformation = "addRecipeInformation"
    static let sort = "sort"
    static let offset = "offset"
}


class SearchManager {

    let api: OAIDefaultApi

    init() {
        self.api = OAIDefaultApi()
    }

    func initialSearchComplexRecipe(complition: @escaping ([RecipeModel]) -> Void) {
        let request: [String : Any] = [ConstantName.sort: "popularity",
                                       ConstantName.diet: "Gluten Free",
                                       ConstantName.offset: 0 ]
        searchRecipesComplexWith(dictionary: request, complition: complition)
    }

    func nextSearchComplexRecipe(offset: Int, complition: @escaping ([RecipeModel]) -> Void) {
        let request: [String : Any] = [ConstantName.sort: "popularity",
                                       ConstantName.diet: "Vegan",
                                       ConstantName.offset: offset ]
        searchRecipesComplexWith(dictionary: request, complition: complition)
    }

    func downloadImageDataBy(url: URL, downloadProgress: @escaping (Progress?) -> (), complition: @escaping (UIImage?) -> ()) {

        api.downloadImageData(by:url , downloadProgress: downloadProgress) { (data, isCache, error) in
            if let data = data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    complition(image)
                }
            } else {
                complition(nil)
            }
        }


    }

    func getRecipeInformation(id: NSNumber, complition: @escaping (NSDictionary) -> ()) {
        api.getRecipeInformation(withId: id, includeNutrition: NSNumber(value: false)) { (object, error) in
            guard let result = object as? NSDictionary else {
                print(error?.localizedDescription ?? "error recipe information")
                return
            }
            complition(result)
        }
    }




   private func searchRecipesComplexWith(dictionary: Dictionary<String, Any>, complition: @escaping ([RecipeModel]) -> ()) {
        func valueFor(key: String) -> Any? {
            guard let v = dictionary[key] else {
                return nil
            }
            return v
        }
        let quary = dictionary[ConstantName.quary] as? String ?? ""
        api.searchRecipesComplex(withQuery:quary ,
                                 cuisine: valueFor(key: ConstantName.cuisine) as? String,
                                 excludeCuisine: valueFor(key: ConstantName.excludeCuisine) as? String,
                                 diet: valueFor(key: ConstantName.diet) as? String,
                                 intolerances: valueFor(key: ConstantName.intolerances) as? String,
                                 equipment: valueFor(key: ConstantName.equipment) as? String,
                                 includeIngredients: valueFor(key: ConstantName.includeIngredients) as? String,
                                 excludeIngredients: valueFor(key: ConstantName.excludeIngredients) as? String,
                                 type: valueFor(key: ConstantName.type) as? String,
                                 instructionsRequired: nil,
                                 fillIngredients: nil,
                                 addRecipeInformation: nil,
                                 author: nil,
                                 tags: nil,
                                 titleMatch: nil,
                                 sort: valueFor(key: ConstantName.sort) as? String,
                                 sortDirection: nil,
                                 minCarbs: nil,
                                 maxCarbs: nil,
                                 minProtein: nil,
                                 maxProtein: nil,
                                 minCalories: nil,
                                 maxCalories: nil,
                                 minFat: nil,
                                 maxFat: nil,
                                 minAlcohol: nil,
                                 maxAlcohol: nil,
                                 minCaffeine: nil,
                                 maxCaffeine: nil,
                                 minCopper: nil,
                                 maxCopper: nil,
                                 minCalcium: nil,
                                 maxCalcium: nil,
                                 minCholine: nil,
                                 maxCholine: nil,
                                 minCholesterol: nil,
                                 maxCholesterol: nil,
                                 minFluoride: nil,
                                 maxFluoride: nil,
                                 minSaturatedFat: nil,
                                 maxSaturatedFat: nil,
                                 minVitaminA: nil,
                                 maxVitaminA: nil,
                                 minVitaminC: nil,
                                 maxVitaminC: nil,
                                 minVitaminD: nil,
                                 maxVitaminD: nil,
                                 minVitaminE: nil,
                                 maxVitaminE: nil,
                                 minVitaminK: nil,
                                 maxVitaminK: nil,
                                 minVitaminB1: nil,
                                 maxVitaminB1: nil,
                                 minVitaminB2: nil,
                                 maxVitaminB2: nil,
                                 minVitaminB5: nil,
                                 maxVitaminB5: nil,
                                 minVitaminB3: nil,
                                 maxVitaminB3: nil,
                                 minVitaminB6: nil,
                                 maxVitaminB6: nil,
                                 minVitaminB12: nil,
                                 maxVitaminB12: nil,
                                 minFiber: nil,
                                 maxFiber: nil,
                                 minFolate: nil,
                                 maxFolate: nil,
                                 minFolicAcid: nil,
                                 maxFolicAcid: nil,
                                 minIodine: nil,
                                 maxIodine: nil,
                                 minIron: nil,
                                 maxIron: nil,
                                 minMagnesium: nil,
                                 maxMagnesium: nil,
                                 minManganese: nil,
                                 maxManganese: nil,
                                 minPhosphorus: nil,
                                 maxPhosphorus: nil,
                                 minPotassium: nil,
                                 maxPotassium: nil,
                                 minSelenium: nil,
                                 maxSelenium: nil,
                                 minSodium: nil,
                                 maxSodium: nil,
                                 minSugar: nil,
                                 maxSugar: nil,
                                 minZinc: nil,
                                 maxZinc: nil,
                                 offset: NSNumber(value: dictionary[ConstantName.offset] as? Int ?? 0),
                                 number: nil,
                                 limitLicense: nil) { (object, error) in
                                    guard let object = object as? [RecipeModel] else {
                                        print(error?.localizedDescription ?? "error complex search")
                                        return
                                    }
                                    complition(object)
        }



    }

}
