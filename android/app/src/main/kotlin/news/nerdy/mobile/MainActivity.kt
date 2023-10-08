package news.nerdy.mobile

import android.os.Bundle
import android.net.Uri
import android.content.Intent;
import android.os.Environment
import android.content.Context // Add this import


import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

import android.provider.Telephony;

import java.io.File

import androidx.core.content.FileProvider

class MainActivity: FlutterActivity() {
    
    private val CHANNEL = "your_unique_channel_name" // Match the channel name in Dart

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "shareBySMS") {
                val message = call.argument<String>("message")
                val filePath = call.argument<String>("filePath")
                println("Received text from Flutter: $message $filePath")

                openSmsApp(message, filePath, this)

                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun openSmsApp(message: String?, filePath: String?, context: Context) {
        val smsPackageName = Telephony.Sms.getDefaultSmsPackage(context) // Replace with the package name of your desired SMS app
                        println("smsPackageName: $smsPackageName")
        val intent = Intent(Intent.ACTION_SEND)
        // intent.data = Uri.parse("smsto:")
        intent.type = "image/*"

        filePath?.let {
            // Get the URI of the image file
            val imageFile = File(filePath)
            val imageUri = FileProvider.getUriForFile(
                context,
                context.packageName + ".provider",
                imageFile
            )

            // Add the image URI to the intent
            intent.putExtra(Intent.EXTRA_STREAM, imageUri)
        }

        message?.let {
            // Add the text message to the intent
            intent.putExtra(Intent.EXTRA_TEXT, message)        
        }



        // Set flags to grant temporary read permission to the content URI
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)

        // intent.setPackage(smsPackageName) // Set the package name of the SMS app


        val chooserIntent = Intent.createChooser(intent, "Send Image via SMS")

        startActivity(chooserIntent)
    }
}
