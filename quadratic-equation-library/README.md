# [Bài tập] Đóng gói thư viện giải phương trình bậc 2

Hai dự án Maven Java 17 độc lập được đặt trong **một thư mục**:

- `quadratic-lib/`: dự án thư viện có lớp `com.codegym.QuadraticEquationSolver` với phương thức `solve(a, b, c)`. Trả về loại nghiệm và danh sách nghiệm (sắp xếp tăng dần).
- `quadratic-demo-app/`: chương trình Java Console nhập `a`, `b`, `c` và gọi **file JAR đã biên dịch** ở `quadratic-demo-app/lib/quadratic-lib.jar`. Không sao chép `QuadraticEquationSolver.java` sang ứng dụng.

## Các trường hợp được xử lý

| Phương trình | Kết quả |
|---|---|
| `x² - 3x + 2 = 0` | Hai nghiệm `1`, `2` |
| `x² - 2x + 1 = 0` | Nghiệm kép `1` |
| `x² + x + 1 = 0` | Vô nghiệm thực |
| `2x - 8 = 0` | Phương trình bậc nhất, `x = 4` |
| `0x + 5 = 0` | Vô nghiệm |
| `0 = 0` | Vô số nghiệm |

Dữ liệu hệ số NaN/vô cực bị từ chối.

## Đóng gói bằng Maven

Yêu cầu Java 17 trở lên và Maven.

1. Vào thư mục `quadratic-lib`, chạy `mvn clean package` để tạo `target/quadratic-lib-1.0-SNAPSHOT.jar`.
2. Chép file vừa tạo sang `quadratic-demo-app/lib/quadratic-lib.jar` (ghi đè JAR mẫu).
3. Vào thư mục `quadratic-demo-app`, chạy `mvn clean package`.
4. Chạy ứng dụng với:
   - Windows: `java -cp "target/classes;lib/quadratic-lib.jar" com.codegym.Main`
   - Linux/macOS: `java -cp "target/classes:lib/quadratic-lib.jar" com.codegym.Main`

Nhập thử `a=1`, `b=-3`, `c=2` để được hai nghiệm `1`, `2`.

Có thể chạy chương trình độc lập bằng `javac --release 17` và `jar` nếu máy chưa cài Maven. JAR đi kèm trong `lib/` được biên dịch thật từ mã Java 17 rồi tải lên GitHub để người chấm có thể kiểm tra ngay.

> `system` scope và `systemPath` là cách đơn giản để minh họa nhúng JAR cục bộ trong bài thực hành. Với dự án thực tế nên dùng Maven Repository và khai báo dependency thông thường.
