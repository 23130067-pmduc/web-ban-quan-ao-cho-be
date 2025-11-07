-- ====================================
-- DATABASE: SunnyBear Kids - Shop Quần Áo Trẻ Em
-- ====================================

-- Tạo database
CREATE DATABASE IF NOT EXISTS sunnybear_kids
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE sunnybear_kids;

-- ====================================
-- BẢNG 1: users (Người dùng)
-- ====================================
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    role ENUM('admin', 'customer') DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- BẢNG 2: categories (Danh mục sản phẩm)
-- ====================================
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- BẢNG 3: products (Sản phẩm)
-- ====================================
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(200) NOT NULL,
    category_id INT NOT NULL,
    description TEXT,
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2) NOT NULL,
    discount_percent INT DEFAULT 0,
    stock_quantity INT DEFAULT 0,
    sold_quantity INT DEFAULT 0,
    image_url VARCHAR(255),
    badge_type ENUM('flash', 'hot', 'sale', 'new') DEFAULT NULL,
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- BẢNG 4: orders (Đơn hàng)
-- ====================================
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address TEXT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('cod', 'bank_transfer', 'credit_card') DEFAULT 'cod',
    order_status ENUM('pending', 'confirmed', 'shipping', 'delivered', 'cancelled') DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- BẢNG 5: order_details (Chi tiết đơn hàng)
-- ====================================
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- BẢNG 6: coupons (Mã giảm giá)
-- ====================================
CREATE TABLE coupons (
    coupon_id INT PRIMARY KEY AUTO_INCREMENT,
    coupon_code VARCHAR(50) UNIQUE NOT NULL,
    discount_type ENUM('percent', 'fixed') NOT NULL,
    discount_value DECIMAL(10,2) NOT NULL,
    min_order_value DECIMAL(10,2) DEFAULT 0,
    max_discount DECIMAL(10,2),
    usage_limit INT DEFAULT NULL,
    used_count INT DEFAULT 0,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- BẢNG 7: reviews (Đánh giá sản phẩm)
-- ====================================
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- BẢNG 8: cart (Giỏ hàng)
-- ====================================
CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_product (user_id, product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================
-- DỮ LIỆU MẪU
-- ====================================

-- Thêm danh mục sản phẩm
INSERT INTO categories (category_name, description) VALUES
('Áo thun', 'Áo thun cotton mềm mại cho bé'),
('Áo polo', 'Áo polo lịch sự, phong cách'),
('Áo khoác', 'Áo khoác giữ ấm cho bé'),
('Quần short', 'Quần short thoải mái'),
('Quần dài', 'Quần dài cho bé'),
('Bộ đồ', 'Bộ quần áo hoàn chỉnh'),
('Váy', 'Váy xinh xắn cho bé gái'),
('Phụ kiện', 'Nón, tất, khăn và phụ kiện khác');

-- Thêm tài khoản admin mẫu (password: admin123 - đã hash)
INSERT INTO users (username, email, password, full_name, phone, role) VALUES
('admin', 'admin@sunnybear.com', '$2y$10$YourHashedPasswordHere', 'Administrator', '0123456789', 'admin'),
('customer1', 'customer@example.com', '$2y$10$YourHashedPasswordHere', 'Nguyễn Văn A', '0987654321', 'customer');

-- Thêm sản phẩm mẫu
INSERT INTO products (product_name, category_id, description, old_price, new_price, discount_percent, stock_quantity, sold_quantity, badge_type, is_featured) VALUES
('Áo thun bé trai in hình khủng long', 1, 'Áo thun cotton 100% thoáng mát, in hình khủng long dễ thương', 150000, 120000, 20, 50, 15, 'hot', TRUE),
('Áo polo bé trai phối viền', 2, 'Áo polo cao cấp, phối viền sang trọng', 200000, 159000, 20, 30, 8, 'sale', TRUE),
('Áo khoác bé gái hoa văn', 3, 'Áo khoác dày dặn, giữ ấm tốt', 300000, 240000, 20, 20, 5, 'new', FALSE),
('Quần short bé trai', 4, 'Quần short jean co giãn thoải mái', 120000, 99000, 18, 40, 12, NULL, FALSE),
('Bộ đồ bé gái công chúa', 6, 'Bộ áo váy xinh xắn phong cách công chúa', 350000, 280000, 20, 25, 18, 'hot', TRUE),
('Váy hoa nhí bé gái', 7, 'Váy cotton hoa nhí tươi mát', 180000, 150000, 17, 35, 10, NULL, FALSE),
('Áo thun bé gái in hình gấu', 1, 'Áo thun form rộng thoải mái', 140000, 120000, 14, 45, 20, 'flash', TRUE),
('Quần jean bé trai', 5, 'Quần jean dài bền đẹp', 220000, 180000, 18, 30, 7, NULL, FALSE);

-- Thêm mã giảm giá
INSERT INTO coupons (coupon_code, discount_type, discount_value, min_order_value, max_discount, usage_limit, start_date, end_date) VALUES
('WELCOME10', 'percent', 10.00, 200000, 50000, 100, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY)),
('FREESHIP', 'fixed', 30000, 500000, 30000, 50, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY)),
('FLASH50', 'percent', 50.00, 1000000, 200000, 20, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY));

-- ====================================
-- INDEXES để tối ưu hiệu suất
-- ====================================
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_badge ON products(badge_type);
CREATE INDEX idx_products_featured ON products(is_featured);
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(order_status);
CREATE INDEX idx_reviews_product ON reviews(product_id);
CREATE INDEX idx_cart_user ON cart(user_id);

-- ====================================
-- VIEWS hữu ích
-- ====================================

-- View: Sản phẩm bán chạy
CREATE VIEW v_bestsellers AS
SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    p.new_price,
    p.old_price,
    p.sold_quantity,
    p.stock_quantity,
    p.badge_type
FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER BY p.sold_quantity DESC
LIMIT 10;

-- View: Thống kê đơn hàng theo trạng thái
CREATE VIEW v_order_statistics AS
SELECT 
    order_status,
    COUNT(*) as total_orders,
    SUM(total_amount) as total_revenue
FROM orders
GROUP BY order_status;

-- View: Sản phẩm flash sale
CREATE VIEW v_flash_sale_products AS
SELECT 
    p.product_id,
    p.product_name,
    p.new_price,
    p.old_price,
    p.discount_percent,
    p.stock_quantity,
    p.sold_quantity,
    ROUND((p.sold_quantity / (p.sold_quantity + p.stock_quantity)) * 100) as sold_percent
FROM products p
WHERE p.badge_type = 'flash'
ORDER BY sold_percent DESC;

-- ====================================
-- STORED PROCEDURES
-- ====================================

-- Procedure: Thêm sản phẩm vào giỏ hàng
DELIMITER //
CREATE PROCEDURE sp_add_to_cart(
    IN p_user_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    INSERT INTO cart (user_id, product_id, quantity)
    VALUES (p_user_id, p_product_id, p_quantity)
    ON DUPLICATE KEY UPDATE quantity = quantity + p_quantity;
END//
DELIMITER ;

-- Procedure: Tạo đơn hàng
DELIMITER //
CREATE PROCEDURE sp_create_order(
    IN p_user_id INT,
    IN p_full_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(20),
    IN p_address TEXT,
    IN p_payment_method VARCHAR(20),
    IN p_notes TEXT,
    OUT p_order_id INT
)
BEGIN
    DECLARE v_total DECIMAL(10,2);
    
    -- Tính tổng tiền từ giỏ hàng
    SELECT SUM(p.new_price * c.quantity)
    INTO v_total
    FROM cart c
    JOIN products p ON c.product_id = p.product_id
    WHERE c.user_id = p_user_id;
    
    -- Tạo đơn hàng
    INSERT INTO orders (user_id, full_name, email, phone, address, total_amount, payment_method, notes)
    VALUES (p_user_id, p_full_name, p_email, p_phone, p_address, v_total, p_payment_method, p_notes);
    
    SET p_order_id = LAST_INSERT_ID();
    
    -- Thêm chi tiết đơn hàng
    INSERT INTO order_details (order_id, product_id, product_name, quantity, unit_price, subtotal)
    SELECT 
        p_order_id,
        c.product_id,
        p.product_name,
        c.quantity,
        p.new_price,
        p.new_price * c.quantity
    FROM cart c
    JOIN products p ON c.product_id = p.product_id
    WHERE c.user_id = p_user_id;
    
    -- Cập nhật số lượng tồn kho và đã bán
    UPDATE products p
    JOIN cart c ON p.product_id = c.product_id
    SET p.stock_quantity = p.stock_quantity - c.quantity,
        p.sold_quantity = p.sold_quantity + c.quantity
    WHERE c.user_id = p_user_id;
    
    -- Xóa giỏ hàng
    DELETE FROM cart WHERE user_id = p_user_id;
END//
DELIMITER ;

-- ====================================
-- KẾT THÚC SCRIPT
-- ====================================
