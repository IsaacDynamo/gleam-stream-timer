export function query_selector(selectors) {
    return document.querySelector(selectors)
}

export function get(from, property) {
    return Reflect.get(from, property)
}

export function set(on, property, to) {
    return Reflect.set(on, property, to)
}

export function set_interval(fn, milliseconds) {
    window.setInterval(fn, milliseconds)
}

export function set_timeout(fn, milliseconds) {
    window.setTimeout(fn, milliseconds)
}

export function date_now() {
    return Date.now()
}

export function class_list_add(on, c) {
    on.classList.add(c)
}

export function class_list_remove(on, c) {
    on.classList.remove(c)
}