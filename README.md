<div align="center">
<h1>adif-parser-cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.53.4-brightgreen" style="display: inline-block;" />
</p>

## 介绍

用于业余无线电联络日志ADIF文件解析，本仓库基于 [adif-parser-ts](https://github.com/k0swe/adif-parser-ts) 翻译成仓颉版

### 特性

- 🚀 解析adi序列化成strut

- 🚀 根据strut生成adi文件

## 使用

### 编译

```shell
git clone https://github.com/BG7ZAG/adif-parser-cj
cd adif-parser-cj
cjpm build
```

### 在`cjpm.toml`中引入

```toml
[dependencies]
  adif_parser_cj = { path = "/path/to/adif_parser_cj", version = "0.0.1"}
```

### 代码中使用

```cangjie
import adif_parser_cj.*

main(): Unit {
    let adi_obj = AdifParser.parse(adi)
    println("adi_obj.header -> ${adi_obj.header}")
    println("adi_obj.records -> ${adi_obj.records}")

    let adi_str = AdifParser.formatter(adi_obj)
    println("adi_str -> ${adi_str}")
}
```

## 更新日志

[CHANGELOG](CHANGELOG.md)

## 开源协议

本项目基于 [MulanPSL2](LICENSE) , 请自由享受和参与开源

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。
