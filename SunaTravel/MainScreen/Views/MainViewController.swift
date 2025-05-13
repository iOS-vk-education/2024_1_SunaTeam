//
//  MainViewController.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//

import SwiftUI

fileprivate struct UIConstants {
    static let VStackSpacing: CGFloat = 20
}

struct MainView: View {
    @State private var selectedDate: Date = Date()
    @State private var selectedItem: ScheduleItem? = nil
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        VStack {
            DatePicker(
                MainText.select(for: settings.currentLanguage),
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(DefaultDatePickerStyle())
            .padding()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(MainText.schedule(for: settings.currentLanguage))
                        .font(.title3.bold())
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(spacing: UIConstants.VStackSpacing) {
                        ForEach(scheduleItems.filter { isSameDay($0.date, selectedDate) }) { item in
                            ScheduleCell(item: item) {
                                self.selectedItem = item
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
            .navigationBarHidden(true)
            .background(
                NavigationLink(
                    destination: ViewTripViewControllerWrapper(),
                    isActive: .constant(selectedItem != nil)
                ) {
                    EmptyView()
                }
            )
            .onAppear {
                selectedItem = nil
            }
        }
    }
    
    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
