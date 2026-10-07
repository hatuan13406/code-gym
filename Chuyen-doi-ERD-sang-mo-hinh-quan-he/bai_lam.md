# Bài tập: Chuyển đổi ERD sang mô hình quan hệ

## Bước 1. Xác định các thực thể

Từ ERD, có 5 thực thể chính:

1. **PHIEUXUAT**
   - **SoPX**: khóa chính
   - NgayXuat

2. **VATTU**
   - **MaVTU**: khóa chính
   - TenVTU

3. **PHIEUNHAP**
   - **SoPN**: khóa chính
   - NgayNhap

4. **DONDH**
   - **SoDH**: khóa chính
   - NgayDH

5. **NHACC**
   - **MaNCC**: khóa chính
   - TenNCC
   - DiaChi
   - SDT: thuộc tính đa trị

---

## Bước 2. Xác định các mối quan hệ

### Quan hệ 1: Chi tiết phiếu xuất

Giữa **PHIEUXUAT** và **VATTU** là quan hệ **N - N**.

Quan hệ có các thuộc tính:
- DGXuat
- SLXuat

Vì là quan hệ N - N nên tạo bảng trung gian:

**CHITIETPHIEUXUAT**(
- **SoPX** PK, FK
- **MaVTU** PK, FK
- DGXuat
- SLXuat
)

Khóa ngoại:
- SoPX → PHIEUXUAT(SoPX)
- MaVTU → VATTU(MaVTU)

---

### Quan hệ 2: Chi tiết phiếu nhập

Giữa **VATTU** và **PHIEUNHAP** là quan hệ **N - N**.

Quan hệ có các thuộc tính:
- DGNhap
- SLNhap

Tạo bảng trung gian:

**CHITIETPHIEUNHAP**(
- **SoPN** PK, FK
- **MaVTU** PK, FK
- DGNhap
- SLNhap
)

Khóa ngoại:
- SoPN → PHIEUNHAP(SoPN)
- MaVTU → VATTU(MaVTU)

---

### Quan hệ 3: Chi tiết đơn đặt hàng

Giữa **VATTU** và **DONDH** là quan hệ **N - N**.

Quan hệ này không có thuộc tính riêng trên ERD nên tạo bảng trung gian:

**CHITIETDONDH**(
- **SoDH** PK, FK
- **MaVTU** PK, FK
)

Khóa ngoại:
- SoDH → DONDH(SoDH)
- MaVTU → VATTU(MaVTU)

---

### Quan hệ 4: Cung cấp

Giữa **NHACC** và **DONDH** là quan hệ **1 - N**:

- Một nhà cung cấp có thể cung cấp nhiều đơn đặt hàng.
- Mỗi đơn đặt hàng thuộc về một nhà cung cấp.

Với quan hệ 1 - N, đưa khóa chính của phía 1 vào bảng phía N.

Do đó thêm **MaNCC** vào bảng **DONDH** làm khóa ngoại.

**DONDH**(
- **SoDH** PK
- NgayDH
- MaNCC FK
)

Khóa ngoại:
- MaNCC → NHACC(MaNCC)

---

## Bước 3. Xử lý thuộc tính đa trị

Trong thực thể **NHACC**, thuộc tính **SDT** được vẽ bằng hình oval kép nên đây là thuộc tính đa trị.

Một nhà cung cấp có thể có nhiều số điện thoại, vì vậy tách SDT thành bảng riêng:

**NHACC_SDT**(
- **MaNCC** PK, FK
- **SDT** PK
)

Khóa ngoại:
- MaNCC → NHACC(MaNCC)

Sau khi tách, bảng **NHACC** còn:

**NHACC**(
- **MaNCC** PK
- TenNCC
- DiaChi
)

---

## Bước 4. Mô hình dữ liệu quan hệ sau khi chuyển đổi

### 1. PHIEUXUAT

```text
PHIEUXUAT(SoPX PK, NgayXuat)
```

### 2. VATTU

```text
VATTU(MaVTU PK, TenVTU)
```

### 3. PHIEUNHAP

```text
PHIEUNHAP(SoPN PK, NgayNhap)
```

### 4. NHACC

```text
NHACC(MaNCC PK, TenNCC, DiaChi)
```

### 5. NHACC_SDT

```text
NHACC_SDT(
    MaNCC PK, FK -> NHACC(MaNCC),
    SDT PK
)
```

### 6. DONDH

```text
DONDH(
    SoDH PK,
    NgayDH,
    MaNCC FK -> NHACC(MaNCC)
)
```

### 7. CHITIETPHIEUXUAT

```text
CHITIETPHIEUXUAT(
    SoPX PK, FK -> PHIEUXUAT(SoPX),
    MaVTU PK, FK -> VATTU(MaVTU),
    DGXuat,
    SLXuat
)
```

### 8. CHITIETPHIEUNHAP

```text
CHITIETPHIEUNHAP(
    SoPN PK, FK -> PHIEUNHAP(SoPN),
    MaVTU PK, FK -> VATTU(MaVTU),
    DGNhap,
    SLNhap
)
```

### 9. CHITIETDONDH

```text
CHITIETDONDH(
    SoDH PK, FK -> DONDH(SoDH),
    MaVTU PK, FK -> VATTU(MaVTU)
)
```

---

## Kết quả cuối cùng

Sau khi chuyển đổi ERD sang mô hình quan hệ, thu được **9 bảng**:

1. PHIEUXUAT
2. VATTU
3. PHIEUNHAP
4. DONDH
5. NHACC
6. NHACC_SDT
7. CHITIETPHIEUXUAT
8. CHITIETPHIEUNHAP
9. CHITIETDONDH

Các quan hệ N - N đã được chuyển thành bảng trung gian, quan hệ 1 - N được xử lý bằng khóa ngoại và thuộc tính đa trị SDT được tách thành một bảng riêng.
