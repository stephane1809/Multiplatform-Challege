//
//  MenuItem.swift
//  PratoAVista
//
//  Created by Raina Rodrigues de Lima on 22/06/23.
//

import SwiftUI

struct MenuItem: View {
    
    var body: some View {
        
        
        
        
#if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            NavigationView{
                Detalhes()
            }
            .navigationViewStyle(.stack)
        }
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            NavigationView{
                Detalhes()
                    .navigationBarTitle("Cardápio", displayMode: .inline)
                    .navigationBarItems(leading:
                                            
                                            Button(action: {
                    }) {
                        Image(systemName: "chevron.left")
                    })
                }

            }
#else

#endif
        
    }
}


struct Primary: View {
    var body: some View {
        Text("Primary")
    }
}

struct Detalhes: View {
    @State  var dishName: String = "Pizza de Chocolate"
    @State  var description: String = "Lorem ipsum magna morbi massa vel curabitur leo amet orci purus eros, diam ut vivamus nec conubia enim sollicitudin ad lectus nullam imperdiet, turpis nec sem vel bibendum nunc suspendisse sed congue erat. aenean inceptos praesent facilisis conubia quisque augue donec, tincidunt cursus nostra porttitor dolor aliquet netus adipiscing, leo nisl tortor mi egestas quam."
    
    var body: some View {
            VStack(alignment: .leading) {
                Image("Pasto13Out")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 393, height: 220)
                    .clipped()
                
                Text(dishName)
                    .font(
                        Font.custom("SF Pro", size: 24)
                            .weight(.semibold)
                    )
                    .foregroundColor(.black)
                    .padding(.leading,10)
                
                
                HStack(){
                    DishTagView(tag: .castanha)
                    DishTagView(tag: .egg)
                    DishTagView(tag: .celery)
                }
                .padding(.leading,10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Descrição")
                    .font(
                    Font.custom("SF Pro", size: 17)
                    .weight(.medium)
                    )
                    .foregroundColor(.black)
                    
                    Text(description)
                    .font(Font.custom("SF Pro", size: 12))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: 105, maxHeight: 105, alignment: .leading)
                }
                .padding(.horizontal, 13)
                .padding(.vertical, 11)
                .frame(width: 366, alignment: .topLeading)
                .background(Color(red: 0.97, green: 0.97, blue: 0.96))
                .cornerRadius(10)
                .padding(.leading,10)
                
                Spacer()
                
            }
            
        
    }
}



struct MenuItem_Previews: PreviewProvider {
    static var previews: some View {
        MenuItem()
    }
}


