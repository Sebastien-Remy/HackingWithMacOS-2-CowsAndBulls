//
//  ContentView.swift
//  CowsAndBulls
//
//  Created by Sebastien REMY on 17/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var guess = ""
    @State private var guesses = [String]()
    @State private var answer = ""
    let answerLength = 4
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("Enter a guess…", text: $guess)
                Button("Go", action: submitGuess)
            }
            .padding()
            List(guesses, id: \.self) { guess in
                HStack {
                    Text(guess)
                    Spacer()
                    Text(result(for: guess))
                }
            }
        }
        .frame(width: 250)
        .frame(minWidth: 300, maxHeight: .infinity)
        .onAppear(perform: startNewGame)
    }
    
    func startNewGame() {
        guess = ""
        guesses.removeAll()
        
        let numbers = (0...9).shuffled()
        
        for i in 0..<answerLength {
            answer.append(String(numbers[i]))
        }
        
    }
    
    func submitGuess() {
        guesses.append(guess)
        guess = ""
    }
    
    func result(for guess: String) -> String {
        "Result"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
