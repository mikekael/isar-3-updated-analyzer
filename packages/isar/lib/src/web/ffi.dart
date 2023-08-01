// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:isar/isar.dart';
import 'package:isar/src/web/interop.dart';

typedef Pointer<T> = int;

class NativeType {}

@pragma('dart2js:tryInline')
Pointer<T> ptrFromAddress<T>(int addr) => addr;

late final JSIsar b = IsarCore.b as JSIsar;

extension PointerX on int {
  @pragma('dart2js:tryInline')
  Pointer<T> cast<T>() => this;

  @pragma('dart2js:tryInline')
  Pointer<void> get ptrValue => b.u32Heap[address ~/ 4];

  @pragma('dart2js:tryInline')
  set ptrValue(Pointer<void> ptr) => b.u32Heap[address ~/ 4] = ptr;

  @pragma('dart2js:tryInline')
  void setPtrAt(int index, Pointer<void> ptr) {
    b.u32Heap[address ~/ 4 + index] = ptr;
  }

  @pragma('dart2js:tryInline')
  bool get boolValue => b.u8Heap[address] != 0;

  @pragma('dart2js:tryInline')
  int get u32Value => b.u32Heap[address ~/ 4];

  @pragma('dart2js:tryInline')
  int get address => this;

  @pragma('dart2js:tryInline')
  Uint8List asU8List(int length) =>
      b.u8Heap.buffer.asUint8List(address, length);

  @pragma('dart2js:tryInline')
  Uint16List asU16List(int length) =>
      b.u16Heap.buffer.asUint16List(address, length);
}

const nullptr = 0;

class Native<T> {
  const Native({String? symbol});
}

class Void {}

class Bool {}

class Uint8 {}

class Int8 {}

class Uint16 {}

class Uint32 {}

typedef Char = Uint8;

class Int32 {}

class Int64 {}

class Float {}

class Double {}

class Opaque {}

class NativeFunction<T> {}

const _sizes = {
  int: 4, // pointer
  Void: 0,
  Bool: 1,
  Uint8: 1,
  Int8: 1,
  Uint16: 2,
  Uint32: 4,
  Int32: 4,
  Int64: 8,
  Float: 4,
  Double: 8,
};

Pointer<T> malloc<T>([int length = 1]) {
  final addr = b.malloc(length * _sizes[T]!);
  return addr;
}

void free(Pointer<void> ptr) {
  b.free(ptr.address);
}
