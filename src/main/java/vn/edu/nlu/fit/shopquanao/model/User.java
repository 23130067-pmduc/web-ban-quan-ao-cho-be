package vn.edu.nlu.fit.shopquanao.model;

public class User {
        private int id;
        private String username;
        private String email;
        private String password;
        private String role;
        private int isActive;

        // ===== constructor rỗng (BẮT BUỘC cho JDBI) =====
        public User() {}

        // ===== getter / setter =====
        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        // map password_hash → passwordHash
        public String getRole() {
            return role;
        }

        public void setRole(String role) {
            this.role = role;
        }

    public int getIsActive() {return isActive;}

    public void setIsActive(int isActive) {this.isActive = isActive;}

        @Override
        public String toString() {
            return "User{" +
                    "id=" + id +
                    ", name='" + username + '\'' +
                    ", email='" + email + '\'' +
                    ", role='" + role + '\'' +
                    ", isActive=" + isActive +
                    '}';
        }


}
