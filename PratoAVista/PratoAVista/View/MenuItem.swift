//
//  MenuItem.swift
//  PratoAVista
//
//  Created by Raina Rodrigues de Lima on 22/06/23.
//

import SwiftUI

struct MenuItem: View {
    
    @State private var orientation = UIDeviceOrientation.unknown
    @State  var dishName: String = "Pizza de Chocolate"
    @State  var description: String = "Lorem ipsum magna morbi massa vel curabitur leo amet orci purus eros, diam ut vivamus nec conubia enim sollicitudin ad lectus nullam imperdiet, turpis nec sem vel bibendum nunc suspendisse sed congue erat. aenean inceptos praesent facilisis conubia quisque augue donec, tincidunt cursus nostra porttitor dolor aliquet netus adipiscing, leo nisl tortor mi egestas quam. raina raina rainaLorem ipsum magna morbi massa vel curabitur leo amet orci purus eros, diam ut vivamus nec conubia enim sollicitudin ad lectus nullam imperdiet, turpis nec sem vel bibendum nunc suspendisse sed congue erat. aenean inceptos praesent facilisis conubia quisque augue donec, tincidunt cursus nostra porttitor dolor aliquet netus adipiscing, leo nisl tortor mi egestas quam. raina raina raina"
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Image("Pasto13Out")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 220)
                    .clipped()
                
                if orientation.isLandscape {
                    descriptionSection
                        .padding(.horizontal, 30)
                } else {
                    descriptionSection
                }
                
            }
            
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
        .ignoresSafeArea()
        .background(Color.white)
    }
}

extension MenuItem {
    private var descriptionSection: some View {
        VStack(alignment: .leading) {
            Text(dishName)
                .font(
                    Font.custom("SF Pro", size: 24)
                        .weight(.semibold)
                )
                .foregroundColor(.black)
                .padding(.leading, 10)
            
            HStack(){
                DishTagView(tag: .castanha)
                DishTagView(tag: .egg)
                DishTagView(tag: .celery)
            }
            .padding(.leading,10)
            
            VStack(alignment: .leading) {
                Text("Descrição")
                    .font(
                        Font.custom("SF Pro", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                    .padding(.horizontal,13)
                    .padding(.top, 11)
                
                
                Text(description)
                    .font(Font.custom("SF Pro", size: 12))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: 105, maxHeight: 105, alignment: .leading)
                    .padding(.horizontal,13)
                
            }
            .frame(height: 157, alignment: .topLeading)
            .background(Color(red: 0.97, green: 0.97, blue: 0.96))
            .cornerRadius(10)
            .padding(.horizontal, 12)
            
            Spacer()
        }
    }
}


struct MenuItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuItem()
                .previewDisplayName("iPhone")
                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            MenuItem()
                .previewDisplayName("iPad")
                .previewDevice(PreviewDevice(rawValue: "iPad (10th generation)"))
        }
    }
}


