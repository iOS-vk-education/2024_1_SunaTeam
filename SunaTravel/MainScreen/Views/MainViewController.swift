//
//  MainViewController.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//

import SwiftUI

fileprivate struct MainViewConstants {
    static let VStackSpacing: CGFloat = 20
}

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                CalendarHeaderView()
                VStack(alignment: .leading) {
                    HStack {
                        Text("My Schedule")
                            .font(.title3.bold())
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        LazyVStack(spacing: MainViewConstants.VStackSpacing) {
                            ForEach(scheduleItems) { item in
                                ScheduleCell(item: item)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
                NavigationBar()
            }
            .navigationBarTitle("Schedule", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    // Действие для кнопки назад
                }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                },
                trailing: Button(action: {
                    // Переход в профиль
                }) {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.black)
                }
                
            )
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
