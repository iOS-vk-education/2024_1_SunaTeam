//
//  ScheduleCell.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//

import SwiftUI

fileprivate struct UIConstants {
    static let imageWidth: CGFloat = 70
    static let imageHeight: CGFloat = 70
    static let imageCornerRadius: CGFloat = 10
    static let verticalSpacing: CGFloat = 5
    static let horizontalPadding: CGFloat = 16
    static let backgroundCornerRadius: CGFloat = 15
    static let shadowColorOpacity: Double = 0.1
    static let shadowRadius: CGFloat = 5
    static let shadowOffsetX: CGFloat = 0
    static let shadowOffsetY: CGFloat = 5
}

struct ScheduleCell: View {
    let item: ScheduleItem
    var onTap: (() -> Void)?
    
    var body: some View {
        HStack {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: UIConstants.imageWidth, height: UIConstants.imageHeight)
                .clipShape(RoundedRectangle(cornerRadius: UIConstants.imageCornerRadius))
            
            VStack(alignment: .leading, spacing: UIConstants.verticalSpacing) {
                Text(dateFormatter.string(from: item.date))
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(item.title)
                    .font(.headline)
                Text(item.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .onTapGesture {
                onTap?()
            }
            Spacer()
        }
        .padding(UIConstants.horizontalPadding)
        .background(.background)
        .cornerRadius(UIConstants.backgroundCornerRadius)
        .shadow(color: Color.black.opacity(UIConstants.shadowColorOpacity),
                radius: UIConstants.shadowRadius,
                x: UIConstants.shadowOffsetX,
                y: UIConstants.shadowOffsetY)
    }
}

struct ScheduleCell_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleCell(item: scheduleItems[0])
            .previewLayout(.sizeThatFits)
    }
}
