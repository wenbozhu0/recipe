//
//  ContentView.swift
//  recipe
//
//

import SwiftUI
import URLImage

struct ContentView: View {
    @State private var responseData: ApiListResponse?
    @State private var error: Error?
    @State private var isLoading = false
    
    let apiService = RecipeService()
    
    var recipeListData:[ListItem] = []
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    if let responseData = responseData {
                        let listData = responseData.meals
                        NavigationView {
                            List(listData, id:\.self) { meal in
                                NavigationLink(destination: DetailView(mealId: meal.idMeal)) {
                                    HStack {
                                        URLImage(URL(string: meal.strMealThumb)!) { image in
                                            image.resizable()
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50, height: 50)
                                        }
                                        Text(meal.strMeal)
                                        
                                    }
                                }
                            }
                        }
                    } else if let error = error {
                        Text("error")
                    } else if isLoading {
                        Text("loading")
                    } else {
                        Text("init")
                    }
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .padding()
            }
            
            .onAppear() {
                fetchListData()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func fetchListData() {
        isLoading = true
        apiService.fetchListData { result in
            isLoading = false
            switch result {
            case .success(let success):
                responseData = success
            case .failure(let failure):
                self.error = failure
            }
                
        }
    }
}

#Preview {
    ContentView()
}
