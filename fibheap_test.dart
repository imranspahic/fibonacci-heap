import 'fibheap.dart';

class FibHeapTest {
  /// Metoda koja testira da li je ispravno povezana dvostruka litsa počevši od čvora [z].
  /// Vraća broj detektovanih čvorova na jednom nivou ili -1 u slučaju greške u povezivanju.
  int _testDvostrukoPovezaneListe(Cvor<num> z) {
    Cvor<num> x = z.desno;
    Cvor<num> y = z;
    int cvorova = 1;

    while (x != z) {
      if (x.lijevo != y || y.desno != x) {
        return -1;
      }

      y = x;
      x = x.desno;
      cvorova++;
    }

    if (x.lijevo != y || y.desno != x) {
      return -1;
    }

    return cvorova;
  }

  /// Testiranje FIB_HEAP_INSERT metode.
  void _testFibHeapInsert() {
    print("FibHeapTest: _testFibHeapInsert(): ");
    try {
      // 1. Ubacivanje elementa u praznu gomilu.
      FibHeap<num> fibHeap = FibHeap<num>(double.negativeInfinity);
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(5));
      assert(
          fibHeap.n == 1 && fibHeap.min != null && fibHeap.min!.vrijednost == 5,
          "Neispravno");
      print("   Ubacivanje elementa u praznu gomilu: ✅");

      // 2. Ubacivanje elemenata u nepraznu gomilu.
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(10));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(15));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(140));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(2000));

      assert(
          fibHeap.n == 5 && fibHeap.min != null && fibHeap.min!.vrijednost == 5,
          "Neispravno");
      print("   Ubacivanje više elemenata u nepraznu gomilu: ✅");

      // 3. Ubacivanje elementa u gomilu i promjena minimalnog čvora.
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(1));
      assert(
          fibHeap.n == 6 && fibHeap.min != null && fibHeap.min!.vrijednost == 1,
          "Neispravno");
      print("   Ubacivanje elementa u gomilu uz promjenu minimalnog čvora: ✅");

      // 4. Testiranje dvostruko povezane liste.
      int povezanoCvorova = _testDvostrukoPovezaneListe(fibHeap.min!);
      assert(povezanoCvorova == fibHeap.n, "Neispravno");
      print("   Dvostruko povezana lista: ✅");
    } catch (error) {
      print("FibHeapTest: _testFibHeapInsert(): error=$error ❌");
    }
  }

  /// Testiranje FIB_HEAP_UNION metode.
  void _testFibHeapUnion() {
    print("FibHeapTest: _testFibHeapUnion(): ");
    try {
      FibHeap<num> fibHeap1 = FibHeap<num>(double.negativeInfinity);
      FibHeap<num> fibHeap2 = FibHeap<num>(double.negativeInfinity);
      late FibHeap<num> fibHeap;

      // 1. Obe gomile prazne.
      fibHeap = fibHeap1.FIB_HEAP_UNION(fibHeap2);
      assert(fibHeap.n == 0 && fibHeap.min == null, "Neispravno");
      print("   Obe gomile prazne: ✅");

      // 2. Druga gomila prazna.
      fibHeap1 = FibHeap<num>(double.negativeInfinity);
      fibHeap2 = FibHeap<num>(double.negativeInfinity);
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(6));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(19));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(7));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(13));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(3));
      fibHeap = fibHeap1.FIB_HEAP_UNION(fibHeap2);
      assert(
          fibHeap.n == 5 && fibHeap.min != null && fibHeap.min!.vrijednost == 3,
          "Neispravno");
      print("   Druga gomila prazna: ✅");

      // 3. Obe gomile neprazne, min je iz prve gomile.
      fibHeap1 = FibHeap<num>(double.negativeInfinity);
      fibHeap2 = FibHeap<num>(double.negativeInfinity);
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(6));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(19));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(7));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(13));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(3));
      fibHeap2.FIB_HEAP_INSERT(Cvor<num>(8));
      fibHeap2.FIB_HEAP_INSERT(Cvor<num>(9));
      fibHeap2.FIB_HEAP_INSERT(Cvor<num>(30));
      fibHeap = fibHeap1.FIB_HEAP_UNION(fibHeap2);
      assert(
          fibHeap.n == 8 && fibHeap.min != null && fibHeap.min!.vrijednost == 3,
          "Neispravno");
      print("   Obe gomile neprazne, min je iz prve gomile: ✅");

      // 4. Obe gomile neprazne, min je iz druge gomile.
      fibHeap1 = FibHeap<num>(double.negativeInfinity);
      fibHeap2 = FibHeap<num>(double.negativeInfinity);
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(6));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(19));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(7));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(13));
      fibHeap1.FIB_HEAP_INSERT(Cvor<num>(3));
      fibHeap2.FIB_HEAP_INSERT(Cvor<num>(8));
      fibHeap2.FIB_HEAP_INSERT(Cvor<num>(9));
      fibHeap2.FIB_HEAP_INSERT(Cvor<num>(30));
      fibHeap2.FIB_HEAP_INSERT(Cvor<num>(2));
      fibHeap = fibHeap1.FIB_HEAP_UNION(fibHeap2);
      assert(
          fibHeap.n == 9 && fibHeap.min != null && fibHeap.min!.vrijednost == 2,
          "Neispravno");
      print("   Obe gomile neprazne, min je iz druge gomile: ✅");

      // 5. Testiranje dvostruko povezane liste.
      int povezanoCvorova = _testDvostrukoPovezaneListe(fibHeap.min!);
      assert(povezanoCvorova == fibHeap.n,
          "Neispravno ${povezanoCvorova}, ${fibHeap.n}");
      print("   Dvostruko povezana lista: ✅");
    } catch (error) {
      print("FibHeapTest: _testFibHeapUnion(): error=$error ❌");
    }
  }

  /// Testiranje FIB_HEAP_EXTRACT_MIN metode.
  void _testFibHeapExtractMin() {
    print("FibHeapTest: _testFibHeapExtractMin(): ");
    try {
      FibHeap<num> fibHeap = FibHeap(double.negativeInfinity);
      late Cvor<num>? x;

      // 1. Prazna gomila.
      x = fibHeap.FIB_HEAP_EXTRACT_MIN();
      assert(fibHeap.n == 0 && fibHeap.min == null && x == null, "Neispravno");
      print("   Prazna gomila: ✅");

      // 2. Gomila sadrži jedan čvor.
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(5));
      x = fibHeap.FIB_HEAP_EXTRACT_MIN();
      assert(fibHeap.n == 0 && fibHeap.min == null && x?.vrijednost == 5,
          "Neispravno");
      print("   Gomila sadrži jedan čvor: ✅");

      // 3. Gomila sadrži dva čvora.
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(100));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(200));
      x = fibHeap.FIB_HEAP_EXTRACT_MIN();
      assert(
          fibHeap.n == 1 &&
              fibHeap.min != null &&
              fibHeap.min!.vrijednost == 200 &&
              x?.vrijednost == 100,
          "Neispravno");
      print("   Gomila sadrži dva čvora: ✅");

      // 4. Gomila sadrži više istih minimalnih čvorova.
      fibHeap = FibHeap(double.negativeInfinity);
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(95));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(95));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(95));
      x = fibHeap.FIB_HEAP_EXTRACT_MIN();

      assert(
          fibHeap.n == 2 &&
              fibHeap.min != null &&
              fibHeap.min!.vrijednost == 95 &&
              x?.vrijednost == 95,
          "Neispravno");
      print("   Gomila sadrži više istih minimalnih čvorova: ✅");

      // 5. Testiranje dvostruko povezane liste.
      int povezanoCvorova = _testDvostrukoPovezaneListe(fibHeap.min!);
      assert(povezanoCvorova != -1, "Neispravno");
      print("   Dvostruko povezana lista: ✅");
    } catch (error, stacktrace) {
      print("FibHeapTest: _testFibHeapExtractMin(): error=$error ❌");
      print(stacktrace);
    }
  }

  /// Testiranje CONSOLIDATE metode.
  void _testConsolidate() {
    print("FibHeapTest: _testConsolidate(): ");
    try {
      FibHeap<num> fibHeap = FibHeap(double.negativeInfinity);
      late Cvor<num>? x;

      // 1. Test 1 sa više operacija CONSOLIDATE
      fibHeap = FibHeap(double.negativeInfinity);
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(16));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(25));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(27));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(19));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(3));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(8));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(54));

      x = fibHeap.FIB_HEAP_EXTRACT_MIN();

      assert(
          fibHeap.n == 6 &&
              fibHeap.min != null &&
              fibHeap.min!.vrijednost == 8 &&
              x?.vrijednost == 3,
          "Neispravno");

      int t1 = _testDvostrukoPovezaneListe(fibHeap.min!);
      int t2 = _testDvostrukoPovezaneListe(fibHeap.min!.desno.dijete!);
      int s1 = fibHeap.min!.stepen;
      int s2 = fibHeap.min!.desno.stepen;
      assert(t1 == 2 && s1 == 1 && s2 == 2 && t2 == 2, "Neispravno");
      print("   Test 1 sa više operacija CONSOLIDATE: ✅");

      // 2. Test 2 sa više operacija CONSOLIDATE
      fibHeap = FibHeap(double.negativeInfinity);
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(100));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(26));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(28));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(29));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(19));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(18));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(103));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(240));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(16));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(17));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(31));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(62));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(63));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(61));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(3));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(14));
      x = fibHeap.FIB_HEAP_EXTRACT_MIN();

      int t = _testDvostrukoPovezaneListe(fibHeap.min!);
      assert(t == 4, "Neispravno");
      print("   Test 2 sa više operacija CONSOLIDATE: ✅");
    } catch (error) {
      print("FibHeapTest: _testConsolidate(): error=$error ❌");
    }
  }

  /// Testiranje FIB_HEAP_LINK metode.
  void _testFibHeapLink() {
    print("FibHeapTest: _testFibHeapLink(): ");
    try {
      late FibHeap<num> fibHeap;
      late Cvor<num> x1;
      late Cvor<num> x2;

      // 1. Povezivanje dva čvora.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      x1 = Cvor<num>(5);
      x2 = Cvor<num>(6);
      fibHeap.FIB_HEAP_INSERT(x1);
      fibHeap.FIB_HEAP_INSERT(x2);
      fibHeap.FIB_HEAP_LINK(x2, x1);

      assert(
          fibHeap.n == 2 &&
              fibHeap.min != null &&
              fibHeap.min!.vrijednost == 5 &&
              fibHeap.min!.dijete == x2,
          "Neispravno");
      print("   Povezivanje dva čvora: ✅");

      // 2. Provjera ispravnosti liste nakon povezivanja 2 čvora.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      x1 = Cvor<num>(5);
      x2 = Cvor<num>(6);
      fibHeap.FIB_HEAP_INSERT(x1);
      fibHeap.FIB_HEAP_INSERT(x2);
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(7));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(8));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(9));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(10));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(11));
      fibHeap.FIB_HEAP_LINK(x2, x1);

      assert(
          fibHeap.n == 7 &&
              fibHeap.min != null &&
              fibHeap.min!.vrijednost == 5 &&
              fibHeap.min!.dijete == x2,
          "Neispravno");
      int x = _testDvostrukoPovezaneListe(fibHeap.min!);
      assert(x == 6, "Neispravno");
      print("   Provjera ispravnosti liste nakon povezivanja 2 čvora: ✅");
    } catch (error) {
      print("FibHeapTest: _testFibHeapLink(): error=$error ❌");
    }
  }

  /// Testiranje FIB_HEAP_DECREASE_KEY metode.
  void _testFibHeapDecreaseKey() {
    print("FibHeapTest: _testFibHeapDecreaseKey(): ");
    try {
      late FibHeap<num> fibHeap;
      late bool status;

      // 1. Prazna gomila.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      fibHeap.FIB_HEAP_DECREASE_KEY(5, 4);
      assert(fibHeap.n == 0 && fibHeap.min == null, "Neispravno");
      print("   Prazna gomila: ✅");

      // 2. Nije pronađen čvor.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(19));
      status = fibHeap.FIB_HEAP_DECREASE_KEY(5, 4);
      assert(fibHeap.n == 1 && fibHeap.min!.vrijednost == 19 && !status,
          "Neispravno");
      print("   Nije pronađen čvor: ✅");

      // 3. Ključ veći od trenutnog.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(19));
      status = fibHeap.FIB_HEAP_DECREASE_KEY(19, 100);
      assert(fibHeap.n == 1 && fibHeap.min!.vrijednost == 19 && !status,
          "Neispravno");
      print("   Ključ veći od trenutnog: ✅");

      // 4. Smanjivanje ključa.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(19));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(25));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(29));

      status = fibHeap.FIB_HEAP_DECREASE_KEY(25, 7);
      assert(fibHeap.n == 3 && fibHeap.min!.vrijednost == 7 && status,
          "Neispravno");
      print("   Bez CUT operacija: ✅");

      // 5. Uz CUT i CASCADING CUT operacije.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      Cvor<num> x1 = Cvor<num>(21);
      Cvor<num> x2 = Cvor<num>(13);
      Cvor<num> x3 = Cvor<num>(17);
      Cvor<num> x4 = Cvor<num>(11);

      fibHeap.FIB_HEAP_INSERT(Cvor<num>(1));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(6));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(9));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(2));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(10));
      fibHeap.FIB_HEAP_INSERT(x4);
      fibHeap.FIB_HEAP_INSERT(x3);
      fibHeap.FIB_HEAP_INSERT(x1);
      fibHeap.FIB_HEAP_INSERT(x2);

      fibHeap.FIB_HEAP_EXTRACT_MIN();
      fibHeap.FIB_HEAP_DECREASE_KEY(17, 4);
      fibHeap.FIB_HEAP_DECREASE_KEY(13, 9);

      print("   Uz CUT i CASCADING CUT operacije: ✅");
    } catch (error, stacktrace) {
      print("FibHeapTest: _testFibHeapDecreaseKey(): error=$error ❌");
      print(stacktrace);
    }
  }

  /// Testiranje CUT metode.
  void _testCut() {
    print("FibHeapTest: _testCut(): ");
    try {
      late FibHeap<num> fibHeap;

      // 1. CUT čvora bez djeteta.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      Cvor<num> x1 = Cvor<num>(21);
      Cvor<num> x2 = Cvor<num>(13);
      Cvor<num> x3 = Cvor<num>(17);
      Cvor<num> x4 = Cvor<num>(11);

      fibHeap.FIB_HEAP_INSERT(Cvor<num>(1));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(6));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(9));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(2));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(10));
      fibHeap.FIB_HEAP_INSERT(x4);
      fibHeap.FIB_HEAP_INSERT(x3);
      fibHeap.FIB_HEAP_INSERT(x1);
      fibHeap.FIB_HEAP_INSERT(x2);

      fibHeap.FIB_HEAP_EXTRACT_MIN();

      int s1 = _testDvostrukoPovezaneListe(fibHeap.min!);
      fibHeap.CUT(x1, x2);
      int s2 = _testDvostrukoPovezaneListe(fibHeap.min!);
      assert(
          fibHeap.n == 8 && fibHeap.min!.vrijednost == 2 && s1 == 1 && s2 == 2,
          "Neispravno");
      print("   CUT čvora bez djeteta: ✅");

      // 2. CUT čvora sa djetetom.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      x1 = Cvor<num>(21);
      x2 = Cvor<num>(13);
      x3 = Cvor<num>(17);
      x4 = Cvor<num>(11);
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(1));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(6));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(9));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(2));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(10));
      fibHeap.FIB_HEAP_INSERT(x4);
      fibHeap.FIB_HEAP_INSERT(x3);
      fibHeap.FIB_HEAP_INSERT(x1);
      fibHeap.FIB_HEAP_INSERT(x2);

      fibHeap.FIB_HEAP_EXTRACT_MIN();

      s1 = _testDvostrukoPovezaneListe(fibHeap.min!);
      fibHeap.CUT(x2, x4);
      s2 = _testDvostrukoPovezaneListe(fibHeap.min!);
      assert(
          fibHeap.n == 8 && fibHeap.min!.vrijednost == 2 && s1 == 1 && s2 == 2,
          "Neispravno");
      assert(x1.roditelj == x2 && x2.dijete == x1, "Neispravno");
      print("   CUT čvora sa djetetom: ✅");
    } catch (error, stacktrace) {
      print("FibHeapTest: _testCut(): error=$error ❌");
      print(stacktrace);
    }
  }

  /// Testiranje CASCADING_CUT metode.
  void _testCascadingCut() {
    print("FibHeapTest: _testCascadingCut(): ");
    try {
      late FibHeap<num> fibHeap;

      // 1. CASCADE CUT čvorova.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      Cvor<num> x1 = Cvor<num>(21);
      Cvor<num> x2 = Cvor<num>(13);
      Cvor<num> x3 = Cvor<num>(17);
      Cvor<num> x4 = Cvor<num>(11);

      fibHeap.FIB_HEAP_INSERT(Cvor<num>(1));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(6));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(9));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(2));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(10));
      fibHeap.FIB_HEAP_INSERT(x4);
      fibHeap.FIB_HEAP_INSERT(x3);
      fibHeap.FIB_HEAP_INSERT(x1);
      fibHeap.FIB_HEAP_INSERT(x2);

      fibHeap.FIB_HEAP_EXTRACT_MIN();

      int s1 = _testDvostrukoPovezaneListe(fibHeap.min!);
      fibHeap.CASCADING_CUT(x1);
      fibHeap.CASCADING_CUT(x1);
      fibHeap.CASCADING_CUT(x2);
      fibHeap.CASCADING_CUT(x2);
      fibHeap.CASCADING_CUT(x3);
      fibHeap.CASCADING_CUT(x3);
      int s2 = _testDvostrukoPovezaneListe(fibHeap.min!);

      assert(
          fibHeap.n == 8 && fibHeap.min!.vrijednost == 2 && s1 == 1 && s2 == 5,
          "Neispravno");
      print("   CASCADING CUT čvorova: ✅");
    } catch (error, stacktrace) {
      print("FibHeapTest: _testCascadingCut(): error=$error ❌");
      print(stacktrace);
    }
  }

  /// Testiranje FIB_HEAP_DELETE metode.
  void _testFibHeapDelete() {
    print("FibHeapTest: _testFibHeapDelete(): ");
    try {
      late FibHeap<num> fibHeap;

      // 1. Prazna gomila.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      fibHeap.FIB_HEAP_DELETE(5);
      assert(fibHeap.n == 0 && fibHeap.min == null, "Neispravno");
      print("   Prazna gomila: ✅");

      // 2. Nepostojeći čvor.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(6));
      fibHeap.FIB_HEAP_DELETE(5);
      assert(fibHeap.n == 1 && fibHeap.min!.vrijednost == 6, "Neispravno");
      print("   Nepostojeći čvor: ✅");

      // 3. Brisanje čvora.
      fibHeap = FibHeap<num>(double.negativeInfinity);
      Cvor<num> x1 = Cvor<num>(21);
      Cvor<num> x2 = Cvor<num>(13);
      Cvor<num> x3 = Cvor<num>(17);
      Cvor<num> x4 = Cvor<num>(11);

      fibHeap.FIB_HEAP_INSERT(Cvor<num>(1));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(6));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(9));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(2));
      fibHeap.FIB_HEAP_INSERT(Cvor<num>(10));
      fibHeap.FIB_HEAP_INSERT(x4);
      fibHeap.FIB_HEAP_INSERT(x3);
      fibHeap.FIB_HEAP_INSERT(x1);
      fibHeap.FIB_HEAP_INSERT(x2);
      fibHeap.FIB_HEAP_EXTRACT_MIN();

      fibHeap.FIB_HEAP_DELETE(17);
      assert(fibHeap.n == 7 && fibHeap.min!.vrijednost == 2, "Neispravno");
      print("   Brisanje čvora: ✅");
    } catch (error, stacktrace) {
      print("FibHeapTest: _testFibHeapDelete(): error=$error ❌");
      print(stacktrace);
    }
  }

  void runTests() {
    _testFibHeapInsert();
    _testFibHeapUnion();
    _testFibHeapExtractMin();
    _testConsolidate();
    _testFibHeapLink();
    _testFibHeapDecreaseKey();
    _testCut();
    _testCascadingCut();
    _testFibHeapDelete();
  }
}
