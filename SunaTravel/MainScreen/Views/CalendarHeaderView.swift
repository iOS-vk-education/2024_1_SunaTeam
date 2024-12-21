//
//  CalendarHeaderView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//

import SwiftUI

fileprivate struct UIConstants {
    //static let daysInWeek = 7
    static let weekdayAdjustmentForSunday: Int = 6
    static let weekdayAdjustment: Int = 2
    static let circleSize: CGFloat = 40
    static let horizontalSpacing: CGFloat = 15
    static let topPadding: CGFloat = 20
}

struct CalendarHeaderView: View {
    let currentDate = Date()
    let calendar = Calendar.current
    let weekdaySymbols = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var daysInWeek: Int {
        weekdaySymbols.count
    }
    

    var startOfWeek: Date {
        let weekday = calendar.component(.weekday, from: currentDate)
        let daysToSubtract = (weekday == 1) ? UIConstants.weekdayAdjustmentForSunday : weekday - UIConstants.weekdayAdjustment
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: currentDate) ?? Date()
    }
    
    var weekDates: [Date] {
        return (0..<daysInWeek).map { calendar.date(byAdding: .day, value: $0, to: startOfWeek)! }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: UIConstants.horizontalSpacing) {
                ForEach(0..<daysInWeek, id: \.self) { index in
                    let date = weekDates[index]
                    let dayOfMonth = calendar.component(.day, from: date)
                    let weekdaySymbol = weekdaySymbols[index]
                    
                    let isToday = calendar.isDate(date, inSameDayAs: currentDate)
                    
                    VStack {
                        Text(weekdaySymbol)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("\(dayOfMonth)")
                            .font(.title3.bold())
                            .foregroundColor(isToday ? Color.orange : Color.black)
                            .frame(width: UIConstants.circleSize, height: UIConstants.circleSize)
                            .background(isToday ? Color.orange.opacity(0.2) : Color.clear)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, UIConstants.topPadding)
    }
}

struct CalendarHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHeaderView()
            .previewLayout(.sizeThatFits)
    }
}

