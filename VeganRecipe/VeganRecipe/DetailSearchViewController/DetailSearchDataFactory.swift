import Foundation

struct DetailSearchData {
    static let types = ["main course", "side dish", "dessert", "appetizer", "salad", "bread", "breakfast", "soup", "beverage", "sauce", "marinade", "fingerfood", "snack", "drink"]

    static let cuisines = ["African","American","British","Cajun","Caribbean","Chinese","Eastern European","European","French","German","Greek","Indian","Irish","Italian","Japanese","Jewish","Korean","Latin American","Mediterranean","Mexican","Middle Eastern","Nordic","Southern","Spanish","Thai","Vietnamese"]

    static let intolerances = ["Dairy","Egg","Gluten","Grain","Peanut","Seafood","Sesame","Shellfish","Soy","Sulfite","Tree Nut","Wheat"]
    

}


class DetailSearchDataFactory {

    private static func createLabels(from data: [String]) -> [UILabel] {
        return data.map { type in
            let label = UILabel()
            label.text = type
            label.textAlignment = .center
            label.layer.cornerRadius = 5
            label.layer.masksToBounds = true
            return label
        }
    }


    static func getTypesDetailLabels() -> [UILabel] {
        return createLabels(from: DetailSearchData.types)
    }

    static func getCuisinesDetailLabels() -> [UILabel] {
        return createLabels(from: DetailSearchData.cuisines)
    }

    static func getIntolerancesDetailLabels() -> [UILabel] {
        return createLabels(from: DetailSearchData.intolerances)
    }
}
