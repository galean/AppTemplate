import Foundation
import CoreIntegrations

struct AttributionDataSource:AttributionServerDataSource {
    enum AttributionEndpoints: String, AttributionServerEndpointsProtocol {
        case install_server_path = "https://server.com/attribute"
        case purchase_server_path = "https://server.path"
    }
}
