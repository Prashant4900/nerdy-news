.PHONY: apk
apk:
	make clean
	flutter build apk --split-per-abi

.PHONY: get
get:
	flutter pub get
	flutter pub get --directory ./packages/auth
	flutter pub get --directory ./packages/feedback
	flutter pub get --directory ./packages/analytics
	flutter pub get --directory ./packages/news

.PHONY: clean
clean:
	flutter clean
	make get

.PHONY: build
build:
	dart run build_runner build

.PHONY: watch
watch:
	dart run build_runner watch

.PHONY: fix
fix:
	dart fix --apply

.PHONY: splash
splash:
	dart run flutter_native_splash:create

.PHONY: adb
adb:
	adb tcpip 5555
	sleep 1
	adb connect 192.0.0.2

.PHONY: env
env:
	dart run env_reader --input=".pro.env" --password="NerdyNews490" --model="lib/gen/env_model.dart" --null-safety

