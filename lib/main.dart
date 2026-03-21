import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ─────────────────────────────────────────────────────────────
// RESPONSIVE
// ─────────────────────────────────────────────────────────────
class R {
  static bool isMobile(BuildContext c) => MediaQuery.of(c).size.width < 600;
  static bool isDesktop(BuildContext c) => MediaQuery.of(c).size.width >= 1024;

  static EdgeInsets pad(BuildContext c) => EdgeInsets.symmetric(
        horizontal: isDesktop(c)
            ? 80
            : (MediaQuery.of(c).size.width >= 600 ? 40 : 20),
      );

  static Widget box(BuildContext c, Widget child) {
    if (!isDesktop(c)) return child;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: child,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// COLORS
// ─────────────────────────────────────────────────────────────
class C {
  static const cream        = Color(0xFFFDF6ED);
  static const terracotta   = Color(0xFFD4522A);
  static const terracottaDk = Color(0xFFB03A1A);
  static const amber        = Color(0xFFF59E0B);
  static const gold         = Color(0xFFD97706);
  static const darkBrown    = Color(0xFF3D1A0A);
  static const textSec      = Color(0xFF6B4423);
  static const greenWA      = Color(0xFF25D366);
  static const greenWADk    = Color(0xFF128C7E);
  static const certBlue     = Color(0xFF1B4F8A);
  static const certBlueMid  = Color(0xFF2E6DB4);
  static const certBlueLt   = Color(0xFFE8F0FB);
  static const shadow       = Color(0x20D4522A);
}

// ─────────────────────────────────────────────────────────────
// TEXT
// ─────────────────────────────────────────────────────────────
class Tx {
  static TextStyle d(double s, {Color? color, double h = 1.1}) =>
      GoogleFonts.dmSerifDisplay(
          fontSize: s, color: color ?? C.darkBrown, height: h);

  static TextStyle b(double s,
          {Color? color,
          FontWeight w = FontWeight.w400,
          double h = 1.5}) =>
      GoogleFonts.dmSans(
          fontSize: s, color: color ?? C.darkBrown, fontWeight: w, height: h);
}

// ─────────────────────────────────────────────────────────────
// DATA — OPCIÓN DE PLATO
// ─────────────────────────────────────────────────────────────
class DishOption {
  final String name, emoji;
  const DishOption({required this.name, required this.emoji});
}

// ─────────────────────────────────────────────────────────────
// DATA — PLATO DEL DÍA
// ─────────────────────────────────────────────────────────────
class DailyDish {
  final String name, description, price, img, emoji, tag;
  final String optionLabel;
  final List<DishOption> options;
  final bool available;
  const DailyDish({
    required this.name,
    required this.description,
    required this.price,
    required this.img,
    required this.emoji,
    required this.tag,
    this.optionLabel = '',
    this.options = const [],
    this.available = true,
  });
}

// ─────────────────────────────────────────────────────────────
// DATA — DOS PLATOS DEL DÍA
// Edita cada plato de forma completamente independiente.
// ─────────────────────────────────────────────────────────────
const dailyDishes = [
  DailyDish(
    available: true,
    name: 'Porción de Rellena con papa',
    emoji: '🍖',
    tag: 'Plato del día · Viernes',
    price: '7.000',
    description:
     'Una sola porción… pero cargada de recuerdos.'
        'Ese sabor inconfundible de la cocina de abuela, preparado a mano con ingredientes frescos y el toque especial que solo los años perfeccionan.',
    img: 'assets/porcion_rellena.jpg',
    optionLabel: '¿Con qué salsa la quieres? 🫙',
    options: [
      DishOption(name: 'Ajo',          emoji: '🧄'),
      DishOption(name: 'Miel Mostaza', emoji: '🍯'),
      DishOption(name: 'Picante',      emoji: '🌶️'),
    ],
  ),
  DailyDish(
    available: true,
    name: 'Caja de 6 porciones',
    emoji: '🍛',
    tag: 'Plato del día · Viernes',
    price: '40.000',
    description:
        'Ese sabor que te transporta directo a la cocina de abuela. '
        'Hecha a mano, con ingredientes frescos y el secreto que solo el tiempo enseña.',
    img: 'assets/rellena.jpg',
    optionLabel: '',
    options: [],
  ),
];

// ─────────────────────────────────────────────────────────────
// DATA — ESPECIALIDADES
// ─────────────────────────────────────────────────────────────
class Specialty {
  final String name, description, emoji, priceRange;
  const Specialty({
    required this.name,
    required this.description,
    required this.emoji,
    required this.priceRange,
  });
}

const specialties = [
  Specialty(
    name: 'Alitas BBQ',
    emoji: '🍗',
    priceRange: 'Desde \$16.000',
    description:
        'Crujientes por fuera, jugosas por dentro. Bañadas en nuestra salsa BBQ casera '
        'con toque ahumado y dulce. Disponibles en 6 o 12 unidades.',
  ),
  Specialty(
    name: 'Alitas Picantes',
    emoji: '🌶️',
    priceRange: 'Desde \$16.000',
    description:
        'Salsa de ají con limón que pica bonito. Dip de queso cremoso incluido. '
        '¡Advertencia: son adictivas!',
  ),
  Specialty(
    name: 'Bandeja Paisa',
    emoji: '🍛',
    priceRange: '\$35.000',
    description:
        'Frijoles, chicharrón, chorizo, huevo frito, arroz, aguacate y arepa. '
        'La tradición antioqueña completa en un solo plato.',
  ),
  Specialty(
    name: 'Almuerzo Casero',
    emoji: '🥘',
    priceRange: '\$18.000',
    description:
        'Sopa del día + seco con proteína a elección, arroz, ensalada fresca '
        'y jugo natural. Hecho con amor cada día.',
  ),
  Specialty(
    name: 'Sancocho de Gallina',
    emoji: '🍲',
    priceRange: '\$22.000',
    description:
        'Receta de abuela. Gallina criolla con papa, yuca, plátano y cilantro fresco. '
        'Un abrazo caliente en cada cucharada.',
  ),
  Specialty(
    name: 'Combo Familiar',
    emoji: '👨‍👩‍👧‍👦',
    priceRange: '\$95.000',
    description:
        '20 alitas BBQ + 2 bandejas paisas completas + 4 jugos naturales. '
        'El combo perfecto para reuniones y domingos en familia.',
  ),
];

// ─────────────────────────────────────────────────────────────
// WHATSAPP HELPERS
// ─────────────────────────────────────────────────────────────
const _waNumber = '573126127844';

Future<void> launchWA(BuildContext context, {String? message}) async {
  final msg = message ?? '¡Hola! Quiero hacer un pedido 😋';
  final uri =
      Uri.parse('https://wa.me/$_waNumber?text=${Uri.encodeComponent(msg)}');
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir WhatsApp')),
        );
      }
    }
  } catch (_) {}
}

String buildDailyOrderMsg(DailyDish dish, int qty,
    {List<DishOption> options = const [], String address = ''}) {
  final optLine = options.isNotEmpty
      ? '🫙 Salsas: ${options.map((o) => '${o.emoji} ${o.name}').join(', ')}\n'
      : '';
  final addrLine =
      address.trim().isNotEmpty ? '📍 Dirección: ${address.trim()}\n' : '';
  return '¡Hola! Quiero pedir el plato del día:\n\n'
      '${dish.emoji}  *${dish.name}*\n'
      '${optLine}'
      '📦 Cantidad: $qty\n'
      '💵 Total estimado: \$${_mulPrice(dish.price, qty)}\n'
      '${addrLine}\n'
      '¿Está disponible? 😊';
}

String _mulPrice(String price, int qty) {
  final raw = int.tryParse(price.replaceAll('.', '')) ?? 0;
  final total = raw * qty;
  final s = total.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return buf.toString();
}

// ─────────────────────────────────────────────────────────────
// MAIN
// ─────────────────────────────────────────────────────────────
void main() {
  if (!kIsWeb) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comidas Caseras Mamá',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: C.terracotta),
        scaffoldBackgroundColor: C.cream,
      ),
      home: const Shell(),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SHELL
// ─────────────────────────────────────────────────────────────
class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int _tab = 0;

  static const _pages  = [HomePage(), MenuPage(), CertPage()];
  static const _labels = ['Inicio', 'Especialidades', 'Certificado'];
  static const _icons  = [
    Icons.home_rounded,
    Icons.restaurant_menu_rounded,
    Icons.verified_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final desktop = R.isDesktop(context);

    if (desktop) {
      return Scaffold(
        backgroundColor: C.cream,
        body: Column(children: [
          _WebNav(current: _tab, onSelect: (i) => setState(() => _tab = i)),
          Expanded(child: _pages[_tab]),
        ]),
      );
    }

    return Scaffold(
      backgroundColor: C.cream,
      body: _pages[_tab],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Color(0x15000000), blurRadius: 16, offset: Offset(0, -2))],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (i) {
                final sel = _tab == i;
                return GestureDetector(
                  onTap: () => setState(() => _tab = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: sel ? C.terracotta.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(_icons[i], size: 22, color: sel ? C.terracotta : C.textSec),
                      const SizedBox(height: 3),
                      Text(_labels[i],
                          style: Tx.b(10,
                              color: sel ? C.terracotta : C.textSec,
                              w: sel ? FontWeight.w700 : FontWeight.w400)),
                    ]),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// WEB NAV BAR
// ─────────────────────────────────────────────────────────────
class _WebNav extends StatelessWidget {
  final int current;
  final ValueChanged<int> onSelect;
  const _WebNav({required this.current, required this.onSelect});

  static const _labels = ['Inicio', 'Especialidades', 'Certificado'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: C.darkBrown,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text('🍽️  Comidas Caseras Mamá',
                    style: Tx.d(18, color: Colors.white)),
              ),
              const Spacer(),
              ..._labels.asMap().entries.map((e) => GestureDetector(
                    onTap: () => onSelect(e.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      margin: const EdgeInsets.only(left: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                      decoration: BoxDecoration(
                        color: current == e.key
                            ? C.terracotta
                            : Colors.white.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(e.value,
                          style: Tx.b(14,
                              color: Colors.white,
                              w: current == e.key
                                  ? FontWeight.w700
                                  : FontWeight.w400)),
                    ),
                  )),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => launchWA(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                      color: C.greenWA, borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [
                    const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 15),
                    const SizedBox(width: 7),
                    Text('Pedir ahora',
                        style: Tx.b(13, color: Colors.white, w: FontWeight.w700)),
                  ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// HOME PAGE
// ─────────────────────────────────────────────────────────────
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900))
    ..forward();
  late final Animation<double> _fade =
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  late final Animation<Offset> _slide =
      Tween<Offset>(begin: const Offset(0, 0.07), end: Offset.zero)
          .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        _hero(context),
        _stats(context),
        _dailySection(context),
        _waBanner(context),
        _story(context),
        const SizedBox(height: 60),
      ]),
    );
  }

  // ── HERO ──────────────────────────────────────────────────
  Widget _hero(BuildContext context) {
  final desktop = R.isDesktop(context);
  return SizedBox(
    height: desktop ? 560 : 500,
    child: Stack(fit: StackFit.expand, children: [

      // ── Fondo base mientras carga ──────────────────────
      Container(color: C.terracottaDk),

//aImage.asset('assets/promo.jpg',
      // ── Imagen de red con manejo robusto ───────────────
      Image.asset('assets/banner.jpeg',
        fit: BoxFit.cover),

      // ── Gradiente oscuro encima de la imagen ───────────
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xF01A0A00), Color(0x601A0A00)],
          ),
        ),
      ),

      // ── Contenido del hero ─────────────────────────────
      SafeArea(
        child: Center(
          child: R.box(
            context,
            Padding(
              padding: R.pad(context),
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: desktop
                      ? Row(children: [
                          Expanded(child: _heroText(context)),
                          const SizedBox(width: 48),
                          _heroCard(),
                        ])
                      : _heroText(context),
                ),
              ),
            ),
          ),
        ),
      ),
    ]),
  );
}

  Widget _heroText(BuildContext context) {
    final desktop = R.isDesktop(context);
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
                color: C.amber, borderRadius: BorderRadius.circular(20)),
            child: Text('🍳  Popayán, Cauca',
                style: Tx.b(12, color: C.darkBrown, w: FontWeight.w700)),
          ),
          const SizedBox(height: 18),
          Text('El sabor\nque abraza.',
              style: Tx.d(desktop ? 62 : 50, color: Colors.white)),
          const SizedBox(height: 14),
          Text(
              'Alitas · Bandejas Paisas · Almuerzos caseros\nHecho con amor en casa.',
              style: Tx.b(15, color: Colors.white70, h: 1.65)),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: () => launchWA(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                color: C.greenWA,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: C.greenWA.withOpacity(0.5),
                      blurRadius: 16,
                      offset: const Offset(0, 6))
                ],
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 18),
                const SizedBox(width: 10),
                Text('Pedir por WhatsApp',
                    style: Tx.b(15, color: Colors.white, w: FontWeight.w700)),
              ]),
            ),
          ),
        ]);
  }

  // Hero card — primer plato disponible
  Widget _heroCard() {
    final d = dailyDishes.firstWhere((d) => d.available,
        orElse: () => dailyDishes.first);
    return Container(
      width: 270,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x30000000), blurRadius: 32, offset: Offset(0, 12))
        ],
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.asset(d.img,
                  height: 170,
                  width: 270,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                      height: 170,
                      color: C.terracottaDk,
                      child: const Center(
                          child: Text('🍗', style: TextStyle(fontSize: 48))))),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: C.amber.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text('🍽️  Plato del día',
                      style: Tx.b(11, color: C.gold, w: FontWeight.w700)),
                ),
                const SizedBox(height: 8),
                Text(d.name, style: Tx.d(17)),
                const SizedBox(height: 4),
                d.available
                    ? Text('\$${d.price}',
                        style: Tx.b(18, color: C.terracotta, w: FontWeight.w700))
                    : Text('Próximamente 🕐',
                        style: Tx.b(13, color: C.textSec, w: FontWeight.w600)),
              ]),
            ),
          ]),
    );
  }

  // ── STATS ─────────────────────────────────────────────────
  Widget _stats(BuildContext context) {
    return Container(
      color: C.darkBrown,
      padding: EdgeInsets.symmetric(
          vertical: 28, horizontal: R.isDesktop(context) ? 0 : 20),
      child: R.box(
          context,
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _St(emoji: '⭐', value: '4.9', label: 'Calificación'),
            _vDiv(),
            _St(emoji: '🚀', value: '45 min', label: 'Entrega'),
            _vDiv(),
            _St(emoji: '❤️', value: '500+', label: 'Pedidos'),
            _vDiv(),
            _St(emoji: '🛡️', value: 'Cert.', label: 'Higiene INVIMA'),
          ])),
    );
  }

  Widget _vDiv() =>
      Container(width: 1, height: 36, color: Colors.white.withOpacity(0.12));

  // ── SECCIÓN PLATOS DEL DÍA — siempre apilados ─────────────
  //
  // En desktop: card horizontal (imagen izq | info der), ancho completo.
  // En móvil:   card vertical (imagen arriba | info abajo).
  // Los dos platos van uno debajo del otro en AMBOS breakpoints.
  // ──────────────────────────────────────────────────────────
  Widget _dailySection(BuildContext context) {
    final desktop = R.isDesktop(context);
    return Padding(
      padding: R.pad(context).copyWith(top: 56, bottom: 8),
      child: R.box(
        context,
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Etiqueta superior
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
                color: C.terracotta.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: Text('🍽️  Hoy preparamos',
                style: Tx.b(12, color: C.terracotta, w: FontWeight.w700)),
          ),
          const SizedBox(height: 10),
          Text('Platos del día', style: Tx.d(32)),
          const SizedBox(height: 4),
          Text('Dos opciones preparadas con todo el amor del día.',
              style: Tx.b(14, color: C.textSec)),
          const SizedBox(height: 28),

          // ── Plato 1 ────────────────────────────────────
          _dishSlot(context, dailyDishes[0], desktop: desktop),

          // ── Separador decorativo ────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: Row(children: [
              Expanded(
                  child: Container(
                      height: 1, color: C.terracotta.withOpacity(0.12))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: C.cream,
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: C.terracotta.withOpacity(0.2)),
                  ),
                  child: Text('y también…',
                      style:
                          Tx.b(12, color: C.textSec, w: FontWeight.w600)),
                ),
              ),
              Expanded(
                  child: Container(
                      height: 1, color: C.terracotta.withOpacity(0.12))),
            ]),
          ),

          // ── Plato 2 ────────────────────────────────────
          _dishSlot(context, dailyDishes[1], desktop: desktop),
        ]),
      ),
    );
  }

  /// Devuelve la card correcta según disponibilidad y breakpoint.
  Widget _dishSlot(BuildContext context, DailyDish dish,
      {required bool desktop}) {
    if (!dish.available) return _DailyUnavailableCard(context: context);
    return desktop
        ? _DailyCardDesktop(dish: dish)
        : _DailyCardMobile(dish: dish);
  }

  // ── BANNER WHATSAPP ────────────────────────────────────────
  Widget _waBanner(BuildContext context) {
    return Padding(
      padding: R.pad(context).copyWith(top: 48),
      child: R.box(
          context,
          GestureDetector(
            onTap: () => launchWA(context),
            child: Container(
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [C.greenWA, C.greenWADk],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: C.greenWA.withOpacity(0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 8))
                ],
              ),
              child: Row(children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: const Center(
                      child: FaIcon(FontAwesomeIcons.whatsapp,
                          color: Colors.white, size: 28)),
                ),
                const SizedBox(width: 18),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text('¡Pide ahora mismo!',
                          style: Tx.d(20, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(
                          'Entregas en Popayán, Cauca · Lun–Dom 11am–8pm',
                          style: Tx.b(13, color: Colors.white70)),
                    ])),
                const Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.white, size: 16),
              ]),
            ),
          )),
    );
  }

  // ── HISTORIA ───────────────────────────────────────────────
  Widget _story(BuildContext context) {
    final desktop = R.isDesktop(context);
    return Padding(
      padding: R.pad(context).copyWith(top: 56),
      child: R.box(
          context,
          desktop
              ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset('assets/promo.jpg',
                              height: 360, fit: BoxFit.cover))),
                  const SizedBox(width: 56),
                  Expanded(child: _storyText()),
                ])
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/promo.jpg',
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover)),
                  const SizedBox(height: 24),
                  _storyText(),
                ])),
    );
  }

  Widget _storyText() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Nuestra historia', style: Tx.d(30)),
        const SizedBox(height: 16),
        Text(
            '"Empecé cocinando para mis hijos.\nHoy cocino para toda Popayán, Cauca."',
            style: Tx.d(20, color: C.terracottaDk, h: 1.5)),
        const SizedBox(height: 14),
        Text(
            'Más de 10 años de tradición culinaria. Cada receta tiene historia, cada plato tiene alma.',
            style: Tx.b(15, color: C.textSec, h: 1.7)),
        const SizedBox(height: 10),
        Text('— Mamá Rosa, fundadora',
            style: Tx.b(14, color: C.textSec, w: FontWeight.w700)),
      ]);
}

// ─────────────────────────────────────────────────────────────
// SAUCE SELECTOR
// ─────────────────────────────────────────────────────────────
class _SauceSelector extends StatelessWidget {
  final DailyDish dish;
  final Set<int> selectedIndices;
  final ValueChanged<int> onToggle;

  const _SauceSelector({
    required this.dish,
    required this.selectedIndices,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (dish.options.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(dish.optionLabel,
          style: Tx.b(14, color: C.darkBrown, w: FontWeight.w700)),
      const SizedBox(height: 12),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(dish.options.length, (i) {
          final opt = dish.options[i];
          final sel = selectedIndices.contains(i);
          return GestureDetector(
            onTap: () => onToggle(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              decoration: BoxDecoration(
                color: sel ? C.terracotta : Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: sel ? C.terracotta : C.terracotta.withOpacity(0.3),
                  width: sel ? 2 : 1.5,
                ),
                boxShadow: sel
                    ? [
                        BoxShadow(
                            color: C.terracotta.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 3))
                      ]
                    : [
                        const BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 4,
                            offset: Offset(0, 2))
                      ],
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(opt.emoji, style: const TextStyle(fontSize: 17)),
                const SizedBox(width: 7),
                Text(opt.name,
                    style: Tx.b(13,
                        color: sel ? Colors.white : C.darkBrown,
                        w: sel ? FontWeight.w700 : FontWeight.w500)),
                if (sel) ...[
                  const SizedBox(width: 6),
                  const Icon(Icons.check_rounded, color: Colors.white, size: 15),
                ],
              ]),
            ),
          );
        }),
      ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────
// DAILY UNAVAILABLE CARD
// ─────────────────────────────────────────────────────────────
Widget _DailyUnavailableCard({required BuildContext context}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 52, horizontal: 32),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: const [
        BoxShadow(color: C.shadow, blurRadius: 20, offset: Offset(0, 6))
      ],
      border: Border.all(color: C.terracotta.withOpacity(0.12), width: 1.5),
    ),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          color: C.terracotta.withOpacity(0.08),
          shape: BoxShape.circle,
        ),
        child: const Center(child: Text('🍳', style: TextStyle(fontSize: 42))),
      ),
      const SizedBox(height: 24),
      Text('Hoy no hay plato del día', style: Tx.d(26)),
      const SizedBox(height: 10),
      Text(
        'Estamos preparando algo delicioso para ti.\nVuelve pronto — actualizamos esta página\ncada vez que el plato del día esté listo. 🕐',
        style: Tx.b(15, color: C.textSec, h: 1.65),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 28),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 32, height: 1.5, color: C.terracotta.withOpacity(0.2)),
        const SizedBox(width: 10),
        Text('¿Quieres saber cuándo hay?', style: Tx.b(12, color: C.textSec)),
        const SizedBox(width: 10),
        Container(width: 32, height: 1.5, color: C.terracotta.withOpacity(0.2)),
      ]),
      const SizedBox(height: 20),
      GestureDetector(
        onTap: () => launchWA(context,
            message:
                '¡Hola! ¿Cuándo van a tener plato del día disponible? 😊'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [C.greenWA, C.greenWADk]),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: C.greenWA.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 17),
            const SizedBox(width: 8),
            Text('Pregúntanos por WhatsApp',
                style: Tx.b(14, color: Colors.white, w: FontWeight.w700)),
          ]),
        ),
      ),
    ]),
  );
}

// ─────────────────────────────────────────────────────────────
// DAILY CARD — MOBILE  (imagen arriba, info abajo)
// ─────────────────────────────────────────────────────────────
class _DailyCardMobile extends StatefulWidget {
  final DailyDish dish;
  const _DailyCardMobile({required this.dish});
  @override
  State<_DailyCardMobile> createState() => _DailyCardMobileState();
}

class _DailyCardMobileState extends State<_DailyCardMobile> {
  int _qty = 1;
  final Set<int> _selected = {};
  final _addrCtrl = TextEditingController();

  @override
  void dispose() {
    _addrCtrl.dispose();
    super.dispose();
  }

  void _dec() { if (_qty > 1) setState(() => _qty--); }
  void _inc() { if (_qty < 20) setState(() => _qty++); }
  void _toggle(int i) => setState(() =>
      _selected.contains(i) ? _selected.remove(i) : _selected.add(i));

  void _order(BuildContext context) {
    final opts = _selected.toList()..sort();
    launchWA(context,
        message: buildDailyOrderMsg(widget.dish, _qty,
            options: opts.map((i) => widget.dish.options[i]).toList(),
            address: _addrCtrl.text));
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.dish;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: C.shadow, blurRadius: 20, offset: Offset(0, 6))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.asset(d.img,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                    height: 220,
                    color: C.terracottaDk,
                    child: const Center(
                        child: Text('🍗', style: TextStyle(fontSize: 64))))),
          ),
          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  color: C.darkBrown.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(d.tag,
                  style: Tx.b(11, color: Colors.white, w: FontWeight.w600)),
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(d.emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 10),
              Expanded(child: Text(d.name, style: Tx.d(26))),
            ]),
            const SizedBox(height: 10),
            Text(d.description, style: Tx.b(14, color: C.textSec, h: 1.6)),
            const SizedBox(height: 18),
            Text('\$${d.price}', style: Tx.d(32, color: C.terracotta)),
            if (d.options.isNotEmpty) ...[
              const SizedBox(height: 22),
              Container(height: 1, color: C.shadow),
              const SizedBox(height: 20),
              _SauceSelector(
                  dish: d, selectedIndices: _selected, onToggle: _toggle),
            ],
            const SizedBox(height: 18),
            TextField(
              controller: _addrCtrl,
              textInputAction: TextInputAction.done,
              style: Tx.b(14, color: C.darkBrown),
              decoration: InputDecoration(
                hintText: 'Dirección de entrega (opcional)',
                hintStyle: Tx.b(14, color: C.textSec.withOpacity(0.6)),
                prefixIcon: const Icon(Icons.location_on_outlined,
                    color: C.terracotta, size: 20),
                filled: true,
                fillColor: C.cream,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        BorderSide(color: C.terracotta.withOpacity(0.25))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        BorderSide(color: C.terracotta.withOpacity(0.25))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: C.terracotta, width: 1.5)),
              ),
            ),
            const SizedBox(height: 14),
            Row(children: [
              Container(
                decoration: BoxDecoration(
                  color: C.cream,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: C.terracotta.withOpacity(0.25)),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  _QBtn(icon: Icons.remove, onTap: _dec, enabled: _qty > 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('$_qty', style: Tx.d(20, color: C.darkBrown)),
                  ),
                  _QBtn(icon: Icons.add, onTap: _inc, enabled: _qty < 20),
                ]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => _order(context),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [C.greenWA, C.greenWADk]),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                            color: C.greenWA.withOpacity(0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.whatsapp,
                              color: Colors.white, size: 17),
                          const SizedBox(width: 8),
                          Text('Pedir ahora',
                              style: Tx.b(15,
                                  color: Colors.white, w: FontWeight.w700)),
                        ]),
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DAILY CARD — DESKTOP
// Imagen izquierda (40%) | Info derecha (60%)
// Se muestra apilada (una debajo de la otra), ocupa el ancho
// completo del contenedor. Flexible en el botón = sin overflow.
// ─────────────────────────────────────────────────────────────
class _DailyCardDesktop extends StatefulWidget {
  final DailyDish dish;
  const _DailyCardDesktop({required this.dish});
  @override
  State<_DailyCardDesktop> createState() => _DailyCardDesktopState();
}

class _DailyCardDesktopState extends State<_DailyCardDesktop> {
  int _qty = 1;
  final Set<int> _selected = {};
  final _addrCtrl = TextEditingController();

  @override
  void dispose() {
    _addrCtrl.dispose();
    super.dispose();
  }

  void _dec() { if (_qty > 1) setState(() => _qty--); }
  void _inc() { if (_qty < 20) setState(() => _qty++); }
  void _toggle(int i) => setState(() =>
      _selected.contains(i) ? _selected.remove(i) : _selected.add(i));

  void _order(BuildContext context) {
    final opts = _selected.toList()..sort();
    launchWA(context,
        message: buildDailyOrderMsg(widget.dish, _qty,
            options: opts.map((i) => widget.dish.options[i]).toList(),
            address: _addrCtrl.text));
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.dish;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(color: C.shadow, blurRadius: 28, offset: Offset(0, 8))
        ],
      ),
      child: IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // ── Imagen izquierda ────────────────────────────
          Expanded(
            flex: 4,
            child: Stack(fit: StackFit.expand, children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(28)),
                child: Image.asset(d.img,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                        color: C.terracottaDk,
                        child: const Center(
                            child: Text('🍗',
                                style: TextStyle(fontSize: 80))))),
              ),
              Positioned(
                top: 18,
                left: 18,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                      color: C.darkBrown.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(d.tag,
                      style: Tx.b(12,
                          color: Colors.white, w: FontWeight.w600)),
                ),
              ),
            ]),
          ),

          // ── Info derecha ────────────────────────────────
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(children: [
                    Text(d.emoji, style: const TextStyle(fontSize: 36)),
                    const SizedBox(width: 12),
                    Expanded(child: Text(d.name, style: Tx.d(32))),
                  ]),
                  const SizedBox(height: 12),
                  Text(d.description,
                      style: Tx.b(15, color: C.textSec, h: 1.65)),
                  const SizedBox(height: 20),
                  Text('\$${d.price}',
                      style: Tx.d(38, color: C.terracotta)),

                  // Salsas
                  if (d.options.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Container(height: 1, color: C.shadow),
                    const SizedBox(height: 16),
                    _SauceSelector(
                        dish: d,
                        selectedIndices: _selected,
                        onToggle: _toggle),
                  ],

                  const SizedBox(height: 18),
                  // Dirección
                  TextField(
                    controller: _addrCtrl,
                    textInputAction: TextInputAction.done,
                    style: Tx.b(14, color: C.darkBrown),
                    decoration: InputDecoration(
                      hintText: 'Dirección de entrega (opcional)',
                      hintStyle:
                          Tx.b(14, color: C.textSec.withOpacity(0.6)),
                      prefixIcon: const Icon(Icons.location_on_outlined,
                          color: C.terracotta, size: 20),
                      filled: true,
                      fillColor: C.cream,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                              color: C.terracotta.withOpacity(0.25))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                              color: C.terracotta.withOpacity(0.25))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                              color: C.terracotta, width: 1.5)),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Cantidad + botón
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: C.cream,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: C.terracotta.withOpacity(0.25)),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        _QBtn(
                            icon: Icons.remove,
                            onTap: _dec,
                            enabled: _qty > 1),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 18),
                          child: Text('$_qty',
                              style: Tx.d(22, color: C.darkBrown)),
                        ),
                        _QBtn(
                            icon: Icons.add,
                            onTap: _inc,
                            enabled: _qty < 20),
                      ]),
                    ),
                    const SizedBox(width: 14),
                    // Flexible evita el overflow cuando la card
                    // tiene menos ancho del esperado
                    Flexible(
                      child: GestureDetector(
                        onTap: () => _order(context),
                        child: Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.symmetric(vertical: 17),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [C.greenWA, C.greenWADk]),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                  color: C.greenWA.withOpacity(0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5))
                            ],
                          ),
                          child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                const FaIcon(FontAwesomeIcons.whatsapp,
                                    color: Colors.white, size: 18),
                                const SizedBox(width: 10),
                                Text('Pedir ahora',
                                    style: Tx.b(16,
                                        color: Colors.white,
                                        w: FontWeight.w700)),
                              ]),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 12),
                  Row(children: [
                    const Icon(Icons.info_outline_rounded,
                        size: 14, color: C.textSec),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Text(
                            'El plato del día puede variar. Escríbenos si tienes dudas.',
                            style: Tx.b(12, color: C.textSec))),
                  ]),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// MENU PAGE — Especialidades
// ─────────────────────────────────────────────────────────────
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final desktop = R.isDesktop(context);
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          padding: R.pad(context)
              .copyWith(top: desktop ? 48 : 36, bottom: desktop ? 40 : 28),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [C.terracottaDk, C.terracotta],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: R.box(
              context,
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text('Nuestras Especialidades',
                          style: Tx.d(desktop ? 48 : 34, color: Colors.white)),
                      const SizedBox(height: 8),
                      Text(
                          'Estas son las preparaciones que más amamos hacer. '
                          'Pregúntanos cuál está disponible hoy 🟢',
                          style: Tx.b(15, color: Colors.white70)),
                    ])),
                if (desktop)
                  const Text('👩‍🍳', style: TextStyle(fontSize: 72)),
              ])),
        ),
        Padding(
          padding: R.pad(context).copyWith(top: 28),
          child: R.box(
              context,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: C.amber.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: C.amber.withOpacity(0.4)),
                ),
                child: Row(children: [
                  const Text('💡', style: TextStyle(fontSize: 22)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(
                          'Cada día preparamos un plato especial. '
                          'Consulta en Inicio cuál es el plato de hoy, '
                          'o escríbenos por WhatsApp para confirmarlo.',
                          style: Tx.b(13, color: C.darkBrown, h: 1.5))),
                ]),
              )),
        ),
        Padding(
          padding: R.pad(context).copyWith(top: 28, bottom: 56),
          child:
              R.box(context, desktop ? _desktopGrid() : _mobileList()),
        ),
        Padding(
          padding: R.pad(context).copyWith(bottom: 56),
          child: R.box(
              context,
              GestureDetector(
                onTap: () => launchWA(context,
                    message:
                        '¡Hola! Quiero saber qué preparaciones tienen disponibles hoy 😊'),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [C.greenWA, C.greenWADk],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                          color: C.greenWA.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 6))
                    ],
                  ),
                  child: Row(children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle),
                      child: const Center(
                          child: FaIcon(FontAwesomeIcons.whatsapp,
                              color: Colors.white, size: 26)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('¿Cuál hay hoy?',
                              style: Tx.d(18, color: Colors.white)),
                          const SizedBox(height: 3),
                          Text(
                              'Escríbenos y te confirmamos qué preparaciones hay disponibles.',
                              style: Tx.b(13, color: Colors.white70)),
                        ])),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.white, size: 15),
                  ]),
                ),
              )),
        ),
      ]),
    );
  }

  Widget _desktopGrid() => Wrap(
        spacing: 20,
        runSpacing: 20,
        children: specialties
            .map((s) => SizedBox(width: 340, child: _SpecialtyCard(s: s)))
            .toList(),
      );

  Widget _mobileList() => Column(
        children: specialties
            .map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _SpecialtyCard(s: s)))
            .toList(),
      );
}

class _SpecialtyCard extends StatelessWidget {
  final Specialty s;
  const _SpecialtyCard({required this.s});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: C.shadow, blurRadius: 12, offset: Offset(0, 4))
        ],
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
              color: C.amber.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16)),
          child:
              Center(child: Text(s.emoji, style: const TextStyle(fontSize: 26))),
        ),
        const SizedBox(width: 16),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Text(s.name, style: Tx.d(18)),
          const SizedBox(height: 5),
          Text(s.description,
              style: Tx.b(12, color: C.textSec, h: 1.5),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: C.terracotta.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8)),
            child: Text(s.priceRange,
                style:
                    Tx.b(12, color: C.terracotta, w: FontWeight.w700)),
          ),
        ])),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// QUANTITY BUTTON
// ─────────────────────────────────────────────────────────────
class _QBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;
  const _QBtn(
      {required this.icon, required this.onTap, this.enabled = true});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon,
              size: 17,
              color: enabled
                  ? C.terracotta
                  : C.terracotta.withOpacity(0.3))),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CERTIFICATE PAGE
// ─────────────────────────────────────────────────────────────
class CertPage extends StatelessWidget {
  const CertPage({super.key});

  @override
  Widget build(BuildContext context) {
    final desktop = R.isDesktop(context);
    return SingleChildScrollView(
      child: Column(children: [
        _header(context, desktop),
        Padding(
          padding: R.pad(context).copyWith(top: 48, bottom: 64),
          child: R.box(
              context,
              desktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Expanded(
                              flex: 5, child: _certVisual(context)),
                          const SizedBox(width: 36),
                          Expanded(
                              flex: 4, child: _rightColumn(context)),
                        ])
                  : Column(children: [
                      _certVisual(context),
                      const SizedBox(height: 36),
                      _rightColumn(context),
                    ])),
        ),
      ]),
    );
  }

  Widget _header(BuildContext context, bool desktop) {
    return Container(
      width: double.infinity,
      padding: R.pad(context)
          .copyWith(top: desktop ? 48 : 36, bottom: desktop ? 40 : 28),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [C.certBlue, C.certBlueMid],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: R.box(
          context,
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20)),
                child: Text('✅  Higiene & Seguridad Alimentaria',
                    style: Tx.b(12,
                        color: Colors.white, w: FontWeight.w600)),
              ),
              const SizedBox(height: 16),
              Text('Certificado de\nManipulación\nde Alimentos',
                  style:
                      Tx.d(desktop ? 48 : 36, color: Colors.white)),
              const SizedBox(height: 12),
              Text(
                  'Tu seguridad alimentaria es nuestra máxima prioridad. '
                  'Conoce quiénes somos y cómo preparamos tus alimentos.',
                  style: Tx.b(15, color: Colors.white70, h: 1.6)),
            ])),
            if (desktop)
              const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('🛡️', style: TextStyle(fontSize: 88))),
          ])),
    );
  }

  Widget _certVisual(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: C.certBlue.withOpacity(0.1),
              blurRadius: 24,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [C.certBlue, C.certBlueMid]),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Row(children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle),
              child: const Icon(Icons.verified_rounded,
                  color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Text('Documento oficial verificado',
                  style: Tx.b(13,
                      color: Colors.white, w: FontWeight.w700)),
              Text('SENA · Firmado digitalmente · Oct 28, 2025',
                  style: Tx.b(11, color: Colors.white70)),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: Colors.white.withOpacity(0.4)),
              ),
              child: Text('✅ Vigente',
                  style: Tx.b(11,
                      color: Colors.white, w: FontWeight.w700)),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: C.certBlueMid.withOpacity(0.2), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset('assets/cert.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (_, __, ___) => Container(
                      padding: const EdgeInsets.all(32),
                      color: C.certBlueLt,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.picture_as_pdf_rounded,
                                size: 48, color: C.certBlueMid),
                            const SizedBox(height: 12),
                            Text(
                                'cert.png no encontrado\nAgrega assets/cert.png al proyecto',
                                style: Tx.b(13, color: C.certBlue),
                                textAlign: TextAlign.center),
                          ]))),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: C.certBlueLt,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: C.certBlueMid.withOpacity(0.2)),
            ),
            child: Row(children: [
              const Icon(Icons.qr_code_rounded,
                  color: C.certBlueMid, size: 28),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                Text('Código de verificación',
                    style: Tx.b(11, color: C.textSec)),
                Text('9406003347210CC34568670C',
                    style: Tx.b(13,
                        color: C.certBlue, w: FontWeight.w700)),
                const SizedBox(height: 2),
                Text('Verificable en certificados.sena.edu.co',
                    style: Tx.b(10, color: C.textSec)),
              ])),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text('Información oficial', style: Tx.d(20)),
            const SizedBox(height: 16),
            const _InfoRow(
                icon: Icons.person_rounded,
                label: 'Titular',
                value: 'María Areli Toro'),
            const _InfoRow(
                icon: Icons.badge_rounded,
                label: 'Cédula de ciudadanía',
                value: '34.568.670'),
            const _InfoRow(
                icon: Icons.school_rounded,
                label: 'Formación aprobada',
                value: 'Higiene y Manipulación de Alimentos'),
            const _InfoRow(
                icon: Icons.schedule_rounded,
                label: 'Duración',
                value: '40 horas'),
            const _InfoRow(
                icon: Icons.business_rounded,
                label: 'Entidad certificadora',
                value:
                    'SENA – Centro Nac. de Hotelería, Turismo y Alimentos'),
            const _InfoRow(
                icon: Icons.calendar_today_rounded,
                label: 'Fecha de expedición',
                value: '28 de octubre de 2025'),
            const _InfoRow(
                icon: Icons.tag_rounded,
                label: 'No. de registro',
                value: '108623930'),
            const _InfoRow(
                icon: Icons.store_rounded,
                label: 'Establecimiento',
                value: 'Comidas Caseras Mamá · Popayán, Cauca'),
          ]),
        ),
      ]),
    );
  }

  Widget _rightColumn(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: C.certBlue.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: C.certBlueLt,
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.menu_book_rounded,
                  color: C.certBlue, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Text('¿Qué significa\neste certificado?',
                    style: Tx.d(18))),
          ]),
          const SizedBox(height: 16),
          Text(
            'El SENA certifica que María Areli Toro completó 40 horas de '
            'formación oficial en Higiene y Manipulación de Alimentos, '
            'expedido el 28 de octubre de 2025 y verificable en certificados.sena.edu.co.\n\n'
            'La formación cubre:\n',
            style: Tx.b(13, color: C.textSec, h: 1.65),
          ),
          ...[
            'Microbiología básica e inocuidad alimentaria',
            'Control de temperaturas y cadena de frío',
            'Limpieza y desinfección de superficies y utensilios',
            'Higiene personal, indumentaria y BPM',
            'Manipulación correcta de carnes y proteínas',
            'Almacenamiento seguro y control de vencimientos',
          ].map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Icon(Icons.check_circle_rounded,
                      color: C.certBlueMid, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(item,
                          style: Tx.b(13, color: C.textSec, h: 1.4))),
                ]),
              )),
        ]),
      ),
      const SizedBox(height: 24),
      Text('Nuestros compromisos diarios', style: Tx.d(22)),
      const SizedBox(height: 6),
      Text('Aplicamos estas prácticas cada día, sin excepción.',
          style: Tx.b(13, color: C.textSec)),
      const SizedBox(height: 16),
      ..._commits.map((c) => _CommitCard(data: c)),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [C.certBlue.withOpacity(0.08), C.certBlueLt],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: C.certBlueMid.withOpacity(0.2)),
        ),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Text('💬', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Text('Transparencia total',
                style: Tx.d(18, color: C.certBlue)),
          ]),
          const SizedBox(height: 10),
          Text(
              '¿Quieres ver el certificado original? Con gusto te lo compartimos. '
              'Escríbenos por WhatsApp y te enviamos una foto del documento físico.',
              style: Tx.b(13, color: C.textSec, h: 1.6)),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => launchWA(context,
                message:
                    '¡Hola! Me gustaría ver el certificado de manipulación de alimentos. ¿Me lo pueden compartir? 😊'),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [C.greenWA, C.greenWADk]),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: C.greenWA.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3))
                ],
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const FaIcon(FontAwesomeIcons.whatsapp,
                    color: Colors.white, size: 15),
                const SizedBox(width: 8),
                Text('Solicitar certificado',
                    style: Tx.b(13,
                        color: Colors.white, w: FontWeight.w700)),
              ]),
            ),
          ),
        ]),
      ),
    ]);
  }

  static const _commits = [
    _CD(
        icon: Icons.sanitizer_rounded,
        color: C.certBlue,
        title: 'Lavado de manos constante',
        desc:
            'Antes, durante y después de cada preparación. Jabón antibacterial obligatorio.'),
    _CD(
        icon: Icons.thermostat_rounded,
        color: C.terracotta,
        title: 'Control de temperatura',
        desc:
            'Carnes refrigeradas bajo 4°C. Cocción siempre por encima de 70°C.'),
    _CD(
        icon: Icons.cleaning_services_rounded,
        color: Color(0xFF2D6A4F),
        title: 'Desinfección de superficies',
        desc:
            'Mesones, tablas y utensilios desinfectados antes de cada uso.'),
    _CD(
        icon: Icons.local_florist_rounded,
        color: C.gold,
        title: 'Ingredientes frescos del día',
        desc:
            'Compras diarias. Sin conservantes artificiales. Sin productos vencidos.'),
    _CD(
        icon: Icons.health_and_safety_rounded,
        color: Color(0xFF7B2D8B),
        title: 'Indumentaria limpia',
        desc:
            'Delantal, gorro y tapabocas en toda la preparación de alimentos.'),
  ];
}

// ─────────────────────────────────────────────────────────────
// SHARED SMALL WIDGETS
// ─────────────────────────────────────────────────────────────
class _St extends StatelessWidget {
  final String emoji, value, label;
  const _St(
      {required this.emoji, required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(emoji, style: const TextStyle(fontSize: 22)),
      const SizedBox(height: 4),
      Text(value, style: Tx.d(16, color: Colors.white)),
      Text(label, style: Tx.b(10, color: Colors.white54)),
    ]);
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _InfoRow(
      {required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        Icon(icon, size: 17, color: C.certBlueMid),
        const SizedBox(width: 10),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Text(label, style: Tx.b(10, color: C.textSec)),
          Text(value, style: Tx.b(14, w: FontWeight.w600)),
        ])),
      ]),
    );
  }
}

class _CD {
  final IconData icon;
  final Color color;
  final String title, desc;
  const _CD(
      {required this.icon,
      required this.color,
      required this.title,
      required this.desc});
}

class _CommitCard extends StatelessWidget {
  final _CD data;
  const _CommitCard({required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 8,
              offset: Offset(0, 2))
        ],
      ),
      child: Row(children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
              color: data.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)),
          child: Icon(data.icon, color: data.color, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Text(data.title, style: Tx.b(14, w: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(data.desc, style: Tx.b(12, color: C.textSec, h: 1.4)),
        ])),
        Icon(Icons.check_circle_rounded, color: data.color, size: 18),
      ]),
    );
  }
}