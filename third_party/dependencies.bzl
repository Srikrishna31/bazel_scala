load("//third_party/beautiful_scala:beautiful_scala.bzl", "load_beautiful_scala")
load("//third_party/scalaz:scalaz.bzl", "load_scalaz")
load("//third_party/joda_time:joda_time.bzl", "load_joda_time")

def load_deps():
    load_beautiful_scala()
    load_joda_time()
    load_scalaz()
