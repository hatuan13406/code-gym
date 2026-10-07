# SmartFactory - Reindex Optimization

Bài tập tối ưu Index cho hệ thống IoT SmartFactory.

## Nội dung bài nộp

### 1. smartfactory_reindex.sql
Chứa:
- Tạo bảng `SensorLogs`
- Tạo Fat Covering Index `idx_fat_covering`
- Đo `Data_MB`, `Index_MB`, `Total_MB`
- Chạy `EXPLAIN` trước khi tối ưu
- Xóa `idx_fat_covering`
- Tạo Lean Index `idx_lean_search(sensor_id, recorded_at)`
- Chạy `EXPLAIN` sau khi tối ưu
- Đo lại dung lượng Index sau khi tối ưu

File:
https://github.com/hatuan13406/code-gym/blob/main/mysql/smartfactory-reindex-optimization/smartfactory_reindex.sql

### 2. index_tradeoff_report.md
Báo cáo giải thích sự đánh đổi giữa tốc độ đọc, tốc độ ghi và dung lượng lưu trữ.

File:
https://github.com/hatuan13406/code-gym/blob/main/mysql/smartfactory-reindex-optimization/index_tradeoff_report.md

### 3. ai_prompt_log.md
Nhật ký tìm hiểu:
- Covering Index
- Clustered Index và Secondary Index
- Write Penalty
- Index storage
- `Using index` và `Using index condition`
- Ước lượng kích thước kiểu dữ liệu

File:
https://github.com/hatuan13406/code-gym/blob/main/mysql/smartfactory-reindex-optimization/ai_prompt_log.md

## Index tối ưu

```sql
ALTER TABLE SensorLogs
DROP INDEX idx_fat_covering;

CREATE INDEX idx_lean_search
ON SensorLogs(sensor_id, recorded_at);
```

## Truy vấn kiểm tra

```sql
EXPLAIN
SELECT temperature, humidity, status
FROM SensorLogs
WHERE sensor_id = 105
  AND recorded_at >= '2026-06-20 00:00:00';
```

Repo public:
https://github.com/hatuan13406/code-gym
