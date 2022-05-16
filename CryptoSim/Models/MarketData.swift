//
//  MarketData.swift
//  CryptoSim
//
//  Created by Pat Butler on 2022-05-08.
//

import SwiftUI


//JSON DATA
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 
 {
   "data": {
     "active_cryptocurrencies": 13437,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 801,
     "total_market_cap": {
       "btc": 48543365.26666929,
       "eth": 653795798.8389925,
       "ltc": 17511337986.483192,
       "bch": 6299362415.9445,
       "bnb": 4650981348.266406,
       "eos": 843662633435.2799,
       "xrp": 2904153775578.515,
       "xlm": 10164581840901.025,
       "link": 163624984738.8806,
       "dot": 123591540212.30965,
       "yfi": 106233289.15208542,
       "usd": 1673182729933.8909,
       "aed": 6145655382077.263,
       "ars": 194742787022577.16,
       "aud": 2366931138880.918,
       "bdt": 144626592234583.7,
       "bhd": 630945495178.961,
       "bmd": 1673182729933.8909,
       "brl": 8500551317581.748,
       "cad": 2159158653843.1873,
       "chf": 1652401800428.1123,
       "clp": 1435573990221401,
       "cny": 11154272669104.256,
       "czk": 39728303390142.516,
       "dkk": 11809763754931.373,
       "eur": 1587522466892.1953,
       "gbp": 1355358324017.4868,
       "hkd": 13133890450111.926,
       "huf": 606446951082828.2,
       "idr": 24258297419871770,
       "ils": 5698602708014.441,
       "inr": 128763934841146.44,
       "jpy": 218449900628803.75,
       "krw": 2124971145258703.8,
       "kwd": 513636980800.56366,
       "lkr": 593923991516082.9,
       "mmk": 3097704461437230,
       "mxn": 33743494410259.242,
       "myr": 7311808529811.081,
       "ngn": 694460948871217,
       "nok": 15876114802134.287,
       "nzd": 2611799758224.015,
       "php": 87687322245827.39,
       "pkr": 312129069261076.75,
       "pln": 7465440168073.616,
       "rub": 112103239559205.36,
       "sar": 6277423541607.753,
       "sek": 16639506095849.312,
       "sgd": 2308992167308.7695,
       "thb": 57498293724289.016,
       "try": 25014098544338.945,
       "twd": 49651627237113.67,
       "uah": 50608316312069.805,
       "vef": 167535786748.2804,
       "vnd": 38410990127610630,
       "zar": 26771107729042.52,
       "xdr": 1217437871589.035,
       "xag": 74835992202.41595,
       "xau": 888443297.7675954,
       "bits": 48543365266669.29,
       "sats": 4854336526666929
     },
     "total_volume": {
       "btc": 3423065.141219793,
       "eth": 46102811.29434474,
       "ltc": 1234822726.2028356,
       "bch": 444203399.9800861,
       "bnb": 327966799.13424826,
       "eos": 59491387455.26753,
       "xrp": 204788182675.71573,
       "xlm": 716761715705.6516,
       "link": 11538116041.51096,
       "dot": 8715133174.767818,
       "yfi": 7491105.466956785,
       "usd": 117985505254.21059,
       "aed": 433364654320.3884,
       "ars": 13732406933449.36,
       "aud": 166905599326.75323,
       "bdt": 10198432754960.514,
       "bhd": 44491508132.82605,
       "bmd": 117985505254.21059,
       "brl": 599421583907.8468,
       "cad": 152254395255.29587,
       "chf": 116520125278.95331,
       "clp": 101230379405581.97,
       "cny": 786550370777.1929,
       "czk": 2801465652567.2686,
       "dkk": 832772726272.1001,
       "eur": 111945119327.216,
       "gbp": 95573922560.16266,
       "hkd": 926144331391.1884,
       "huf": 42763978287183.32,
       "idr": 1710588704082290.5,
       "ils": 401840461128.03345,
       "inr": 9079867750818.33,
       "jpy": 15404128573237.102,
       "krw": 149843642142943.16,
       "kwd": 36219426373.94793,
       "lkr": 41880914121311.32,
       "mmk": 218436527865270.6,
       "mxn": 2379443180837.977,
       "myr": 515596657960.8987,
       "ngn": 48970339261824.93,
       "nok": 1119513961560.956,
       "nzd": 184172660035.20187,
       "php": 6183325248624.517,
       "pkr": 22009972540626.027,
       "pln": 526430087053.34064,
       "rub": 7905028616061.107,
       "sar": 442656366815.6737,
       "sek": 1173344966318.692,
       "sgd": 162819997250.8106,
       "thb": 4054527407525.4688,
       "try": 1763884483405.4993,
       "twd": 3501214913027.487,
       "uah": 3568676429250.728,
       "vef": 11813888641.1041,
       "vnd": 2708574500825559,
       "zar": 1887781062472.9453,
       "xdr": 85848377362.058,
       "xag": 5277105837.418651,
       "xau": 62649123.434933186,
       "bits": 3423065141219.793,
       "sats": 342306514121979.3
     },
     "market_cap_percentage": {
       "btc": 39.21131357739942,
       "eth": 18.461474133783007,
       "usdt": 4.979809937471424,
       "bnb": 3.6150880899175184,
       "usdc": 2.9041237800999267,
       "xrp": 1.6646195600559508,
       "ada": 1.5352672534800906,
       "sol": 1.5337727247244906,
       "luna": 1.3677382040782595,
       "ust": 1.1154182479527315
     },
     "market_cap_change_percentage_24h_usd": -3.426155925008081,
     "updated_at": 1652046651
   }
 }
 
 
 */




// MARK: - Welcome
struct GlobalData: Codable {
    let data: MarketData?
}

// MARK: - DataClass
struct MarketData: Codable {
    let activeCryptocurrencies, upcomingIcos, ongoingIcos, endedIcos: Int
    let markets: Int
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    let updatedAt: Int

    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
      
    }
  
  var marketCap: String {
   
    if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
      return "$" + item.value.formattedWithAbbreviations()
    }
    return ""
  }
  
  var volume: String {
    if let item = totalVolume.first(where: { $0.key == "usd"}) {
      return "$" + item.value.formattedWithAbbreviations()
    }
    return ""
  }
  
  var btcDominance: String {
    if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
      return item.value.asPercentString()
    }
     return ""
  }

}

