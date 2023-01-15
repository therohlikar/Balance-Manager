//
//  BalanceRowDetailView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

struct BalanceRowDetailView: View {
    @ObservedObject var balanceViewModel: BalanceViewModel
    var categoryViewModel: CategoryViewModel = CategoryViewModel()
    @Environment(\.dismiss) var dismiss
    var currentAddition: AdditionModel
    var new:Bool = false
    
    @State var subject: String = ""
    @State var selectedCategory: CategoryModel = CategoryModel(name: "groceries", icon: "basket.fill", color: "cat_groceries", paymentName: nil)
    @State var date: Date = Date.now
    @State var amount: String = "0"
    @State var locked: Bool = false
    
    @FocusState var amountFocused: Bool
    
    var body: some View {
        VStack{
            if !new {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 80, height: 5)
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.bottom, 15)
                    .padding(.top, 5)
            }
            
            VStack{
                Text("Transaction ID")
                    .font(.caption)
                    
                Text("\(currentAddition.id)")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            List{
                VStack(alignment: .leading){
                    VStack{
                        TextField("Current: \(currentAddition.amount)", text: $amount)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numbersAndPunctuation)
                            .focused($amountFocused)
                            .font(.largeTitle.weight(.bold))
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(15)
                    .font(.caption)
                    .onAppear{
                        amountFocused.toggle()
                    }
                }
                .font(.largeTitle)
            
                VStack(alignment: .leading){
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 80))
                    ], spacing: 20){
                        ForEach(categoryViewModel.categories) { category in
                            VStack{
                                Image(systemName: "\(category.icon)")
                                    .foregroundColor(selectedCategory.name == category.name ? .black : .white)
                                    .cornerRadius(40)
                                    .background(
                                        RoundedRectangle(cornerRadius: 100)
                                            .foregroundColor(selectedCategory.name == category.name ? .white : Color(category.color))
                                            .frame(width: 40, height: 40)
                                    )
                                    .padding()
                                    .onTapGesture(count: 1) {
                                        subject = category.paymentName
                                        selectedCategory = category
                                    }
                                Text(category.name.uppercased())
                                    .font(.caption2)
                            }
                        }
                    }
                }
                .padding(3)
                
                VStack(alignment: .leading){
                    Text("What's the transaction about?")
                    
                    TextField("Current: \(currentAddition.subject)", text: $subject)
                        .multilineTextAlignment(.center)
                        .textCase(.uppercase)
                }
                .padding(3)

                VStack(alignment: .leading){
                    Text("Date of transaction?")
                    
                    HStack{
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                        Spacer()
                    }
                }
                .padding(3)

                VStack(alignment: .leading){
                    Text("Lock transaction from being cleared?")

                    HStack{
                        Spacer()
                        Toggle("", isOn: $locked)
                            .labelsHidden()
                        Spacer()
                    }
                }
                .padding(3)
            }
            .font(.caption.weight(.regular))
            .listStyle(.grouped)
            .cornerRadius(10)
            
            HStack{
                Button {
                    balanceViewModel.updateAddition(addition: currentAddition, newAddition: AdditionModel(subject: subject.uppercased(), category: selectedCategory, date: date, amount: Int(amount) ?? 0, isLocked: locked))
                    
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
            selectedCategory = currentAddition.category
            date = currentAddition.date
            amount = String(currentAddition.amount)
            locked = currentAddition.isLocked
        }
    }
}

struct BalanceRowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceRowDetailView(balanceViewModel: BalanceViewModel(profile: ProfileModel(nickname: "NONAME", icon: "person.fill")), currentAddition: AdditionModel(subject: "GROCERIES", category: CategoryModel(name: "groceries", icon: "basket.fill", color: "cat_groceries", paymentName: nil), date: .now, amount: 500, isLocked: false))
            .preferredColorScheme(.dark)
    }
}
