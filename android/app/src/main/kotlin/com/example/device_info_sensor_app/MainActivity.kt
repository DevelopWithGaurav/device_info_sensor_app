package com.example.device_info_sensor_app

import android.annotation.SuppressLint
import android.content.Context
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
import android.os.BatteryManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "com.example.device/info"

    @SuppressLint("ServiceCast")
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
                call, result ->
            if (call.method == "getDeviceInfo") {
                val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                val batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)

                val deviceName = "${Build.MANUFACTURER} ${Build.MODEL}"
                val osVersion = "Android ${Build.VERSION.RELEASE}"

                val info = mapOf(
                    "battery" to batteryLevel,
                    "deviceName" to deviceName,
                    "osVersion" to osVersion
                )

                result.success(info)
            } else if (call.method == "toggleFlashlight") {
                val turnOn = call.argument<Boolean>("turnOn") ?: false
                try {
                    val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
                    val cameraId = cameraManager.cameraIdList.firstOrNull {
                        cameraManager.getCameraCharacteristics(it).get(android.hardware.camera2.CameraCharacteristics.FLASH_INFO_AVAILABLE) == true
                    }
                    cameraId?.let {
                        cameraManager.setTorchMode(it, turnOn)
                        result.success(null)
                    } ?: result.error("NO_CAMERA", "No camera with flashlight found.", null)
                } catch (e: CameraAccessException) {
                    result.error("CAMERA_ERROR", "Failed to access camera: ${e.message}", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
