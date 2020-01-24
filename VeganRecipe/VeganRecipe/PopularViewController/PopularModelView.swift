import Foundation

protocol PopularModelViewProtocol {
    var recipes: [Recipe] { get }
    func showFirstRecipes(closure: @escaping () -> Void)
    func showMoreRescipes(closure: @escaping () -> Void)

}

class PopularModelView: PopularModelViewProtocol {

    private var recipesModel = [Recipe]()
    private let api: OAIDefaultApi

    var recipes: [Recipe] {
        return recipesModel
    }

    init(api: OAIDefaultApi) {
        self.api = api
    }

    func showFirstRecipes(closure: @escaping () -> Void) {
        api.loadRecipes(0) { recipes, error in
            self.recipesModel += recipes
            closure()
        }
    }

    func showMoreRescipes(closure: @escaping () -> Void) {
        api.loadRecipes(recipesModel.count) { recipes, error in
            self.recipesModel += recipes
            closure()
        }
    }
}
