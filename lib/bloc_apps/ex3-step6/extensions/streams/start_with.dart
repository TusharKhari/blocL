//

import 'package:async/async.dart' show StreamGroup;

extension StartWith<T> on Stream<T> {

   /*
   
   this:  start | wait 10 sec --------------- produce element X 
   stream.value | X |
   merge : | X ------------- X ------------------X


    */


  Stream<T> startWith(T value) => StreamGroup.merge([
    this,
    Stream<T>.value(value),

  ]);
}
