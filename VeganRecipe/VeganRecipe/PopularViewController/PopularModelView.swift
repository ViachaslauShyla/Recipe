

import Foundation

protocol PopularModelViewProtocol {
    var recipes: [RecipeModel] { get }
    func uploadRecipes(closure: @escaping () -> Void)

}

class PopularModelView: PopularModelViewProtocol {

    private var recipesModel = [RecipeModel]()
    let api: OAIDefaultApi

    var recipes: [RecipeModel] {
        return recipesModel
    }


    init(api: OAIDefaultApi) {
        self.api = api
    }

    func uploadRecipes(closure: @escaping () -> Void) {
        api.initialSearchComplexRecipe { recipes, error in
            self.recipesModel = recipes
            closure()
        }
    }
}
