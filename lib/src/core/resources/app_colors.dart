part of 'resources.dart';

mixin AppColors {
  static const Color kPrimary = Color(0xffF1C332);
  static const Color kRed = Color(0xffF8474C);
  static const Color kGreen = Color(0xff63BE37);
  static const Color kNeutralGrey = Color(0xffD8DBDE);
  static const Color kNeutralGrey2 = Color(0xffF0F0F0);
  static const Color kPrimary2 = Color(0xffF8E198);

  static const Color kWhite = Colors.white;
  static const Color kBlack = Color(0xFF000000);
  static const Color kGrey = Color(0xFFE8EAF6);
}

final Map<int, Color> primaryColorMap = {
  50: const Color.fromRGBO(177, 249, 163, .1),
  200: const Color.fromRGBO(177, 249, 163, .3),
  300: const Color.fromRGBO(177, 249, 163, .4),
  400: const Color.fromRGBO(177, 249, 163, .5),
  100: const Color.fromRGBO(177, 249, 163, .2),
  500: const Color.fromRGBO(177, 249, 163, .6),
  600: const Color.fromRGBO(177, 249, 163, .7),
  700: const Color.fromRGBO(177, 249, 163, .8),
  800: const Color.fromRGBO(177, 249, 163, .9),
  900: const Color.fromRGBO(177, 249, 163, 1),
};


/*
В конструкторе Color первые два символа означают opacity, ниже приведены hex для всех возможных значений.

100% — FF
99% — FC
98% — FA
97% — F7
96% — F5
95% — F2
94% — F0
93% — ED
92% — EB
91% — E8
90% — E6
89% — E3
88% — E0
87% — DE
86% — DB
85% — D9
84% — D6
83% — D4
82% — D1
81% — CF
80% — CC
79% — C9
78% — C7
77% — C4
76% — C2
75% — BF
74% — BD
73% — BA
72% — B8
71% — B5
70% — B3
69% — B0
68% — AD
67% — AB
66% — A8
65% — A6
64% — A3
63% — A1
62% — 9E
61% — 9C
60% — 99
59% — 96
58% — 94
57% — 91
56% — 8F
55% — 8C
54% — 8A
53% — 87
52% — 85
51% — 82
50% — 80
49% — 7D
48% — 7A
47% — 78
46% — 75
45% — 73
44% — 70
43% — 6E
42% — 6B
41% — 69
40% — 66
39% — 63
38% — 61
37% — 5E
36% — 5C
35% — 59
34% — 57
33% — 54
32% — 52
31% — 4F
30% — 4D
29% — 4A
28% — 47
27% — 45
26% — 42
25% — 40
24% — 3D
23% — 3B
22% — 38
21% — 36
20% — 33
19% — 30
18% — 2E
17% — 2B
16% — 29
15% — 26
14% — 24
13% — 21
12% — 1F
11% — 1C
10% — 1A
9% — 17
8% — 14
7% — 12
6% — 0F
5% — 0D
4% — 0A
3% — 08
2% — 05
1% — 03
0% — 00
*/
