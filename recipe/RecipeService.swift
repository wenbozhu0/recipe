//
//  RecipeService.swift
//  recipe
//
//
import SwiftUI

struct ApiListResponse: Decodable {
    let meals: [ListItem]
}

struct ListItem: Decodable,Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct ApiDetailResponse: Decodable {
    let meals: [DetailItem]
}

struct DetailItem: Decodable, Hashable {
    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    
    let strSource: String?
    
}

class RecipeService {
    func fetchListData(completion: @escaping(Result<ApiListResponse, Error>) -> Void) {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data{
                do {
                    let response = try JSONDecoder().decode(ApiListResponse.self, from: data)
                    completion(.success(response))
                }catch{
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchDetailData(mealId: String, completion: @escaping(Result<ApiDetailResponse, Error>) -> Void) {
        var requestUrl:String = "https://themealdb.com/api/json/v1/1/lookup.php?i="
        requestUrl = requestUrl + mealId
        let url = URL(string: requestUrl)!
        print(requestUrl)
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data{
                do {
                    let response = try JSONDecoder().decode(ApiDetailResponse.self, from: data)
                    completion(.success(response))
                }catch{
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
