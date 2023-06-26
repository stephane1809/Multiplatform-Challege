//
//  MenuView.swift
//  PratoAVista
//
//  Created by Beatriz Leonel da Silva on 25/06/23.
//

import SwiftUI

struct MenuView: View {

    @EnvironmentObject var viewModel: MenuViewModel
    @State var insertionAnimation: Edge = .trailing
    @State var removeAnimation: Edge = .leading
    @State var imageOnSaveButton: String = "bookmark"

    var body: some View {
        VStack(alignment: .leading) {
            filterCategorySection
                .ignoresSafeArea(.all, edges: .horizontal)
            menuListSection
            Spacer()
        }
        .onAppear {
            viewModel.getAllCategorys()
        }
        .navigationTitle(viewModel.restaurant.name!)
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(.stack)
        .background(Color.white)
        .sheet(isPresented: $viewModel.showDish) {
            MenuItem()
        }
        .toolbar {
            Button {
                saveAction()
            } label: {
                Image(systemName: imageOnSaveButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(.restaurantTagBG)
            }
        }
    }

    func saveAction() {
        if imageOnSaveButton == "bookmark.fill" {
            imageOnSaveButton =  "bookmark"
        } else {
            imageOnSaveButton = "bookmark.fill"
        }
        // MARK: Aqui adiciona o código para salvar
    }

    func updateTransition(_ nextCategory: String) {
        guard let nextIndex = viewModel.categorys.firstIndex(of: nextCategory) else { return }
        guard let currentIndex = viewModel.categorys.firstIndex(
            of: viewModel.currentCategory) else { return }
        if currentIndex < nextIndex {
            removeAnimation = .leading
            insertionAnimation = .trailing
        }
        if currentIndex > nextIndex {
            removeAnimation = .trailing
            insertionAnimation = .leading
        }
    }
}

extension MenuView {

    private var filterCategorySection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.categorys, id: \.self) { item in
                    filterItem(filterCategory: item)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 20)
                        .onTapGesture {
                            updateTransition(item)
                            withAnimation {
                                viewModel.updateCategory(item)
                            }
                        }
                }
            }
        }
    }

    private func filterItem(filterCategory: String) -> some View {
        if filterCategory == viewModel.currentCategory {
            return(
                Text(filterCategory)
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(.dishTagBG)
            )
        } else {
            return(
                Text(filterCategory)
                    .font(.callout)
                    .foregroundColor(.black)
            )
        }
    }

    private var menuListSection: some View {
        ScrollView {
            ForEach(viewModel.currentDishes, id: \.self) { dish in
                NavigationLink {
                    MenuItem()
                        .environmentObject(viewModel)
                        .onAppear {
                            viewModel.selectedDish = dish
                        }
                } label: {
                    FoodCard(dish: dish)
                }
                .transition(
                    .asymmetric(
                        insertion: .move(edge: insertionAnimation),
                        removal: .move(edge: removeAnimation)
                    ))
            }
            .simultaneousGesture(DragGesture(minimumDistance: -3, coordinateSpace: .local)
                .onEnded { drag in
                    if drag.startLocation.x > drag.location.x {
                        let nextCategory = viewModel.returnNextCategory()
                        updateTransition(nextCategory)
                        withAnimation {
                            viewModel.updateCategory(nextCategory)
                        }
                    }
                    if drag.startLocation.x < drag.location.x {
                        let backCategory = viewModel.returnBackCategory()
                        updateTransition(backCategory)
                        withAnimation {
                            viewModel.updateCategory(backCategory)
                        }
                    }
                })
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(MenuViewModel(
                restaurant: .init(),
                dishes: [
                    .init(ckDish: .init(recordName: ""))
                ]))
            .previewDisplayName("iPhone")
            .previewDevice(.init(rawValue: "iPhone 14"))

        MenuView()
            .environmentObject(MenuViewModel(
                restaurant: .init(),
                dishes: [
                    .init(ckDish: .init(recordName: ""))
                ]))
            .previewDisplayName("iPad")
            .previewDevice(.init(rawValue: "iPad Pro (12.6-inch) (6th generation)"))
    }
}
