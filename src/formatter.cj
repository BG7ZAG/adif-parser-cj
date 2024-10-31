package adif_parser_cj
import std.collection.*
import std.core.*

/**
 * 将adi strut转为字符串
 */
public class Formatter {

    private var obj: SimpleAdif;

    init(obj: SimpleAdif) {
        this.obj = obj
    }

    /**
    * Format the given object into an ADIF string.
    */
    public func format(): String {
        var buffer = '';
        if(this.obj.header.isSome()) {
            var _header = this.obj.header.getOrThrow()
            buffer += _header.get("text").getOrDefault({=>""});
            buffer += '\n'
            _header.remove("text")
            buffer += this.formatTags(_header);
            buffer += '<eoh>\n\n';
        }

        if(this.obj.records.isNone()) {
            return this.prepReturn(buffer);
        }

        for (rec in this.obj.records.getOrDefault({=> ArrayList<HashMap<String, String>>()})) {
            buffer += this.formatTags(rec);
            buffer += '<eor>\n\n';
        }

        return this.prepReturn(buffer);
    }

    private func formatTags(header: HashMap<String, String>): String {
        var buffer: String = "";
        for ((key, value) in header) {

            let width =  value.size;
            buffer += "<${key}:${width}>${value}\n"
        }

        return buffer
    }

    private func prepReturn(buffer: String): String {
        let _buffer = buffer.trimAscii()

        if(_buffer.size == 0) {
            return _buffer
        }
        return _buffer + "\n"
    }
}
