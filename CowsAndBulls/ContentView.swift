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
    @State private var isGameOver = false
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
            .listStyle(.sidebar)
            Spacer()
        }
        .navigationTitle("Cows and Bulls")
        .frame(width: 250)
        .frame(minWidth: 300, maxHeight: .infinity)
        .onAppear(perform: startNewGame)
        .alert("You win!", isPresented: $isGameOver) {
            Button("Ok", action: startNewGame)
        } message: {
            Text("Congratulations! Click OK to play again.")
        }
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
        guard Set(guess).count == answerLength else { return }
        guard guess.count == answerLength else { return }
        
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guess.rangeOfCharacter(from: badCharacters) == nil else { return }
        
        withAnimation {
            guesses.insert(guess, at: 0)
        }
        
        if result(for: guess).contains("\(answerLength)b") {
            isGameOver = true
        }
        
        // clear
        guess = ""
    }
    
    func result(for guess: String) -> String {
        var bulls = 0
        var cows = 0
        
        
        let guessLetter = Array(guess)
        let answerLetters = Array(answer)
        
        for (index, letter) in guessLetter.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            } else if answerLetters.contains(letter) {
                cows += 1
            }
        }
        
        return "\(bulls)b \(cows)c"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
