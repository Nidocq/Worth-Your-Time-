//
//  SettingsView.swift
//  Worth your time?
//
//  Created by Phillip Lundin on 04/03/2022.
//

import SwiftUI

struct SettingsView: View {
  @State var ddd = false
    var body: some View {
      Form {
        Section {
          HStack {
            Image(systemName: "pencil.tip")
            Text("tips")
              .bold()
          }
          
          HStack {
            Toggle("Enable something", isOn: $ddd)
            
            
          }
          
          
        }
        
        Section {
          Text("I don't know")
          if ddd {
            Text("Hellooooo")
          }
        }
      }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
