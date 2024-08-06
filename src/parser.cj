package adif_parser_cj
import std.collection.*
import std.convert.*

/*
 * 将adi字符串解析为strut
*/
public class Parser {
    private var cursor = 0;
    private var adi: String = "";

    init(adi: String) {
        this.adi = adi
    }

    public func parseTopLevel(): SimpleAdif {
        var parsed = SimpleAdif(None, None)

        // 如果为空
        if (this.adi.isEmpty()) {
            return parsed
        }

        // header
        if(!this.adi.startsWith('<')){
            var header = HashMap<String, String>()
            header['text'] = this.parseHeaderText()

            while (this.cursor < this.adi.size){
                let endOfHeader = this.parseTagValue(header);
                if (endOfHeader) {
                    break;
                }
            }

            parsed.header = header;
        }

        // QSO Records
        var records = ArrayList<HashMap<String, String>>()
        while (this.cursor < this.adi.size){
            let record = this.parseRecord();
            if (!record.isEmpty()) {
                records.append(record)
            }
        }

        if (records.size > 0) {
            parsed.records = records;
        }

        return parsed;
    }

    /**
    * 获取头部信息
    */
    private func parseHeaderText(): String {
        let startTag = this.indexOf('<', this.cursor);
        this.cursor = startTag.getOrThrow()
        return this.adi[..this.cursor].trimAscii()
    }

    /**
    * 从index处查找
    */
    private func indexOf(str: String, index: Int64): Option<Int64> {
        let sub_haystack = this.adi[index..];
        let startIndex = sub_haystack.indexOf(str);

        match (startIndex) {
            case  Some(idx) => Some(index + idx)
            case   None => None
        }
    }

    /**
    * 解析值
    */
    private func parseRecord(): HashMap<String, String> {
        var record = HashMap<String, String>()
        while (this.cursor < this.adi.size) {
            let endOfRecord = this.parseTagValue(record);
            if (endOfRecord) {
                break;
            }
        }
        return record;
    }

    private func parseTagValue(record: HashMap<String, String>): Bool {
        let startTag = this.indexOf('<', this.cursor);

        if(startTag.isNone()) {
            this.cursor = this.adi.size;
            return true
        }

        let startTagIndex = startTag.getOrThrow()
        let endTag = this.indexOf('>', startTagIndex).getOrThrow();
        let tagParts = this.adi[(startTagIndex+1)..endTag].split(":");

        if (tagParts[0].toAsciiLower() == 'eor' || tagParts[0].toAsciiLower() == 'eoh') {
            this.cursor = endTag + 1;
            return true;
        } else if (tagParts.size < 2) {
            if (this.adi[(startTagIndex + 1)..endTag] == 'APP_LoTW_EOF') {
                this.cursor = endTag + 1;
                return true;
            }
            let err_content = this.adi[(startTagIndex + 1)..(startTagIndex + 80)]
            let err = "Encountered field tag without enough parts near char ${startTag}: ${err_content}\n"
            throw NoneValueException(err);
        }

        let fieldName = tagParts[0].toAsciiLower();
        let width = Int64.parse(tagParts[1])
        let val_start = endTag + 1
        record[fieldName] = this.adi[val_start..(width + val_start)];
        this.cursor = val_start + width;

        return false
    }
}