#!/bin/bash

# Fungsi untuk menjalankan layanan selama durasi tertentu
run_service() {
    local service_name=$1
    local duration=$2

    echo "Starting $service_name for $duration minutes..."
    sudo systemctl daemon-reload && sudo systemctl restart "$service_name"
    sleep "$((duration * 60))"  # Konversi menit ke detik
    echo "Stopping $service_name..."
    sudo systemctl stop "$service_name"
}

# Fungsi untuk mengacak urutan kerja
randomize_work() {
    local choice=$((RANDOM % 3 + 1))  # Menghasilkan angka acak antara 1 dan 3
    case $choice in
        1)
            run_service "update-service70.service" 15
            ;;
        2)
            run_service "update-service80.service" 40
            ;;
        3)
            echo "Pausing for 5 minutes..."
            sleep 300  # 5 menit dalam detik
            ;;
    esac
}

# Jalankan pekerjaan acak 3 kali untuk total 1 jam
for i in {1..3}; do
    randomize_work
done
