# ssh-checker
---
- [ssh-check Github](https://github.com/pitimon/ssh-checker)
---
- ใช้ Alpine Linux ซึ่งมีขนาดเล็กและมีช่องโหว่น้อย
- ใช้ PHP-FPM ซึ่งมีประสิทธิภาพดีกว่า mod_php ของ Apache
- มีการตั้งค่าความปลอดภัยพื้นฐานใน Nginx
- ไม่เปิดเผยเวอร์ชันของ Nginx (server_tokens off)
---
เช็ตพอร์ต 8080 ว่างหรือไม่ หากไม่ก็เปลี่ยนไปพอร์ตอื่น

```
docker run -d -p 8080:80 --name ssh-check ipvsix/secure-ssh-check
```
---
change [SSH_server_target] = ปลายทางทดสอบ เช่น 127.0.0.1 เป็นต้น
```
curl "http://localhost:8080/ssh_check.php?host=[SSH_server_target]&port=22"
```
หากสำเร็จจะแสดง "SSH" ออกมา

---
[![Docker](https://github.com/pitimon/ssh-checker/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/pitimon/ssh-checker/actions/workflows/docker-publish.yml)
---
Build Docker file
```
docker build -t ipvsix/secure-ssh-check .
```
```
docker push ipvsix/secure-ssh-check
```

---
- [secure-ssh-check@Dockerhub](https://hub.docker.com/r/ipvsix/secure-ssh-check)
---
