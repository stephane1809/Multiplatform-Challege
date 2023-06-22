//
//  MenuItem.swift
//  PratoAVista
//
//  Created by Raina Rodrigues de Lima on 22/06/23.
//

import SwiftUI

struct MenuItem: View {
    
    @State private var dishName: String = "Pizza de Chocolate"
    @State private var description: String = "Lorem ipsum magna morbi massa vel curabitur leo amet orci purus eros, diam ut vivamus nec conubia enim sollicitudin ad lectus nullam imperdiet, turpis nec sem vel bibendum nunc suspendisse sed congue erat. aenean inceptos praesent facilisis conubia quisque augue donec, tincidunt cursus nostra porttitor dolor aliquet netus adipiscing, leo nisl tortor mi egestas quam."
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack{
                    Image("Pasto13Out")
                        .resizable()
                        .frame(width:393, height: 220)
                        .clipped()
                }
                VStack(alignment: . leading){
                    Text(dishName)
                        .font(.largeTitle)
                        .multilineTextAlignment(.leading)
                }
                
                
                HStack(alignment: .bottom){
                    DishTagView(tag: .castanha)
                    DishTagView(tag: .egg)
                    DishTagView(tag: .celery)
                }
                
                VStack(alignment: .leading) {
                    Text("Descrição")
                        .font(.headline)
                        .padding(5)
                        .multilineTextAlignment(.leading)
                    
                    Text(description)
                        .font(.footnote)
                        .padding(5)
                    
                }
                .frame(width: 366)
                .background(Color(UIColor(red: 247/255, green: 247/255, blue: 246/255, alpha: 1)))
                .foregroundColor(.black)
                .cornerRadius(10)
                
                Spacer()
                
            }
            .navigationBarTitle("Cardápio", displayMode: .inline)
            .multilineTextAlignment(.leading)
            .navigationBarItems(leading:
            
            Button(action: {
            }) {
                Image(systemName: "chevron.left") // Ícone de seta para a esquerda
            })
        }
    }
}

struct MenuItem_Previews: PreviewProvider {
    static var previews: some View {
        MenuItem()
    }
}


