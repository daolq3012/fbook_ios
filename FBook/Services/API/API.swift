//
//  API.swift
//
//  Created by nguyen.van.hung on 6/29/17.
//  Copyright © 2017 nguyen.van.hung. All rights reserved.
//

import Foundation
import ReactiveSwift
import Moya

enum API {

    case login(String, String)
    case home
    case homeFilter
    case getUserProfile
    case getOtherUserProfile(Int)
    case getListOffice
    case getBookDetail(Int)
    case searchBook(Int?, Int, SearchBookParams)
    case searchGoogleBook(Int, String)
    case getBookInSection(Int?, Int, SectionBook)
    case getBookFilterSortInSection(Int?, Int, SectionBook, FilterSortBookParams)
    case getListNotifications
    case bookingBook(BookingBookParams)
    case getFollowInfoOfUser(Int)
    case getListWaitingApprovedBook(Int)
    case getBookApproveDetail(Int)
    case approveBook(Int, ApproveBookParams)
    case getCategories
    case getBooksInCategory(Int, Int)
    case followUser(Int)
    case reviewBook(Int, Review)
}

extension API: TargetType {

    static var debugMode = false
    static let baseURLStringProd = "http://api-book.framgia.vn/api/v0"
    static let baseURLStringDebug = "http://private-anon-040374aa5d-apibookframgiavn.apiary-mock.com/api/v0"

    public var baseURL: URL {
        if API.debugMode {
            return URL(string: API.baseURLStringDebug)!
        }
        return URL(string: API.baseURLStringProd)!
    }

    public var path: String {
        switch self {
        case .login:
            return "/login"
        case .home:
            return "/home"
        case .homeFilter:
            return "/home/filters"
        case .getUserProfile:
            return "/user-profile"
        case .getOtherUserProfile(let userId):
            return "/users/\(userId)"
        case .getListOffice:
            return "/offices"
        case .getBookDetail(let bookId):
            return "/books/\(bookId)"
        case .searchBook(let officeId, let page, _):
            var path = "/search?page=\(page)"
            if let id = officeId {
                path.append("&office_id=\(id)")
            }
            return path
        case .searchGoogleBook:
            return "/search-books"
        case .getBookInSection:
            return "/books"
        case .getBookFilterSortInSection(let officeId, let page, let sectionBook, _):
            var path = "/books/filters?page=\(page)&condition=\(sectionBook.key)"
            if let id = officeId {
                path.append("&office_id=\(id)")
            }
            return path
        case .getListNotifications:
            return "/notifications"
        case .bookingBook:
            return "/books/booking"
        case .getFollowInfoOfUser(let userId):
            return "/users/follow/info/\(userId)"
        case .getListWaitingApprovedBook(let page):
            return "/user/books/waiting_approve?page=\(page)"
        case .getBookApproveDetail(let bookId):
            return "/user/\(bookId)/approve/detail"
        case .approveBook(let bookId, _):
            return "/books/approve/\(bookId)"
        case .getCategories:
            return "/categories"
        case .getBooksInCategory(let categoryId, _):
            return "/books/category/\(categoryId)"
        case .followUser:
            return "/users/follow"
        case .reviewBook(let bookId, _):
            return "/books/review/\(bookId)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login, .homeFilter, .searchBook, .bookingBook, .approveBook, .followUser, .reviewBook,
                 .getBookFilterSortInSection:
            return .post
        default:
            return .get
        }
    }

    public var parameters: [String : Any]? {
        switch self {
        case .login(let email, let password):
            return ["email": email, "password": password]
        case .searchBook(_, _, let params):
            return params.toRequestJSON()
        case .searchGoogleBook(let maxResults, let searchText):
            return ["maxResults": maxResults, "q": searchText]
        case .getBookInSection(let officeId, let page, let sectionBook):
            var parameters: [String : Any] = ["page": page, "field": sectionBook.key]
            if let officeId = officeId {
                parameters["office_id"] = officeId
            }
            return parameters
        case .getBookFilterSortInSection(_, _, _, let params):
            return params.toRequestJSON()
        case .bookingBook(let params):
            return params.toRequestJSON()
        case .approveBook(_, let params):
            return params.toRequestJSON()
        case .getBooksInCategory(_, let page):
            var parameters: [String : Any] = ["page": page]
            if let officeId = Office.currentId {
                parameters["office_id"] = officeId
            }
            return parameters
        case .followUser(let userId):
            return [kItem: ["user_id": userId]]
        case .reviewBook(_, let review):
            let params: [String: Any] = [
                "content": review.content,
                "star": review.star
            ]
            return [kItem: params]
        default:
            return nil
        }
    }

    public var parameterEncoding: ParameterEncoding {
        switch method {
        case .post: return JSONEncoding.default
        default: return URLEncoding.default
        }
    }

    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }

    public var task: Task {
        return Task.request
    }

    public var validate: Bool {
        return false
    }
}
