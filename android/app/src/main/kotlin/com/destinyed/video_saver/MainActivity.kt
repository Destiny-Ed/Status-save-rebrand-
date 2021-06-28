package com.destinyed.video_saver

import android.content.ActivityNotFoundException
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.media.ThumbnailUtils
import android.net.Uri
import android.provider.MediaStore
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.print.PrintHelper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.nativeAPI"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->

            when (call.method) {
                "showWhatsApp" -> {

                    val appPackage = call.argument<String>("appPackage")

                    showWhatsApp(appPackage!!)
                }
                "printImage" -> {
                    val image = call.argument<String>("image")
                    val title = call.argument<String>("title")

                    printImage(image!!, title);
                }
                "shareImage" -> {
                    val image = call.argument<String>("image")

                    shareImage(image!!)
                }
                "videoThumbNail" -> {
                    val image = call.argument<String>("image");
                    var video = ThumbnailUtils.createVideoThumbnail(image!!, MediaStore.Images.Thumbnails.MICRO_KIND)
                    result.success(video);
                }
                else -> {
                    result.notImplemented();
                }
            }
        }
    }


    // Show WhatsApp Function
    private fun showWhatsApp(appPackage: String) {
        try {
            var intent = context.packageManager.getLaunchIntentForPackage(appPackage);
            startActivity(intent)
        } catch (e: Exception) {
            Toast.makeText(context, "$appPackage Can't Be Found On Your Device", Toast.LENGTH_LONG).show()

            openPlayStore(appPackage);

        }
    }




    //Open Playstore if user does not have the app install
    private fun openPlayStore(appPackage: String) {
        //open with playstore app if installed
        try {
            var path = "market://details?id=$appPackage"
            var uri = Uri.parse(path)
            var intent = Intent(Intent.ACTION_VIEW, uri)
            startActivity(intent)

        } catch (e: ActivityNotFoundException) {
            //open with browser if playstore app is not installed
            var path = "https://play.google.com/store/apps/details?id=$appPackage"
            var uri = Uri.parse(path)
            var intent = Intent(Intent.ACTION_VIEW, uri)
            startActivity(intent)
        }
    }

    private fun shareImage(image: String?) {
//        var arr: Any = arrayOf(imageUri, "hello")
        var intent = Intent(Intent.ACTION_SEND)
        intent.type = "image/*"

        intent.putExtra(Intent.EXTRA_STREAM, Uri.parse(image))
        startActivity(Intent.createChooser(intent, "Share Image"))
    }

    private fun printImage(imageUri: String?, imageTitle: String?) {
        PrintHelper(this).apply {
            PrintHelper.SCALE_MODE_FIT
        }.also {
            var bitmap = BitmapFactory.decodeFile(imageUri)
            it.printBitmap(imageTitle!!, bitmap)
        }
    }
    
}
