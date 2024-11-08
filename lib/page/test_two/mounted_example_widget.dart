import 'package:flutter/material.dart';

class MountedExampleWidget extends StatefulWidget {
  const MountedExampleWidget({super.key});

  @override
  State<MountedExampleWidget> createState() => _MountedExampleWidgetState();
}

class _MountedExampleWidgetState extends State<MountedExampleWidget> {
  bool _isLoading = false;
  String _data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: Text('Fetch Data'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Text(_data),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 네트워크 요청을 보내고 데이터를 가져옴
      String newData = await fetchDataFromNetwork();

      // 데이터를 가져온 후에 해당 위젯이 여전히 마운트되어 있는지 확인
      if (mounted) {
        setState(() {
          _data = newData;
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      // 에러 처리
      // mounted를 확인할 필요 없음
      setState(() {
        _isLoading = false;
        _data = 'Error fetching data';
      });
    }
  }

  Future<String> fetchDataFromNetwork() async {
    // 네트워크 요청 시뮬레이션
    await Future.delayed(Duration(seconds: 2));
    // 데이터를 가져와서 반환
    return 'Data from network';
  }
}

