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
    
    var body: some View {
        VStack {
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(DefaultDatePickerStyle())
            .padding()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("My Schedule")
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
