//
//  OnboardingView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 13.12.2024.
//

import SwiftUI

struct OnboardingViewConstants {
    static let imageHeightRatio: CGFloat = 0.53
    static let imageWidth: CGFloat = UIScreen.main.bounds.width
    static let titleFontSize: CGFloat = 28
    static let subtitleFontSize: CGFloat = 20
    static let titleHorizontalTopPadding: CGFloat = 20
    static let subtitleHorizontalPadding: CGFloat = 20
    static let subtitleTopPadding: CGFloat = 10
    static let brushStrokeWidth: CGFloat = 80
    static let brushStrokeHeight: CGFloat = 1
    static let brushStrokeLeadingPadding: CGFloat = 40
    static let ellipseWidth: CGFloat = 110
    static let ellipseHeight: CGFloat = 85
    static let ellipseOffsetY: CGFloat = 25
    static let ellipseWhiteWidth: CGFloat = 118
    static let ellipseWhiteHeight: CGFloat = 80
    static let ellipseWhiteOffsetY: CGFloat = 28
    static let buttonMinHeight: CGFloat = 50
    static let buttonHorizontalPadding: CGFloat = 20
}

struct OnboardingView: View {
    let slide: OnboardingSlide
    
    var body: some View {
        VStack {
            Image(slide.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: OnboardingViewConstants.imageWidth, height: UIScreen.main.bounds.height * OnboardingViewConstants.imageHeightRatio)
            
            if let attributedTitle = createAttributedTitle(from: slide.title) {
                Text(attributedTitle)
                    .font(.system(size: OnboardingViewConstants.titleFontSize, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, OnboardingViewConstants.titleHorizontalTopPadding)
                    .padding(.top, OnboardingViewConstants.titleHorizontalTopPadding)
            }
            
            BrushStrokeView()
                .frame(width: OnboardingViewConstants.brushStrokeWidth, height: OnboardingViewConstants.brushStrokeHeight)
                .foregroundColor(.deepOrange)
                .padding(.leading, OnboardingViewConstants.brushStrokeLeadingPadding)
            
            Text(slide.subtitle)
                .font(.system(size: OnboardingViewConstants.subtitleFontSize, weight: .medium, design: .serif))
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, OnboardingViewConstants.subtitleHorizontalPadding)
                .padding(.top, OnboardingViewConstants.subtitleTopPadding)
            
            Spacer()
        }
        .background(slide.backgroundColor)
        .edgesIgnoringSafeArea(.all)
    }
}

fileprivate struct BrushStrokeView: View {
    var body: some View {
        ZStack {
            Ellipse()
                .fill(Color.deepOrange)
                .frame(width: OnboardingViewConstants.ellipseWidth, height: OnboardingViewConstants.ellipseHeight)
                .offset(y: OnboardingViewConstants.ellipseOffsetY)
            
            Ellipse()
                .fill(Color.white)
                .frame(width: OnboardingViewConstants.ellipseWhiteWidth, height: OnboardingViewConstants.ellipseWhiteHeight)
                .offset(y: OnboardingViewConstants.ellipseWhiteOffsetY)
        }
        .frame(height: 20)
    }
}

private func createAttributedTitle(from title: String) -> AttributedString? {
    var attributedString = AttributedString(title)
    if let lastSpaceIndex = attributedString.characters.lastIndex(of: " ") {
        let range = attributedString.characters.index(after: lastSpaceIndex)..<attributedString.endIndex
        attributedString[range].foregroundColor = Color.deepOrange
    }
    return attributedString
}
