//
//  MovieListResponse.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/8/25.
//

struct MovieListResponse: Decodable {
    let movieListResult: MovieListResult
}

struct MovieListResult: Decodable {
    let totCnt: Int
    let source: String
    let movieList: [Movie]
}

struct Movie: Decodable {
    let movieCd: String
    let movieNm: String
    let movieNmEn: String
    let prdtYear: String
    let openDt: String
    let typeNm: String
    let prdtStatNm: String
    let nationAlt: String
    let genreAlt: String
    let repNationNm: String
    let repGenreNm: String
    let directors: [Director?]
    let companys: [Company?]
}

struct Director: Decodable {
    let peopleNm: String
}

struct Company: Decodable {
    let companyCd: String
    let companyNm: String
}
