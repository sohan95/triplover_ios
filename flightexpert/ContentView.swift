//
//  ContentView.swift
//  flightexpert
//
//  Created by sohan on 5/6/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowing = false
//    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea(.all, edges: .all)
                
                if isShowing {
                    SideMenuView(isShowing: $isShowing)
                }
                
                
                HomeView()
                    //.background(isShowing ? Color.gray)
                    .cornerRadius(isShowing ? 20: 10)
                    .offset(x: isShowing ? 300 : 0, y:
                                isShowing ? 0 : 0)
                    .scaleEffect(isShowing ? 1 : 1)
                    .navigationBarItems(leading: Button(action: {
                        withAnimation(.spring()) {
                            isShowing.toggle()
                        }
                        
                    }, label: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.black)
                    }))
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
                
            }
            .onAppear {
                isShowing = false;
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
