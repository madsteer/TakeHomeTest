//
//  ContentView.swift
//  TakeHomeTest
//
//  Created by Cory Steers on 9/14/25.
//

import SwiftUI

struct ContentView: View {
    @State private var articles = [Article]()
    
    var body: some View {
        NavigationStack {
            List(articles) { article in
                NavigationLink(value: article) {
                    HStack {
                        AsyncImage(url: article.thumbnail) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            default:
                                Image(systemName: "newspaper")
                            }
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(.rect(cornerRadius: 10))

                        VStack(alignment: .leading) {
                            Text(article.section)
                                .font(.caption.weight(.heavy))

                            Text(article.title)
                        }
                    }
                }
            }
            .navigationTitle("Take Home Test")
            .navigationDestination(for: Article.self, destination: ArticleView.init)
        }
        .task(loadArticles)
    }
    
    func loadArticles() async {
        do {
            let url = URL(string: "https://hws.dev/news")!
//            let url = URL(string: "http://127.0.0.1:8080/news")!
            
            // only if needed
//            let session = URLSession(configuration: .ephemeral)
//            let (data, _) = try await URLSession.session.data(from: url)
            // end only if needed
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            articles = try decoder.decode([Article].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
