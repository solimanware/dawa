void BenchmarkMS(name, block){
  var start = new DateTime.now().millisecondsSinceEpoch;
  block();
  var end = new DateTime.now().millisecondsSinceEpoch;
  print("****************************");
  print("Benchmarking "+ name + " took " + (end-start).toString());
  print("****************************");
}