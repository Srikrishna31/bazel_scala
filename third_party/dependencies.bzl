load("//third_party/joda_time:joda_time.bzl", "load_joda_time")
load("//third_party/scalaz:scalaz.bzl", "load_scalaz")

def load_deps():
    load_joda_time()
    load_scalaz()
