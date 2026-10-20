# 자재 판매 단가점검 — 빌드 없는 정적 페이지(index.html 한 장)를 nginx로 서빙
FROM nginx:1.27-alpine

# 공개할 파일만 복사 (README·.git 등이 웹에 노출되지 않게 COPY . 는 쓰지 않음)
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

# localhost 대신 127.0.0.1 — alpine에서 IPv6 우선 접속으로 점검이 실패하는 문제 방지
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider http://127.0.0.1/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
