//
//  ContentView.swift
//  DadJokes
//
//  Created by Russell Gordon on 2022-02-21.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Stored Properties
    @State var currentQuote: RealQuote = RealQuote(quoteText: "I am always doing that which I cannot do, in order that I may learn how to do it.",
                                                   quoteAuthor: "Pablo Picasso",
                                                   senderName: "",
                                                   senderLink: "",
                                                   quoteLink: "")
    
    var body: some View {
        
        
        VStack {
            
            
            
            Text(currentQuote.quoteText)
                .font(.title2)
                .frame(width: 200, height: 100)
                .multilineTextAlignment(.leading)
                .padding(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.primary, lineWidth: 4)
                )
            
                .padding()
            
            Text("- " + currentQuote.quoteAuthor)
                .font(.caption)
            
            
            
            Image(systemName: "heart.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.gray)
            
            
            Button(action: {
                
                print("I've been pressed!")
                
            }, label: {
                Text("Another one!")
                //.font(.largeTitle)
            })
                .padding()
                .buttonStyle(.bordered)
            
            HStack {
                Text("Favorites")
                    .bold()
                
                Spacer()
            }
            
            List {
                Text("Nothing is a waste of time if you use the experience wisely.")
                Text("If your actions inspire others to dream more, learn more, do more and become more, you are a leader.")
            }
            
            Spacer()
            
        }
        .task {
            
            // Assemble the URL that points to the endpoint
            let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en")!
            
            // Define the type of data we want from the endpoint
            // Configure the request to the web site
            var request = URLRequest(url: url)
            // Ask for JSON data
            request.setValue("application/json",
                             forHTTPHeaderField: "Accept")
            
            // Start a session to interact (talk with) the endpoint
            let urlSession = URLSession.shared
            
            // Try to fetch a new joke
            // It might not work, so we use a do-catch block
            do {
                
                // Get the raw data from the endpoint
                let (data, _) = try await urlSession.data(for: request)
                
                // Attempt to decode the raw data into a Swift structure
                // Takes what is in "data" and tries to put it into "currentJoke"
                //                                 DATA TYPE TO DECODE TO
                //                                         |
                //                                         V
                currentQuote = try JSONDecoder().decode(RealQuote.self, from: data)
                
            } catch {
                print("Could not retrieve or decode the JSON from endpoint.")
                // Print the contents of the "error" constant that the do-catch block
                // populates
                print(error)
            }
            
        }
        .navigationTitle("Quotes")
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
