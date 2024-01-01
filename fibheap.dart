import 'dart:math';

import 'fibheap_test.dart';

double logBase(num x, num base) => log(x) / log(base);
double log2(num x) => logBase(x, 2);

class Cvor<T extends Comparable<T>> {
  T vrijednost;

  Cvor<T>? roditelj;
  Cvor<T>? dijete;
  late Cvor<T> desno;
  late Cvor<T> lijevo;

  int stepen = 0;
  bool mark = false;

  // Oznaka prilikom pretrage čvora po vrijednosti.
  bool posjecen = false;

  Cvor(
    this.vrijednost,
  ) {
    desno = this;
    lijevo = this;
  }

  @override
  operator ==(other) => other is Cvor && identical(this, other);

  @override
  int get hashCode => vrijednost.hashCode;

  @override
  String toString() {
    return "ključ:$vrijednost, mark:$mark, stepen:$stepen, roditelj:(kljuc:${roditelj?.vrijednost}, mark:${roditelj?.mark}, stepen:${roditelj?.stepen}), dijete:(kljuc:${dijete?.vrijednost}, mark:${dijete?.mark}, stepen:${dijete?.stepen}), lijevo:(kljuc:${lijevo.vrijednost}, mark:${lijevo.mark}, stepen:${lijevo.stepen}), desno:(kljuc:${desno.vrijednost}, mark:${desno.mark}, stepen:${desno.stepen})\n";
  }
}

class FibHeap<T extends Comparable<T>> {
  final T ninf;
  late Cvor<T>? min;
  late int n;

  FibHeap(this.ninf) {
    min = null;
    n = 0;
  }

  void _ispis(Cvor<T>? x) {
    if (x == null) {
      return;
    }
    Cvor<T> y = x;

    do {
      print("y=$y");

      _ispis(y.dijete);

      y = y.desno;
    } while (y != x);
  }

  void ispis(Cvor<T> x) {
    print("y=$x");
    _ispis(x.dijete);
  }

  /// Pomoćna metoda koja povezuje čvorove [x] i [y] u dvostruko povezanu listu.
  void _FIB_HEAP_MULTI_LINK(Cvor<T> x, Cvor<T> y) {
    x.lijevo.desno = y;
    y.lijevo.desno = x;

    Cvor<T> temp = x.lijevo;
    x.lijevo = y.lijevo;
    y.lijevo = temp;
  }

  /// Pomoćna metoda koja povezuje čvorove [x] i [y] u dvostruko povezanu listu.
  void _FIB_HEAP_BETWEEN_LINK(Cvor<T> x, Cvor<T> y) {
    x.lijevo.desno = y;
    y.desno = x;
    y.lijevo = x.lijevo;
    x.lijevo = y;
  }

  /// Pomoćna metoda koja uklanja čvor [x] iz dvostruko povezane liste.
  /// Potrebno prilikom uklanjanja čvora iz liste korijena u [FIB_HEAP_EXTRACT_MIN] metodi.
  void _FIB_HEAP_REMOVE_LINK(Cvor<T> x) {
    x.lijevo.desno = x.desno;
    x.desno.lijevo = x.lijevo;
  }

  /// Metoda koja dodaje čvor [x] u gomilu.
  /// Ubacuje čvor u listu korijena i ažurira [min] čvor u gomili.
  void FIB_HEAP_INSERT(Cvor<T> x) {
    if (min == null) {
      min = x;
    } else {
      _FIB_HEAP_BETWEEN_LINK(min!, x);
      if (x.vrijednost.compareTo(min!.vrijednost) < 0) {
        min = x;
      }
    }
    n++;
  }

  /// Metoda koja spaja dvije gomile: gomila nad kojom je pozvana metoda i gomila [h1].
  /// Vraća spojenu gomilu kao rezultat.
  FibHeap<T> FIB_HEAP_UNION(FibHeap<T> h1) {
    final FibHeap<T> h = FibHeap<T>(ninf);
    h.min = min;

    if (h.min != null && h1.min != null) {
      _FIB_HEAP_MULTI_LINK(h.min!, h1.min!);
    }

    if (min == null ||
        (h1.min != null && h1.min!.vrijednost.compareTo(min!.vrijednost) < 0)) {
      h.min = h1.min;
    }
    h.n = n + h1.n;
    return h;
  }

  /// Metoda koja izbacuje i vraća minimalni element iz gomile.
  Cvor<T>? FIB_HEAP_EXTRACT_MIN() {
    Cvor<T>? z = min;

    if (z != null) {
      Cvor<T>? dijete = z.dijete;

      // Ubacivanje djece u listu korijena gomile.
      if (dijete != null) {
        Cvor<T> temp = dijete.desno;
        do {
          _FIB_HEAP_BETWEEN_LINK(min!, temp);
          temp.roditelj = null;
          temp = dijete.desno;
        } while (temp != dijete);
      }

      // Brisanje najmanjeg čvora iz liste korijena.
      _FIB_HEAP_REMOVE_LINK(z);

      if (z == z.desno) {
        min = null;
      } else {
        min = z.desno;
        CONSOLIDATE();
      }

      n--;
    }

    return z;
  }

  /// Metoda koja grupiše/spaja gomile na osnovu stepena te rekonstruiše/popravlja novu gomilu radi optimizacije operacija.
  void CONSOLIDATE() {
    final List<Cvor<T>?> A = List.generate(log2(n).floor() + 1, (_) => null);

    Cvor<T> x = min!;

    // Prolazak kroz listu korijena gomile.
    do {
      int d = x.stepen;
      while (A[d] != null) {
        // Postoji gomila istog stepena.
        Cvor<T> y = A[d]!;

        // Provjera vrijednosti radi ispravnog povezivanja i očuvanja poretka.
        if (x.vrijednost.compareTo(y.vrijednost) >= 0) {
          Cvor<T> temp = x;
          x = y;
          y = temp;
        }

        // Povezivanje dvije gomile istog stepena d.
        FIB_HEAP_LINK(y, x);

        A[d] = null;

        d++;
      }

      // Ažuriranje spojene gomile sa novim stepenom d+1.
      A[d] = x;

      if (x == x.desno) {
        break;
      }
      x = x.desno;
    } while (x != min);

    min = null;

    // Rekonstrukcija liste korijena i ažuriranje minimalnog čvora.
    for (final Cvor<T>? c in A) {
      if (c == null) {
        continue;
      }
      c.lijevo = c;
      c.desno = c;
      if (min == null) {
        min = c;
      } else {
        _FIB_HEAP_BETWEEN_LINK(min!, c);
        if (c.vrijednost.compareTo(min!.vrijednost) < 0) {
          min = c;
        }
      }
    }
  }

  /// Metoda koja dodaje čvor [y] kao dijete čvora [x].
  void FIB_HEAP_LINK(Cvor<T> y, Cvor<T> x) {
    _FIB_HEAP_REMOVE_LINK(y);

    y.lijevo = y;
    y.desno = y;
    y.roditelj = x;
    y.mark = false;

    if (x.dijete == null) {
      x.dijete = y;
    }

    _FIB_HEAP_BETWEEN_LINK(x.dijete!, y);
    x.stepen++;
  }

  /// Pomoćna metoda koja pronalazi čvor sa ključem [vrijednost] u gomili sa korijenom [x].
  Cvor<T>? FIB_HEAP_FIND(Cvor<T>? x, T vrijednost) {
    if (x == null) {
      return null;
    }
    Cvor<T>? y;
    x.posjecen = true;

    if (x.vrijednost == vrijednost) {
      y = x;
      x.posjecen = false;
      return x;
    }

    if (x.dijete != null) {
      Cvor<T>? z = FIB_HEAP_FIND(x.dijete, vrijednost);
      if (z != null) {
        y = z;
      }
    }

    if (!x.desno.posjecen) {
      Cvor<T>? z = FIB_HEAP_FIND(x.desno, vrijednost);
      if (z != null) {
        y = z;
      }
    }

    x.posjecen = false;
    return y;
  }

  /// Metoda koja postavlja ključ čvoru sa ključem [vrijednost] na novi ključ [k].
  /// Vraća vrijednost da li je moguće izvršiti operaciju ili ne.
  bool FIB_HEAP_DECREASE_KEY(T vrijednost, T k) {
    // Ključ veći od trenutnog.
    if (k.compareTo(vrijednost) > 0) {
      return false;
    }

    Cvor<T>? x = FIB_HEAP_FIND(min, vrijednost);

    // Čvor se ne nalazi u gomili.
    if (x == null) {
      return false;
    }

    x.vrijednost = k;
    Cvor<T>? y = x.roditelj;

    // Narušavanje min-heap svojstva.
    if (y != null && x.vrijednost.compareTo(y.vrijednost) < 0) {
      CUT(x, y);
      CASCADING_CUT(y);
    }

    // Ažuriranje novog minimalnog čvora.
    if (x.vrijednost.compareTo(min!.vrijednost) < 0) {
      min = x;
    }
    return true;
  }

  /// Metoda koja izbacuje čvor [x] i dodaje ga kao korijenski čvor.
  /// [y] je roditelj čvora [x].
  void CUT(Cvor<T> x, Cvor<T> y) {
    if (x == x.desno) {
      y.dijete = null;
    } else {
      _FIB_HEAP_REMOVE_LINK(x);
      y.dijete = x.desno;
      x.desno = x;
      x.lijevo = x;
    }
    y.stepen--;
    _FIB_HEAP_BETWEEN_LINK(min!, x);
    x.roditelj = null;
    x.mark = false;
  }

  /// Metoda koja rekurzivno izbacuje čvorove u slučaju da jedan čvor bude markiran.
  /// Čvor je markiran kada izgubi oba djeteta, onda se i sam taj čvor izbacuje u korjenski čvor.
  void CASCADING_CUT(Cvor<T> y) {
    Cvor<T>? z = y.roditelj;
    if (z != null) {
      if (!y.mark) {
        y.mark = true;
      } else {
        CUT(y, z);
        CASCADING_CUT(z);
      }
    }
  }

  /// Metoda koja briše čvor sa ključem [vrijednost] na način da smanji ključ tako da postane minimalan.
  /// Sa [FIB_HEAP_EXTRACT_MIN] se tako minimalan element dalje uklanja iz gomile.
  void FIB_HEAP_DELETE(T vrijednost) {
    final bool uspjeh = FIB_HEAP_DECREASE_KEY(vrijednost, ninf);
    if (uspjeh) {
      FIB_HEAP_EXTRACT_MIN();
    }
  }
}

void main(List<String> args) {
  final FibHeapTest fibHeapTest = FibHeapTest();
  fibHeapTest.runTests();
}
