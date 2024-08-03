//
//  DetailView.swift
//  recipe
//
//

import Foundation
import SwiftUI
import URLImage
import AVKit


struct DetailView: View {
    var mealId: String
    
    @State private var responseData: ApiDetailResponse?
    @State private var error: Error?
    @State private var isLoading = false
    
    let apiService = RecipeService()
    
    var body: some View {
        ScrollView {
            VStack {
                if let responseData = responseData {
                    let meal = responseData.meals[0]
                    URLImage(URL(string: meal.strMealThumb!)!) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    HStack() {
                        Text("ID:")
                        Spacer()
                        Text(meal.idMeal ?? "")
                    }
                    HStack() {
                        Text("Name:")
                        Spacer()
                        Text(meal.strMeal ?? "")
                    }
                    HStack() {
                        Text("Category:")
                        Spacer()
                        Text(meal.strCategory ?? "")
                    }
                    HStack() {
                        Text("Area:")
                        Spacer()
                        Text(meal.strArea ?? "")
                    }
                    HStack() {
                        Text("Instructions:")
                        Spacer()
                        Text(meal.strInstructions ?? "")
                    }
                    HStack() {
                        Text("Tags:")
                        Spacer()
                        Text(meal.strTags ?? "")
                    }
                    HStack() {
                        Text("Youtube:")
                        Spacer()
                        Text(meal.strYoutube ?? "")
                                        .underline()
                                        .foregroundColor(.blue)
                                        .onTapGesture {
                                            if let url = URL(string: meal.strYoutube ?? "") {
                                                UIApplication.shared.open(url)
                                            }
                                        }
                    }
                    HStack() {
                        Text("Ingredients:")
                        Spacer()
                        VStack() {
                            Text(meal.strIngredient1 ?? "")
                            Text(meal.strIngredient2 ?? "")
                            Text(meal.strIngredient3 ?? "")
                            Text(meal.strIngredient4 ?? "")
                            Text(meal.strIngredient5 ?? "")
                            Text(meal.strIngredient6 ?? "")
                            Text(meal.strIngredient7 ?? "")
                            Text(meal.strIngredient8 ?? "")
                        }
                    }
                    HStack() {
                        Text("Measures:")
                        Spacer()
                        VStack() {
                            Text(meal.strMeasure1 ?? "")
                            Text(meal.strMeasure2 ?? "")
                            Text(meal.strMeasure3 ?? "")
                            Text(meal.strMeasure4 ?? "")
                            Text(meal.strMeasure5 ?? "")
                            Text(meal.strMeasure6 ?? "")
                            Text(meal.strMeasure7 ?? "")
                            Text(meal.strMeasure8 ?? "")
                        }
                    }


                    
                } else if let error = error {
                    Text(error.localizedDescription)
                } else if isLoading {
                    Text("loading")
                } else {
                    Text("loading")
                }
            }
        }
        .padding()
        .onAppear() {
            fetchDetailData(mealId: mealId)
        }
    }
    
    func fetchDetailData(mealId: String) {
        isLoading = true
        apiService.fetchDetailData(mealId:mealId) { result in
            isLoading = false
            switch result {
            case .success(let success):
                responseData = success
            case .failure(let failure):
                print("error")
                print(failure)
                self.error = failure
            }
                
        }
    }
}
