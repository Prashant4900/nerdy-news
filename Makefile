.PHONY: apk
apk:
	make clean
	flutter build apk --split-per-abi

.PHONY: get
get:
	flutter pub get

.PHONY: clean
clean:
	flutter clean
	make get

.PHONY: abb
abb:
	make clean
	flutter build appbundle

.PHONY: build
build:
	flutter pub get
	dart run build_runner build --delete-conflicting-outputs

.PHONY: watch
watch:
	dart run build_runner watch

.PHONY: fix
fix:
	dart fix --apply

.PHONY: splash
splash:
	flutter pub get
	dart run flutter_native_splash:create

.PHONY: adb
adb:
	adb tcpip 5555
	sleep 1
	adb connect 192.0.0.2

.PHONY: env
env:
	make get
	dart run env_reader --input=".pro.env" --password="NerdyNews490" --model="lib/gen/env_model.dart" --null-safety

.PHONY: dev-env
dev-env:
	make get
	dart run env_reader --input=".env" --password="NerdyNews490" --model="lib/gen/env_model.dart" --null-safety

