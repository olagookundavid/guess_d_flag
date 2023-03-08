//
//  ContentView.swift
//  guess_the_flag
//
//  Created by David OH on 07/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingTotalScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAns = Int.random(in: 0...2)
    @State private var score = 0
    @State private var totalTap = 0
    
    //Functions
    func flaggedTapped(num: Int){
        if totalTap < 7{
            if num == correctAns{
                scoreTitle = "Correct"
                score += 1
            }
            else{
                scoreTitle = "Wrong"
            }
            showingScore = true
            totalTap += 1
        }else{
          showingTotalScore = true
            
        }
    }
    
    
    func askQuest(){
        countries.shuffle()
        correctAns = Int.random(in: 0...2)
        
    }
    func finished(){
        askQuest()
        totalTap = 0
        score = 0
        
    }
   
    
    
    //views
    var body: some View {
        ZStack{
            
            RadialGradient(stops: [
                .init(color: Color(red:0.1,green:0.45,blue:0.2), location: 0.3),
                .init(color: Color(red:0.76,green:0.15,blue:0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 30){
                VStack {
                    
                    Text("Tap the flag of....")
                        .foregroundColor(.white)
                    Text(countries[correctAns])
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3){ num in
                    Button{
                        flaggedTapped(num: num)
                    }label: {
                        Image(countries[num])
                            .renderingMode(.original )
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                    
                }
            }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                
                    Text("Score is \(score)")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                Spacer()
                Spacer()
            }
        }
        
        
        .alert("Quiz is Finished", isPresented: $showingTotalScore){
            Button("Start Again", action: finished)
        }message: {
            Text("Your final score is \(score)")
        }
        
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuest)
        }message: {
            Text("Your score is \(score)")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
