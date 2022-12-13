//
//  BalanceRowDetailView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

struct BalanceRowDetailView: View {
    @EnvironmentObject var balanceViewModel: BalanceViewModel
    @Environment(\.dismiss) var dismiss
    var currentAddition: AdditionModel
    
    @State var subject: String = ""
    @State var date: Date = Date.now
    @State var amount: String = "0"
    @State var locked: Bool = false
    @State var negative: Bool = false
    
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2022)) ?? Date()
    let endingDate: Date = Date()
    
//    var dateFormatter: DateFormatter{
//        let formatter = DateFormatter()
//
//        formatter.dateStyle = .short
//        formatter.timeStyle = .full
//
//        return formatter
//    }
    
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 80, height: 5)
                .foregroundColor(.white.opacity(0.5))
                .padding(.bottom, 15)
                .padding(.top, 5)
            
            VStack{
                Text("Transaction ID")
                    .font(.caption)
                    
                Text("\(currentAddition.id)")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            List{
                VStack(alignment: .leading){
                    Text("What's the transaction about?")
                    
                    TextField("Current: \(currentAddition.subject)", text: $subject)
                }
                .padding(3)
                
                VStack(alignment: .leading){
                    Text("When was the transaction?")
                    
                    DatePicker("", selection: $date, in: startingDate...endingDate, displayedComponents: .date)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        
                }
                .padding(3)
                
                VStack(alignment: .leading){
                    
                    HStack(alignment: .center){
                        Spacer()
                        Image(systemName: "minus.circle")
                            .foregroundColor(negative ? .red : .gray)
                            .opacity(negative ? 1.0 : 0.2)
                            .onTapGesture {
                                negative = true
                            }
  
                        Spacer()
                        
                        VStack(alignment: .leading){
                            Text("How much was the transaction?")
                            
                            TextField("Current: \(currentAddition.amount)", text: $amount)
                                .keyboardType(.asciiCapableNumberPad)
                        }
                        .padding(15)
                        .font(.caption)
                        
                        Image(systemName: "plus.circle")
                            .foregroundColor(negative ? .gray : .green)
                            .opacity(negative ? 0.2 : 1.0)
                            .onTapGesture {
                                negative = false
                            }
                    }
                    .font(.largeTitle)
                }
                .padding(3)
                
                
                
                VStack(alignment: .leading){
                    Text("Do you want to lock the transaction from clearing?")

                    Toggle("", isOn: $locked)
                        .labelsHidden()
                }
                .padding(3)
                
                
            }
            .fontWeight(.regular)
            .font(.caption)
            .listStyle(.grouped)
            .cornerRadius(10)
            
            HStack{
                Button {
                    balanceViewModel.updateAddition(addition: currentAddition, newAddition: AdditionModel(subject: subject, date: date, amount: Int(amount) ?? 0, isLocked: locked, isNegative: negative))
                    
                    dismiss()
                } label: {
                    Text("Save".uppercased())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.2))
                        .font(.headline)
                        .cornerRadius(10)
                }
                .padding(.leading)
                
                Button {
                    balanceViewModel.deleteAddition(addition: currentAddition)
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                        .padding(18)
                        .foregroundColor(.white)
                        .background(Color.red.opacity(0.4))
                        .font(.caption)
                        .cornerRadius(10)
                }
                .padding(.trailing)
            }
            
        }
        .padding(5)
        .onAppear{
            subject = currentAddition.subject
            date = currentAddition.date
            amount = String(currentAddition.amount)
            locked = currentAddition.isLocked
            print("OK \(currentAddition.isNegative)")
            print("BEFORE \(negative)")
            negative = currentAddition.isNegative
            print("AFTER \(negative)")
        }
    }
}

struct BalanceRowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceRowDetailView(currentAddition: AdditionModel(subject: "Test", date: .now, amount: 500, isLocked: false, isNegative: false))
    }
}
