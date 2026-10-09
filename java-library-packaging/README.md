# [Thực hành] Đóng gói thư viện Java – CodeGym

Thư mục này có **hai dự án Maven độc lập** để chứng minh việc đóng gói và tái sử dụng `.jar`.

- [`math-lib/`](math-lib/): Java 17 Maven library, `groupId=com.codegym`, `artifactId=math-lib`; lớp `com.codegym.Calculator` có các hàm static `sum`, `sub`, `mul` và `divide`.
- [`calculator-app/`](calculator-app/): ứng dụng Console Maven độc lập gọi `Calculator` từ **file JAR nhị phân** [`calculator-app/lib/math-lib.jar`](calculator-app/lib/math-lib.jar). Thư mục ứng dụng **không chứa mã nguồn `Calculator.java`**.

## Chạy từ nguồn bằng Maven

Yêu cầu: **Java 17+ và Maven**.

1. Mở terminal trong `math-lib/`, chạy `mvn clean package`. Kết quả sẽ là `math-lib/target/math-lib-1.0-SNAPSHOT.jar`.
2. Sao chép file `math-lib/target/math-lib-1.0-SNAPSHOT.jar` đến `calculator-app/lib/math-lib.jar` (ghi đè bản có sẵn nếu cần).
3. Mở terminal trong `calculator-app/`, chạy `mvn clean package`.
4. Chạy:
   - Windows: `java -cp "target/classes;lib/math-lib.jar" com.codegym.Main`
   - macOS/Linux: `java -cp "target/classes:lib/math-lib.jar" com.codegym.Main`

> `systemPath` được cấu hình đúng yêu cầu thực hành để Maven biên dịch từ JAR bên ngoài, không tải thư viện từ Maven Central. Trong dự án thực tế, nên cài JAR vào local Maven repository (`mvn install`) hoặc dùng dependency từ repository, tránh dùng `system` scope.

## Ví dụ kết quả

```text
Kết quả gọi từ thư viện đóng gói (.jar):
Tổng 2 số (5, 9): 14
Hiệu 2 số (5, 9): -4
Tích 2 số (5, 9): 45
Thương 2 số (10, 5): 2
```

Để kiểm tra ngoại lệ chia cho 0, bỏ dấu chú thích ở dòng thử `Calculator.divide(10, 0)` trong `Main.java`, chạy lại chương trình. Ngoại lệ `NoSuchAlgorithmException` là điều kiện **riêng của đề CodeGym**; trong phần mềm thực tế thường dùng `ArithmeticException` hoặc `IllegalArgumentException`.

File JAR trong `calculator-app/lib` đã được biên dịch từ `math-lib/src/main/java/com/codegym/Calculator.java` với mức bytecode Java 17 (`javac --release 17`) và lưu kèm lên GitHub để có thể chạy app ngay.
