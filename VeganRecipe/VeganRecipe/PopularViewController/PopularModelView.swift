import Foundation

protocol PopularModelViewProtocol {
    var recipes: [RecipeModel] { get }
    func showFirstRecipes(closure: @escaping () -> Void)
    func showMoreRescipes(closure: @escaping () -> Void)

}

class PopularModelView: PopularModelViewProtocol {

    private var recipesModel = [RecipeModel]()
    private let api: OAIDefaultApi

    var recipes: [RecipeModel] {
        return recipesModel
    }

    init(api: OAIDefaultApi) {
        self.api = api
    }

    func showFirstRecipes(closure: @escaping () -> Void) {
        api.initialSearchComplexRecipe { recipes, error in
            self.recipesModel = recipes
            closure()
        }
    }

    func showMoreRescipes(closure: @escaping () -> Void) {
        api.nextSearchComplexRecipe(recipesModel.count) { recipes, error in
            self.recipesModel += recipes
            closure()
        }
    }
}
