package adif_parser_cj
import std.collection.*

public struct SimpleAdif {
    public var header: Option<HashMap<String, String>> = None
    public var records: Option<ArrayList<HashMap<String, String>>> = None

    public init(header: Option<HashMap<String, String>>, records: Option<ArrayList<HashMap<String, String>>>) {
        this.header = header
        this.records = records
    }
}