//
//  ContentView.swift
//  BMI_CS4405
//
//  Created by Giorgio Giannotta on 16/12/24.
//

import SwiftUI

// Enum for BMI categories
enum BMICategory {
    case underweight
    case normal
    case overweight
    
    var description: String {
        switch self {
        case .underweight:
            return "You are underweight."
        case .normal:
            return "Your weight is normal."
        case .overweight:
            return "You are overweight."
        }
    }
    
    var color: Color {
        switch self {
        case .underweight, .overweight:
            return .red
        case .normal:
            return .green
        }
    }
}

// Class to handle BMI logic
class BMICalculator {
    var weight: Double // Weight in kilograms
    var height: Double // Height in meters
    
    init(weight: Double, height: Double) {
        self.weight = weight
        self.height = height
    }
    
    func calculateBMI() -> Double {
        return weight / (height * height)
    }
    
    func getBMICategory() -> BMICategory {
        let bmi = calculateBMI()
        if bmi < 18.5 {
            return .underweight
        } else if bmi <= 24.9 {
            return .normal
        } else {
            return .overweight
        }
    }
}

// SwiftUI View
struct ContentView: View {
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var gender: String = ""
    @State private var bmiResult: Double? = nil
    @State private var bmiCategory: BMICategory? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("BMI Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Input fields
                TextField("Enter your weight (kg)", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                TextField("Enter your height (m)", text: $height)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                // Gender input (optional)
                TextField("Enter your gender (optional)", text: $gender)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Calculate button
                Button(action: calculateBMI) {
                    Text("Calculate BMI")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                // BMI result display
                if let bmi = bmiResult, let category = bmiCategory {
                    VStack(spacing: 10) {
                        Text("Your BMI: \(String(format: "%.2f", bmi))")
                            .font(.title2)
                        
                        Text(category.description)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(category.color)
                    }
                    .padding()
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    // BMI calculation logic
    func calculateBMI() {
        guard let weightValue = Double(weight), let heightValue = Double(height), heightValue > 0 else {
            return // Handle invalid input
        }
        
        let calculator = BMICalculator(weight: weightValue, height: heightValue)
        bmiResult = calculator.calculateBMI()
        bmiCategory = calculator.getBMICategory()
    }
}

#Preview {
    ContentView()
}
