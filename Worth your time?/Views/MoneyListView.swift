//
//  MoneyListView.swift
//  Worth your time?
//
//  Created by Phillip Lundin on 04/03/2022.
//

import SwiftUI

struct MoneyListView: View {
  let defaults = UserDefaults.standard
  @State var inputString : String
//  //Set
//  defaults.set(passwordTextField.text, forKey: "Password")
//  //Get
//  let myPassword = defaults.string(forKey: "Password")
    var body: some View {
      VStack {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        TextField("Hello", text: $inputString)
          .padding(40)
          .onSubmit({
            defaults.set("Heyyyyl kldsjfl l", forKey: String(inputString))
            print(inputString)
          })
      }
    }
}

struct MoneyListView_Previews: PreviewProvider {
    static var previews: some View {
      MoneyListView(inputString: "")
    }
}
