import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2026. 04. 06'),
        actions: [
          // 1. 상태 표시 칩 (디자인 우측 상단)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '밝음',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          // 2. 다크모드 아이콘
          IconButton(
            icon: const Icon(Icons.dark_mode_outlined, size: 22),
            onPressed: () => print('다크모드 클릭'),
          ),
          // 3. 알림 아이콘
          IconButton(
            icon: const Icon(Icons.notifications_none, size: 22),
            onPressed: () => print('알림 클릭'),
          ),
          // 4. 설정 아이콘
          IconButton(
            icon: const Icon(Icons.settings_outlined, size: 22),
            onPressed: () => print('설정 클릭'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 탭 버튼 (1면, 2면, 3면)
            Row(
              children: [
                _buildTabButton('1면', true),
                _buildTabButton('2면', false),
                _buildTabButton('3면', false),
              ],
            ),
            const SizedBox(height: 20),

            // 뉴스 카드 (Imagen 3 생성 이미지 공간 포함)
            _buildNewsCard(),

            const SizedBox(height: 24),

            // 오늘의 주요 뉴스 제목
            const Text(
              '오늘의 주요 뉴스',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // 요약 텍스트 컨테이너 (Gemini API 결과물 자리)
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'MMR 기법으로 요약된 오늘의 핵심 뉴스 내용이 여기에 들어갑니다. '
                '전세계 15개국에서 수집된 정보를 바탕으로 가장 중요한 흐름을 정리해 드립니다. '
                '람다값 조절을 통해 다양성이 확보된 뉴스들입니다.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),

      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.description), label: '리포트'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: '기록'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
        ],
      ),
    );
  }

  // 뉴스 카드 위젯 함수
  Widget _buildNewsCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // 이미지 placeholder (나중에 실제 Imagen 3 이미지 URL 연동)
              Container(
                height: 220,
                width: double.infinity,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.image_outlined,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
              // 하단 국가/카테고리 라벨
              Positioned(
                bottom: 12,
                left: 12,
                child: Row(
                  children: [
                    _buildLabel('브라질', Colors.black),
                    const SizedBox(width: 8),
                    _buildLabel('환경', Colors.grey[700]!),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '아마존 산림 복원 프로젝트: 새로운 희망',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  '최근 발표된 보고서에 따르면 아마존 지역의 재조림 사업이 예상보다 빠른 속도로 진행되고 있으며, 생태계 회복에 긍정적인 영향을 미치고 있습니다.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 공통 라벨 (Chip) 위젯
  Widget _buildLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 상단 탭 버튼 위젯
  Widget _buildTabButton(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isActive ? null : Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
