import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null) setState(() => _selectedTime = picked);
  }

  String _formatTime(TimeOfDay time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('설정', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('알림 및 시스템 설정을 관리합니다', style: TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 24),

          // 알림 설정 카드
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications_outlined, size: 18, color: Colors.orange[700]),
                    const SizedBox(width: 6),
                    const Text('알림 설정', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.access_time_outlined, size: 15, color: Colors.grey[500]),
                    const SizedBox(width: 6),
                    Text('일일 리포트 알림 시간', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                  ],
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickTime,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(_formatTime(_selectedTime), style: const TextStyle(fontSize: 14)),
                  ),
                ),
                const SizedBox(height: 6),
                Text('매일 ${_formatTime(_selectedTime)}에 새로운 뉴스 리포트를 받아보세요',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('알림음', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        Text('알림 발생 시 소리 재생', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      ],
                    ),
                    Switch(
                      value: _soundEnabled,
                      onChanged: (v) => setState(() => _soundEnabled = v),
                      activeColor: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('진동', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        Text('알림 발생 시 진동 (모바일)', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      ],
                    ),
                    Switch(
                      value: _vibrationEnabled,
                      onChanged: (v) => setState(() => _vibrationEnabled = v),
                      activeColor: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('테스트 알림을 전송했습니다')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('알림 테스트', style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // 하단 크레딧
          Center(
            child: Column(
              children: [
                Text('Powered by NewsAPI, Google Trends, Gemini API & Imagen3 (준비 중)',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade400), textAlign: TextAlign.center),
                const SizedBox(height: 4),
                Text('Global News Report © 2026 | Mock 데이터를 사용한 프로토타입입니다',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade400), textAlign: TextAlign.center),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}