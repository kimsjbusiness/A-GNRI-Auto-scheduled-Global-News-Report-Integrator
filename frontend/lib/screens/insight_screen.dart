// 2면

import 'package:flutter/material.dart';
import '../core/utils.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/page_tab_bar.dart';
import 'home_screen.dart';

class InsightScreen extends StatelessWidget {
  final Map<String, dynamic>? reportData;

  const InsightScreen({
    super.key,
    this.reportData,
  });

  static const Map<String, dynamic> _defaultReportData = {
    'mood': '밝음',
    'confidence': '72%',
    'themes': ['친환경 에너지', '반도체'],
    'keywords': ['기후', '탄소감축', '경제회복', '반도체'],
    'summary':
        '현재 시장의 분위기는 밝으며, 유동성이 높다 판단되는 주식의 테마는 \'친환경 에너지\'와 \'반도체\'입니다.',
    'reason':
        '글로벌 기후 정상회의의 탄소 감축 합의와 아시아 태평양 지역의 경기 회복, 반도체 수출 증가가 함께 반영되었습니다.',
    'positiveRatio': 0.72,
    'negativeRatio': 0.28,
  };

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final data = reportData ?? _defaultReportData;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  final velocity = details.primaryVelocity ?? 0;

                  if (velocity > 300) {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const HomeScreen(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  }
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DateSection(dateText: formatDate(now)),
                      const SizedBox(height: 18),
                      PageTabBar(
                        selectedPage: 2,
                        insightData: data,
                      ),
                      const SizedBox(height: 28),
                      _MarketAnalysisCard(
                        data: data,
                        onTap: () => _showMarketAnalysisBottomSheet(context, data),
                      ),
                      const SizedBox(height: 24),
                      const _KeywordAnalysisCard(),
                      const SizedBox(height: 24),
                      _SentimentAnalysisCard(
                        positiveRatio: data['positiveRatio'] as double,
                        negativeRatio: data['negativeRatio'] as double,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const BottomNavBar(currentIndex: 0),
          ],
        ),
      ),
    );
  }
  void _showMarketAnalysisBottomSheet(
    BuildContext context,
    Map<String, dynamic> data,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF6F6F8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        width: 44,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD3D3DA),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F1F5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Color(0xFF444451),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          '시장 분석 상세',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111111),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _BottomSheetSection(
                      icon: Icons.trending_up,
                      title: '시장 분위기',
                      child: Row(
                        children: [
                          const Icon(
                            Icons.trending_up,
                            size: 18,
                            color: Color(0xFF11B981),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            data['mood'] as String,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF111111),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F7EC),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              '신뢰도 ${data['confidence']}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF27AE60),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _BottomSheetSection(
                      icon: Icons.bolt_outlined,
                      title: '주요 테마',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (data['themes'] as List<dynamic>)
                            .map(
                              (theme) => _SheetThemeChip(
                                text: theme.toString(),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _BottomSheetSection(
                      icon: Icons.analytics_outlined,
                      title: '판단 근거',
                      child: Text(
                        data['reason'] as String,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF333333),
                          height: 1.7,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _BottomSheetSection(
                      icon: Icons.tag_outlined,
                      title: '관련 키워드',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (data['keywords'] as List<dynamic>)
                            .map(
                              (keyword) => _SheetKeywordChip(
                                text: keyword.toString(),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DateSection extends StatelessWidget {
  final String dateText;

  const _DateSection({required this.dateText});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateText,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '글로벌 뉴스 & 경제 리포트',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9A9AA5),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F7EC),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.trending_up,
                size: 16,
                color: Color(0xFF27AE60),
              ),
              SizedBox(width: 6),
              Text(
                '밝음',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF27AE60),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MarketAnalysisCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;

  const _MarketAnalysisCard({
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
          decoration: _cardDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      '시장 분석',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111111),
                      ),
                    ),
                  ),
                  Text(
                    '상세 보기',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8B8B96),
                    ),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: Color(0xFF9A9AA5),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                '시장 분위기',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7A7A86),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.trending_up,
                    size: 19,
                    color: Color(0xFF11B981),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    data['mood'] as String,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE3E3E8)),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '신뢰도: ${data['confidence']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8EC)),
              const SizedBox(height: 22),
              const Text(
                '주요 테마',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7A7A86),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                (data['themes'] as List<dynamic>).join(' & '),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 22),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8EC)),
              const SizedBox(height: 22),
              const Text(
                '시장 동향 분석',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7A7A86),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data['summary'] as String,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF222222),
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomSheetSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _BottomSheetSection({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE3E3E8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F1F5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: const Color(0xFF666674),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111111),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _SheetThemeChip extends StatelessWidget {
  final String text;

  const _SheetThemeChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F7EC),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Color(0xFF27AE60),
        ),
      ),
    );
  }
}

class _SheetKeywordChip extends StatelessWidget {
  final String text;

  const _SheetKeywordChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F5),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Color(0xFF555563),
        ),
      ),
    );
  }
}

class _KeywordAnalysisCard extends StatelessWidget {
  const _KeywordAnalysisCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '키워드 분석',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111111),
            ),
          ),
          SizedBox(height: 20),
          _WordCloudBox(),
        ],
      ),
    );
  }
}

class _WordCloudBox extends StatelessWidget {
  const _WordCloudBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 38,
                left: width * 0.14,
                child: const _WordCloudText(
                  text: '기후변화',
                  size: 28,
                  color: Color(0xFF61A5FF),
                ),
              ),
              Positioned(
                top: 42,
                right: width * 0.12,
                child: const _WordCloudText(
                  text: '탄소중립',
                  size: 26,
                  color: Color(0xFFC26BFF),
                ),
              ),
              Positioned(
                top: 82,
                left: width * 0.44,
                child: const _WordCloudText(
                  text: 'AI',
                  size: 30,
                  color: Color(0xFFE84D9B),
                ),
              ),
              Positioned(
                top: 86,
                right: width * 0.16,
                child: const _WordCloudText(
                  text: '반도체',
                  size: 22,
                  color: Color(0xFF16B96D),
                ),
              ),
              Positioned(
                top: 118,
                left: width * 0.10,
                child: const _WordCloudText(
                  text: '신재생에너지',
                  size: 20,
                  color: Color(0xFFFFB21E),
                ),
              ),
              Positioned(
                top: 134,
                left: width * 0.42,
                child: const _WordCloudText(
                  text: '경제성장',
                  size: 16,
                  color: Color(0xFFFF7B22),
                ),
              ),
              Positioned(
                top: 154,
                right: width * 0.10,
                child: const _WordCloudText(
                  text: '기술투자',
                  size: 16,
                  color: Color(0xFFFF4D4D),
                ),
              ),
              Positioned(
                top: 178,
                left: width * 0.18,
                child: const _WordCloudText(
                  text: '국제협력',
                  size: 13,
                  color: Color(0xFF5D7DFF),
                ),
              ),
              Positioned(
                top: 190,
                left: width * 0.48,
                child: const _WordCloudText(
                  text: '친환경',
                  size: 17,
                  color: Color(0xFF00BFA5),
                ),
              ),
              Positioned(
                top: 218,
                right: width * 0.18,
                child: const _WordCloudText(
                  text: '디지털전환',
                  size: 13,
                  color: Color(0xFF4ECDC4),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _WordCloudText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const _WordCloudText({
    required this.text,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w800,
        color: color,
      ),
    );
  }
}

class _SentimentAnalysisCard extends StatelessWidget {
  final double positiveRatio;
  final double negativeRatio;

  const _SentimentAnalysisCard({
    required this.positiveRatio,
    required this.negativeRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '감성 분석 상세',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 24),
          _SentimentBar(
            label: '긍정 지수',
            valueText: '${(positiveRatio * 100).round()}%',
            ratio: positiveRatio,
            color: const Color(0xFF11B981),
          ),
          const SizedBox(height: 18),
          _SentimentBar(
            label: '부정 지수',
            valueText: '${(negativeRatio * 100).round()}%',
            ratio: negativeRatio,
            color: const Color(0xFFFF4768),
          ),
        ],
      ),
    );
  }
}

class _SentimentBar extends StatelessWidget {
  final String label;
  final String valueText;
  final double ratio;
  final Color color;

  const _SentimentBar({
    required this.label,
    required this.valueText,
    required this.ratio,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF333333),
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              valueText,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF111111),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            minHeight: 7,
            value: ratio,
            backgroundColor: const Color(0xFFE9E9EE),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: const Color(0xFFE3E3E8)),
    boxShadow: const [
      BoxShadow(
        color: Color(0x05000000),
        blurRadius: 6,
        offset: Offset(0, 2),
      ),
    ],
  );
}