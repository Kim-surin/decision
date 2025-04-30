# 관세환급(drwb)
---
- CodeBuild 내 Profile(dev/stg/prd)별 프로퍼티 관리 src/main/resources/application-$PROFILE.properties
```
spring.datasource.hikari.jdbc-url=jdbc:log4jdbc:oracle:thin:@ctdev-dds-ora-01.caizqquwbw1r.ap-northeast-2.rds.amazonaws.com:3921:DDSDEV
spring.datasource.hikari.jdbc-url=jdbc:log4jdbc:oracle:thin:@ctstg-dds-ora-01.cxdgflc6nxpv.ap-northeast-2.rds.amazonaws.com:3921:DDSSTG
spring.datasource.hikari.jdbc-url=jdbc:log4jdbc:oracle:thin:@ctprd-dds-ora-01.cpufhzuamh8y.ap-northeast-2.rds.amazonaws.com:3921:DDSPRD
```
---
- CodeBuild파일(buildspec.yml)에서 application-$PROFILE.properties를 application.properties로 복사
- Profile 별 파일 분기 시 해당내용 추가필요함.
```yml
  build:
    commands:
      # 설정파일 변경
      - cp -vf src/main/resources/application-$PROFILE.properties src/main/resources/application.properties

```
---
- develop - staging - master 반영 시, git web에서 merge request
---

---
