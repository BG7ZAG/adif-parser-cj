package adif_parser_cj_demo
import adif_parser_cj.*

main(): Unit {
    let adi_obj = AdifParser.parse(adi_demo)
    println("adi_obj.header -> ${adi_obj.header}")
    println("adi_obj.records -> ${adi_obj.records}")
    let adi_str = AdifParser.formatter(adi_obj)
    println("adi_str -> ${adi_str}")
}