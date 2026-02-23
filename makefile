doc:
	docker run -it --rm --name n8n \
		-p 5678:5678 \
		-e N8N_SECURE_COOKIE=false \
		-e WEBHOOK_URL=$(URL) \
		-e WEBHOOK_TUNNEL_URL=$(URL) \
		-e N8N_ENCRYPTION_KEY=mnogo-govna-i-palok \
		-v n8n_data:/home/node/.n8n \
		docker.n8n.io/n8nio/n8n


.PHONY: up down restart ps logs help

help:
	@echo "Команды:"
	@echo "  make up                          - запуск n8n (по умолчанию localhost)"
	@echo "  make up URL=https://xxxx.ru.tuna.am - запуск n8n с туннелем"
	@echo "  make down                        - остановка n8n"
	@echo "  make restart                     - перезапуск n8n"
	@echo "  make ps                          - статус контейнера"
	@echo "  make logs                        - логи n8n"

up:
	powershell -NoProfile -ExecutionPolicy Bypass -File .\start.ps1 -Url "$(URL)"

down:
	powershell -NoProfile -ExecutionPolicy Bypass -File .\stop.ps1

restart: down up

ps:
	docker ps --filter "name=n8n"

logs:
	docker logs -f n8n
