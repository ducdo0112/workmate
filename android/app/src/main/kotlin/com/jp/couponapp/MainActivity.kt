package com.vn.workmate

import android.annotation.SuppressLint
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.nfc.NdefMessage
import android.nfc.NfcAdapter
import android.nfc.NfcManager
import android.nfc.Tag
import android.nfc.tech.Ndef
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.util.Log
import com.example.final_config_enviroment.Const
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.nio.charset.Charset
import kotlin.experimental.and

class MainActivity : FlutterActivity() {
    private val tag = "MainActivity"
    private val channel = "coupon/nfc"
    private var adapter: NfcAdapter? = null
    private var methodChannel: MethodChannel? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initNfcAdapter()
        resolveIntent(intent)
    }

    private fun initNfcAdapter() {
        val nfcManager = getSystemService(Context.NFC_SERVICE) as NfcManager
        adapter = nfcManager.defaultAdapter
    }

    override fun onResume() {
        super.onResume()
        enableNfcForegroundDispatch()
    }

    @SuppressLint("UnspecifiedImmutableFlag", "WrongConstant")
    private fun enableNfcForegroundDispatch() {
        try {
            val intent = Intent(this, javaClass).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
            val nfcPendingIntent = PendingIntent.getActivity(
                applicationContext,
                0,
                intent,
                PendingIntent.FLAG_MUTABLE
            )
            adapter?.enableForegroundDispatch(this, nfcPendingIntent, null, null)
        } catch (ex: IllegalStateException) {
            Log.e(tag, "Error enabling NFC foreground dispatch", ex)
        }
    }

    override fun onDestroy() {
        super.onDestroy()

    }

    override fun onPause() {
        super.onPause()
        disableNfcForegroundDispatch()
    }

    private fun disableNfcForegroundDispatch() {
        try {
            adapter?.disableForegroundDispatch(this)
        } catch (ex: IllegalStateException) {
            Log.e(tag, "Error disabling NFC foreground dispatch", ex)
        }
    }

    @Suppress("DEPRECATION")
    private fun resolveIntent(intent: Intent) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            getNfcMessageWithAndroid13(intent)
            return
        }

        val rawMsgs = intent.getParcelableArrayExtra(NfcAdapter.EXTRA_NDEF_MESSAGES)

        if (rawMsgs != null) {
            val msgs = arrayOfNulls<NdefMessage>(rawMsgs.size)
            for (i in rawMsgs.indices) {
                msgs[i] = rawMsgs[i] as NdefMessage
            }
            val msg = msgs[0]
            try {
                val nfcMessage = getNfcMessage(msg)
                nfcMessage?.let {
                    sendNfcIdToFlutterApp(it)
                }
            } catch (e: java.lang.Exception) {
                e.printStackTrace()
            }
        }
    }

    private fun getNfcMessageWithAndroid13(intent: Intent) {
        try {
            if (NfcAdapter.ACTION_NDEF_DISCOVERED == intent.action) {
                Thread {
                    val tag: Tag? = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG)
                    val ndefTag = Ndef.get(tag)
                    try {
                        ndefTag.connect() // this should already perform an IO operation and should therefore fail if there is no tag
                        val ndefMsg =
                            ndefTag.ndefMessage // this reads the current NDEF message from the tag and consequently causes an IO operation
                        if (ndefMsg != null) {
                            val mes = getNfcMessage(ndefMsg)
                            if (mes != null) {
                                Handler(Looper.getMainLooper()).post {
                                    sendNfcIdToFlutterApp(mes)
                                }
                            }
                        }
                    } catch (_: java.lang.Exception) {
                        ndefTag.close()
                    } finally {
                        try {
                            ndefTag.close()
                        } catch (_: java.lang.Exception) {
                        }
                    }
                }.start()
            }

        } catch (_: Exception) {
        }

    }

    private fun getNfcMessage(msgs: NdefMessage?): String? {
        msgs?.let {
            var textFromNfcTag: String? = ""
            val payload = msgs.records?.get(1)?.payload
            payload?.let {
                textFromNfcTag = tryGetDataWithNotConfigMimeType(it)
                if (textFromNfcTag.isNullOrEmpty()) {
                    textFromNfcTag = tryGetDataWithConfigMimeType(it)
                }
                return textFromNfcTag
            }
        }
        return null
    }

    private fun tryGetDataWithNotConfigMimeType(payload: ByteArray): String? {
        try {
            var textFromNfcTag = ""
            val textEncoding: Charset =
                if ((payload[0] and 128.toByte()).toInt() == 0) Charsets.UTF_8 else Charsets.UTF_16 // Get the Text Encoding
            val languageCodeLength: Int =
                (payload[0] and 51).toInt() // Get the Language Code, e.g. "en"
            // Get the Text
            textFromNfcTag = String(
                payload,
                languageCodeLength + 1,
                payload.size - languageCodeLength - 1,
                textEncoding
            )
            return textFromNfcTag
        } catch (e: Exception) {
            return null
        }
    }

    private fun tryGetDataWithConfigMimeType(payload: ByteArray): String? {
        try {
            return String(payload)
        } catch (e: Exception) {
            return null
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        resolveIntent(intent)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        )
    }

    private fun sendNfcIdToFlutterApp(id: String) {
        methodChannel?.invokeMethod(Const.nfcTagID, id)
    }
}
