import 'dart:async';

Future<void> main() async {
  print("666");
  createStreamByController();
  print("222");
  await Future.delayed(const Duration(seconds: 8));
  print("333");

}

Future<void> transformStream() async {
  Stream<int> stream = Stream.periodic(const Duration(seconds: 1), (num) { return num;});
  stream = stream.takeWhile((element) => element < 5);
  stream = stream.skip(2);
  printStream(stream);
}

/// ******************一 创建流Stream的几种方式*******************

/// 1. 创建一个无限数据流，每隔一段指定的时间，就执行一个回调，回调的返回值组成的数据集合就是
/// 数据流Stream的数据集
Future<void> createStreamByPeriodic() async {
  Stream<String> stream = Stream<String>.periodic(Duration(seconds: 1), (num){
    print(num);
    return num % 2 == 0 ? "o" : "j";
  });
  printStream(stream);
}

/// 2. 根据一个Future创建数据流，数据流里面只有一个值
Future<void> createStreamByFuture() async {
  Stream<String> stream = Stream<String>.fromFuture(Future(
          (){ return "future";}
  ));
  printStream(stream);
}

/// 3. 根据Future集合创建数据流
Future<void> createStreamByFutureList() async {
  Stream stream = Stream.fromFutures([
    Future.delayed(Duration(seconds: 1), () {
      print("create task 1");

      return "task 1";
    }),
    Future.delayed(Duration(seconds: 2), () {
      print("create task 2");
      var a;
      a.length;
      return "task 2";
    }),
  ]);
  printStream(stream);
}

/// 4. 根据迭代器创建数据流
Future<void> createStreamByIterable() async {
  Stream<int> stream = Stream<int>.fromIterable([1,2,3]);
  printStream(stream);
}

/// ******************一 创建流Stream的几种方式*******************

void printStream(Stream stream) {
  printStreamByListen(stream);
}

/// 输出流数据的几种方式

/// 1. 使用 await for 输出流数据
Future<void> printStreamByAwait(Stream stream) async {
  await for(var element in stream){
    print(element);
  }
}

/// 2. 使用 forEach 输出流数据
void printStreamByForEach(Stream stream) {
  stream.forEach((element) {
    print(element);
  });
}

/// 3. 使用 listen 输出流数据
void printStreamByListen(Stream stream) {
  stream.listen(
    (event) {
      print(event);
    },
    onDone: (){
      print("***onDone");
    },
    onError: (error){
      print("***onError: $error");
    },
    cancelOnError: false
  );
}

void createStreamByController() {
  StreamController controller = StreamController();
  controller.add(1);
  controller.sink.add(2);
  printStream(controller.stream);
  controller.add(3);
  controller.addError(3);
  controller.add(4);
  controller.close();

}

Future<void> testDebounceStream() async {
  DebounceStream<int> stream = DebounceStream();
  stream.debounceTime(200).listen((event) {
    print(event);
  });
  stream.add(1);
  stream.add(2);
  stream.add(3);
  stream.add(4);
  await Future.delayed(Duration(milliseconds: 300));
  stream.add(5);
  stream.add(6);
  await Future.delayed(Duration(milliseconds: 300));
  stream.add(7);
  stream.add(8);

}

class DebounceStream<T> extends Stream<T>{
  late StreamController<T> _controller;
  int lastTime = 0;
  DebounceStream() {
    _controller = StreamController();
  }

  @override
  StreamSubscription<T> listen(void Function(T event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _controller.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void add(T element) {
    _controller.add(element);
  }

  Stream debounceTime(int duration) {
    StreamTransformer<T, T> stf = StreamTransformer<T, T>.fromHandlers(
        handleData: (element, sink){
          int nowTime = DateTime.now().millisecondsSinceEpoch;
          if(nowTime - lastTime > duration) {
            lastTime = nowTime;
            sink.add(element);
          }
        }
    );
    return _controller.stream.transform(stf);
  }

}
