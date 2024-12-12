//
//  ContentView.swift
//  helloworld
//
//  Created by erenkulaksiz on 12.12.2024.
//

import SwiftUI

struct HelloWorldView: View {
    @State private var userGuess: String = ""
    @State private var randomNumber: Int = Int.random(in: 1...100)
    @State private var resultMessage: String? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, World!")
                .font(.largeTitle)
                .padding()

            Text("Guess the number (1-100)")
                .font(.headline)
            
            Text("asd: \(randomNumber)")
                .font(.headline)

            TextField("Enter your guess", text: $userGuess)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()

            Button(action: {
                checkGuess()
            }) {
                Text("Guess")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            if let resultMessage = resultMessage {
                Text(resultMessage)
                    .font(.headline)
                    .foregroundColor(resultMessage == "Correct!" ? .green : .red)
            }
        }
        .padding()
        .onAppear {
            randomNumber = Int.random(in: 1...100)
            Swift.print("random number: \(randomNumber)")
        }
    }
    
    private func checkGuess() {
        guard let guess = Int(userGuess) else {
            resultMessage = "Please enter a valid number!"
            return;
        }

        if guess == randomNumber {
            resultMessage = "Correct!"
            randomNumber = Int.random(in: 1...100)
        } else {
            resultMessage = "Incorrect! Try again."
        }
    }
}

struct ContentView: View {
    @State var counter = 0
    var body: some View {
        TabView {
            EbenView()
                .tabItem {
                    Label("helloo", systemImage: "tray.and.arrow.down.fill")
                }
            HelloWorldView()
                .tabItem {
                    Label("whatsup", systemImage: "globe")
                }
        }
    }
}

#Preview {
    ContentView()
}
