//
//  Category.swift
//  Life after work
//
//  Created by Lisa J on 10/22/24.
//

import Foundation

enum CategoryType: Codable {
    case physicalFitness
    case mentalHealth
    case personalDevelopment
    case social
    case creative
    case financial
    case adventure
    case volunteering
    case rest
    case reflection
}

struct Category {
    let type: CategoryType
    var icon: String {
        switch type {
        case .physicalFitness:
            return "heart.fill"
        case .mentalHealth:
            return "brain.head.profile"
        case .personalDevelopment:
            return "book.fill"
        case .social:
            return "person.2.fill"
        case .creative:
            return "paintbrush.fill"
        case .financial:
            return "dollarsign.circle.fill"
        case .adventure:
            return "airplane"
        case .volunteering:
            return "hands.sparkles.fill"
        case .rest:
            return "bed.double.fill"
        case .reflection:
            return "sparkles"
        }
    }
    var name: String {
        switch type {
        case .physicalFitness:
            return "Physical Health"
        case .mentalHealth:
            return "Mental Well-being"
        case .personalDevelopment:
            return "Personal Development"
        case .social:
            return "Social Connections"
        case .creative:
            return "Creativity"
        case .financial:
            return "Financial Health"
        case .adventure:
            return "Adventure"
        case .volunteering:
            return "Volunteering"
        case .rest:
            return "Rest"
        case .reflection:
            return "Reflection"
        }
    }
}
