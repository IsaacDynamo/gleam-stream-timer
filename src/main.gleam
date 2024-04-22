import gleam/int
import gleam/string
import gleam/result

pub fn main() {
  let start = date_now()
  let timer = query_selector("#timer")
  let lucy = query_selector("#lucy img")

  tick(start, timer, lucy)
}

fn tick(start, timer, lucy) {
  let delta = date_now() - start

  set_timeout(fn() { tick(start, timer, lucy) } , 1000 - { delta  % 1000 } + 100 )

  let sec = delta / 1000 % 60
  let min = delta / {1000 * 60} % 60
  let hours =  delta / {1000 * 60 * 60}

  let double_digit = fn(x) { x |> int.to_base_string(10) |> result.unwrap("??") |> string.pad_left(2, with: "0") }
  let hh = hours |> double_digit
  let mm = min |> double_digit
  let ss = sec |> double_digit

  let format = hh <> ":" <> mm <> ":" <> ss

  set("innerText", on: timer, to: format)

  let secs = delta / 1000
  case secs % 2 {
    0 -> lucy |> class_list_add("move")
    _ -> lucy |> class_list_remove("move")
  }

  case secs % 7 {
    0 -> lucy |> class_list_add("happy")
    _ -> lucy |> class_list_remove("happy")
  }
}

pub type Element

@external(javascript, "./ffi.mjs", "query_selector")
pub fn query_selector(selectors: String) -> Element

@external(javascript, "./ffi.mjs", "get")
pub fn get(from from: Element, property property: String) -> String

@external(javascript, "./ffi.mjs", "set")
pub fn set(on on: Element, property property: String, to to: anything) -> Bool

@external(javascript, "./ffi.mjs", "set_interval")
pub fn set_interval(function: anything, milliseconds: Int) -> Nil

@external(javascript, "./ffi.mjs", "set_timeout")
pub fn set_timeout(function: anything, milliseconds: Int) -> Nil

@external(javascript, "./ffi.mjs", "date_now")
pub fn date_now() -> Int

@external(javascript, "./ffi.mjs", "class_list_add")
pub fn class_list_add(on: Element, c: String) -> Nil

@external(javascript, "./ffi.mjs", "class_list_remove")
pub fn class_list_remove(on: Element, c: String) -> Nil
