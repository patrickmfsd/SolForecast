//
//  ServiceHelper..swift
//  SolForecast
//
//  Created by Patrick Mifsud on 13/5/2024.
//
import Foundation
import OSLog

    // Enum to represent the type of alert
enum RequestAlerts {
    case magAlert
    case magWarning
    case auroraAlert
    case auroraWatch
    case auroraOutlook
}

// Enum to represent the type of solar index
enum RequestIndex {
    case aIndex
    case kIndex
    case dstIndex
}

// Class responsible for making API requests and handling solar index and alert data
class SWSRequestService: ObservableObject {
    // Published properties to hold data fetched from the API
    @Published var aIndex: AIndexData?
    @Published var kIndex: KIndexData?
    @Published var dstIndex: DSTIndexData?
    @Published var magAlert: MagAlertData?
    @Published var magWarning: MagWarningData?
    @Published var auroraAlert: AuroraAlertData?
    @Published var auroraWatch: AuroraWatchData?
    @Published var auroraOutlook: AuroraOutlookData?
    
    // Constants for API key and base URL
    private let apiKey = "256250eb-74cc-4701-b7d3-e8694fc4f220"
    private let baseURL = "https://sws-data.sws.bom.gov.au/api/v1/"
    
    private let logger = Logger(subsystem: "com.patrickmfsd.SolForecast", category: "service request")

    
    // MARK: - Fetch Solar Index Levels
    
    /// Fetches solar index data based on the specified request type.
    /// - Parameter req: The type of solar index to fetch.
//    func fetchSolarIndexes(req: RequestIndex, start: Date? = .distantPast, end: Date? = .now) {
    func fetchSolarIndexes(req: RequestIndex) {

        let apiUrlString: String
        switch req {
            case .aIndex:
                apiUrlString = "get-a-index"
            case .kIndex:
                apiUrlString = "get-k-index"
            case .dstIndex:
                apiUrlString = "get-dst-index"
        }
        
        let options: [String: Any] = [
            "location": "Australian region"
        ]
        
//        // Format date to required string format
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        
//        // Add start time to options
//        if let start = start {
//            let startString = dateFormatter.string(from: start)
//            options["start"] = startString
//        }
//        
//        // Add end time to options if it is provided
//        if let end = end {
//            let endString = dateFormatter.string(from: end)
//            options["end"] = endString
//        }
        
        let requestBody: [String: Any] = [
            "api_key": apiKey,
            "options": options
        ]
        
        fetchData(endpoint: apiUrlString, requestBody: requestBody) { data in
            self.handleResponse(data: data, for: req)
        }
    }
    
    // MARK: - Fetch Alerts

    /// Fetches alert data based on the specified alert type.
    /// - Parameter alertType: The type of alert to fetch.
    func fetchAlerts(alertType: RequestAlerts) {
        let apiUrlString: String
        switch alertType {
            case .magAlert:
                apiUrlString = "get-mag-alert"
            case .magWarning:
                apiUrlString = "get-mag-warning"
            case .auroraAlert:
                apiUrlString = "get-aurora-alert"
            case .auroraWatch:
                apiUrlString = "get-aurora-watch"
            case .auroraOutlook:
                apiUrlString = "get-aurora-outlook"
        }
        
        let requestBody: [String: Any] = ["api_key": apiKey]
        
        fetchData(endpoint: apiUrlString, requestBody: requestBody) { data in
            self.handleResponse(data: data, for: alertType)
        }
    }
    
    // MARK: - Fetch Data

    /// Makes a network request to fetch data from the specified endpoint with the given request body.
    /// - Parameters:
    ///   - endpoint: The API endpoint to fetch data from.
    ///   - requestBody: The request body to send with the request.
    ///   - completion: A closure to handle the data received from the request.
    private func fetchData(endpoint: String, requestBody: [String: Any], completion: @escaping (Data) -> Void) {
        guard let apiUrl = URL(string: baseURL + endpoint),
              let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            logger.error("Failed to create URL or serialize request body")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                self.logger.error("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                self.logger.error("No data received")
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                self.logger.debug("Received JSON: \(jsonString)")
            }
            
            completion(data)
        }
        
        task.resume()
    }
    
    // MARK: - Handle Response

    /// Handles the response data for solar index requests.
    /// - Parameters:
    ///   - data: The data received from the network request.
    ///   - req: The type of solar index request.
    private func handleResponse(data: Data, for req: RequestIndex) {
        let decoder = JSONDecoder()
        do {
            switch req {
                case .aIndex:
                    let response = try decoder.decode(AIndexResponse.self, from: data)
                    if let firstInnerArray = response.data.first, let firstData = firstInnerArray.first {
                        DispatchQueue.main.async { self.aIndex = firstData }
                    }
                case .kIndex:
                    let response = try decoder.decode(KIndexResponse.self, from: data)
                    if let firstData = response.data.first {
                        DispatchQueue.main.async { self.kIndex = firstData }
                    }
                case .dstIndex:
                    logger.debug("Fetching DST Index")
                    let response = try decoder.decode(DSTIndexResponse.self, from: data)
                    if let firstInnerArray = response.data.first, let firstData = firstInnerArray.first {
                        DispatchQueue.main.async { self.dstIndex = firstData }
                    }
            }
        } catch {
            self.logger.error("Error decoding JSON: \(error.localizedDescription)")
            
            // Detailed error information
            if let decodingError = error as? DecodingError {
                switch decodingError {
                    case .typeMismatch(let type, let context):
                        self.logger.error("Type '\(String(describing: type))' mismatch: \(context.debugDescription)")
                        self.logger.error("codingPath: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
                    case .valueNotFound(let type, let context):
                        self.logger.error("Value '\(String(describing: type))' not found: \(context.debugDescription)")
                        self.logger.error("codingPath: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
                    case .keyNotFound(let key, let context):
                        self.logger.error("Key '\(key.stringValue)' not found: \(context.debugDescription)")
                        self.logger.error("codingPath: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
                    case .dataCorrupted(let context):
                        self.logger.error("Data corrupted: \(context.debugDescription)")
                        self.logger.error("codingPath: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
                    @unknown default:
                        self.logger.error("Unknown error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    /// Handles the response data for alert requests.
    /// - Parameters:
    ///   - data: The data received from the network request.
    ///   - alertType: The type of alert request.
    private func handleResponse(data: Data, for alertType: RequestAlerts) {
        let decoder = JSONDecoder()
        do {
            switch alertType {
                case .magAlert:
                    let response = try decoder.decode(MagAlertResponse.self, from: data)
                    if let firstData = response.data.first {
                        DispatchQueue.main.async { self.magAlert = firstData }
                    }
                case .magWarning:
                    let response = try decoder.decode(MagWarningResponse.self, from: data)
                    if let firstData = response.data.first {
                        DispatchQueue.main.async { self.magWarning = firstData }
                    }
                case .auroraAlert:
                    let response = try decoder.decode(AuroraAlertResponse.self, from: data)
                    if let firstData = response.data.first {
                        DispatchQueue.main.async { self.auroraAlert = firstData }
                    }
                case .auroraWatch:
                    let response = try decoder.decode(AuroraWatchResponse.self, from: data)
                    if let firstData = response.data.first {
                        DispatchQueue.main.async { self.auroraWatch = firstData }
                    }
                case .auroraOutlook:
                    let response = try decoder.decode(AuroraOutlookResponse.self, from: data)
                    if let firstData = response.data.first {
                        DispatchQueue.main.async { self.auroraOutlook = firstData }
                    }
            }
        } catch {
            self.logger.error("Error decoding JSON: \(error.localizedDescription)")
            
            // Detailed error information
            if let decodingError = error as? DecodingError {
                switch decodingError {
                    case .typeMismatch(let type, let context):
                        self.logger.error("Type '\(String(describing: type))' mismatch: \(context.debugDescription)")
                        self.logger.error("codingPath: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
                    case .valueNotFound(let type, let context):
                        self.logger.error("Value '\(String(describing: type))' not found: \(context.debugDescription)")
                        self.logger.error("codingPath: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
                    case .keyNotFound(let key, let context):
                        self.logger.error("Key '\(key.stringValue)' not found: \(context.debugDescription)")
                        self.logger.error("codingPath: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
                    case .dataCorrupted(let context):
                        self.logger.error("Data corrupted: \(context.debugDescription)")
                        self.logger.error("codingPath: \(context.codingPath.map { $0.stringValue }.joined(separator: " -> "))")
                    @unknown default:
                        self.logger.error("Unknown error: \(error.localizedDescription)")
                }
            }
        }
    }
}
