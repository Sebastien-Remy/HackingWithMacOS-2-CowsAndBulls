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
    
    @AppStorage("maximumGuesses") var maximumGuesses = 100
    @AppStorage("answerLength") var answerLength = 4
    @AppStorage("enableHardMode") var enableHardMode = false
    @AppStorage("showGuessCount") var showGuessCount = false
    
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("Enter a guess…", text: $guess)
                Button("Go", action: submitGuess)
            }
            .padding()
            List(0..<guesses.count, id: \.self) { index in
                let guess = guesses[index]
                let shouldShowResult = (enableHardMode == false || (enableHardMode && index == 0))
                HStack {
                    Text(guess)
                    Spacer()
                    if shouldShowResult {
                        Text(result(for: guess))
                    }
                }
            }
            .listStyle(.sidebar)
            if showGuessCount {
                Text("Guesses: \(guesses.count)/\(maximumGuesses).")
            }
            Spacer()
        }
        .navigationTitle("Cows and Bulls")
        .frame(width: 250)
        .frame(minWidth: 300, maxHeight: .infinity)
        .onAppear(perform: startNewGame)
        .onChange(of: answerLength) { _ in startNewGame() }
        .alert("You win!", isPresented: $isGameOver) {
            Button("Ok", action: startNewGame)
        } message: {
            Text("Congratulations! Click OK to play again.")
        }
    }
    
    func startNewGame() {
        guard answerLength >= 3 && answerLength <= 8 else { return }
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
