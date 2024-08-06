package adif_parser_cj

public class AdifParser {
    private init() {}

    public static func parse(adi: String): SimpleAdif {
      return Parser(adi).parseTopLevel()
    }

    public static func formatter(obj: SimpleAdif): String {
      return Formatter(obj).format();
    }
}
