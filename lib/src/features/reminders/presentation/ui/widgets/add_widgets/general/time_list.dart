


List<String> hourList = List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));
List<String> minList = List.generate(60, (index) => index.toString().padLeft(2, '0'));
List<String> periodList = ['AM', 'PM'];